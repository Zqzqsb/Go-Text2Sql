package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
)

var currentDataset *dataset.Dataset
var ambiguousQueriesCount int // 统计模糊查询数量
var usePostgreSQL bool        // 是否使用PostgreSQL

func main() {
	// 命令行参数
	llmConfigPath := flag.String("config", "", "LLM 接入点配置文件")
	datasetPath := flag.String("dataset", "", "数据集配置文件路径")
	split := flag.String("split", "test", "数据集分割 (train, dev, test)")
	outputDir := flag.String("output-dir", "results", "输出目录")
	startID := flag.Int("start", 0, "起始样例ID或索引")
	endID := flag.Int("end", -1, "结束样例ID或索引")
	targetID := flag.Int("id", -1, "目标样例ID")
	useIndex := flag.Bool("use-index", true, "使用样例索引而不是ID")
	disableThinking := flag.Bool("disable-thinking", false, "禁用思考过程")
	preserveChineseTerms := flag.Bool("preserve-chinese", true, "保留中文词汇不翻译")
	dbType := flag.String("db-type", "sqlite", "数据库类型 (sqlite, postgres)")
	fieldsInfoType := flag.String("fields-info-type", "", "字段信息类型 (empty, fields, description)")
	interactiveMode := flag.Bool("interactive", true, "启用交互式 SQL 生成模式")
	maxQueryRows := flag.Int("max-query-rows", 100, "交互式模式下每个查询最大返回行数")
	expandSchema := flag.Bool("expand-schema", false, "在日志中完整显示schema信息")
	verboseDebug := flag.Bool("verbose-debug", false, "输出详细的调试信息（完整prompt和LLM响应）")

	flag.Parse()

	// 检查数据库类型
	usePostgreSQL = strings.ToLower(*dbType) == "postgres" || strings.ToLower(*dbType) == "postgresql"
	if usePostgreSQL {
		fmt.Println("使用PostgreSQL数据库")
	} else {
		fmt.Println("使用SQLite数据库")
	}

	// 检查必要参数
	if *datasetPath == "" {
		fmt.Println("错误: 必须提供数据集配置文件路径 (--dataset)")
		flag.Usage()
		os.Exit(1)
	}

	// 加载配置
	cfg, err := config.LoadConfig(*llmConfigPath)
	if err != nil {
		fmt.Printf("加载配置失败: %v\n", err)
		os.Exit(1)
	}

	// 加载数据集
	currentDataset, err = dataset.LoadFromFile(*datasetPath)
	if err != nil {
		fmt.Printf("加载数据集配置失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("数据集: 类型=%s, 名称=%s\n", currentDataset.Type, currentDataset.Name)

	// 加载样例
	var examples []map[string]interface{}
	switch *split {
	case "train":
		examples, err = currentDataset.LoadTrainExamples()
	case "dev":
		examples, err = currentDataset.LoadDevExamples()
	case "test":
		examples, err = currentDataset.LoadTestExamples()
	default:
		fmt.Printf("不支持的数据集分割: %s\n", *split)
		os.Exit(1)
	}

	if err != nil {
		fmt.Printf("加载%s样例失败: %v\n", *split, err)
		os.Exit(1)
	}

	fmt.Printf("%s样例数量: %d\n", *split, len(examples))

	// 创建LLM工厂
	factory := llm.NewLLMFactory(cfg)

	// 创建LLM客户端
	var client llm.LLM

	client, err = factory.Create()
	if err != nil {
		fmt.Printf("创建LLM客户端失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("LLM客户端: 提供商=%s, 模型=%s\n\n",
		client.Provider(), client.ModelName())

	// 设置选项
	options := factory.GetDefaultOptions()
	options.DisableThinking = *disableThinking
	options.PreserveChineseTerms = *preserveChineseTerms
	options.FieldsInfoType = *fieldsInfoType
	options.VerboseDebug = *verboseDebug

	// 创建输出目录
	runID := fmt.Sprintf("%s_%s", currentDataset.Name, *split)
	if usePostgreSQL {
		runID += "_pg"
	}
	if *interactiveMode {
		runID += "_interactive"
	}
	if *fieldsInfoType != "" {
		runID += "_with_" + *fieldsInfoType + "_info"
	} else {
		runID += "_with_no_field_info"
	}

	runDir := filepath.Join(*outputDir, runID)
	if _, err := os.Stat(runDir); os.IsNotExist(err) {
		if err := os.MkdirAll(runDir, 0755); err != nil {
			fmt.Printf("创建运行目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 结果文件路径
	outputFile := filepath.Join(runDir, "info.jsonl")
	predFile := filepath.Join(runDir, "pred.sql")

	// 打开结果文件
	outputFp, err := os.Create(outputFile)
	if err != nil {
		fmt.Printf("创建结果文件失败: %v\n", err)
		os.Exit(1)
	}
	defer outputFp.Close()

	// 处理样例
	var processedExamples []map[string]interface{}

	// 如果指定了目标ID，只处理该ID的样例
	if *targetID >= 0 {
		for _, example := range examples {
			id := getExampleID(example)
			if id == *targetID {
				processedExamples = append(processedExamples, example)
				break
			}
		}
		if len(processedExamples) == 0 {
			fmt.Printf("未找到目标样例 ID=%d\n", *targetID)
			os.Exit(1)
		}
	} else {
		// 否则处理范围内的样例
		for i, example := range examples {
			if *useIndex {
				if i < *startID {
					continue
				}
				if *endID >= 0 && i > *endID {
					continue
				}
			} else {
				id := getExampleID(example)
				if id < *startID {
					continue
				}
				if *endID >= 0 && id > *endID {
					continue
				}
			}
			processedExamples = append(processedExamples, example)
		}
	}

	fmt.Printf("将处理 %d 个样例\n", len(processedExamples))

	// 处理样例
	ambiguousQueriesCount = 0 // 重置模糊查询计数

	// 如果启用交互式模式，创建交互式生成器
	if *interactiveMode {
		fmt.Printf("使用交互式 SQL 生成模式 (最大查询行数: %d)\n", *maxQueryRows)
		// 创建交互式生成器
		generator := NewInteractiveGenerator(client, *maxQueryRows)
		generator.SetExpandSchema(*expandSchema)

		for i, example := range processedExamples {
			fmt.Printf("处理样例 %d/%d...\n", i+1, len(processedExamples))

			// 使用交互式生成
			interactiveResult := generator.GenerateInteractiveSQL(currentDataset, example, options)

			// 检查是否为模糊查询
			if interactiveResult.Ambiguous == "True" {
				ambiguousQueriesCount++
			}

			// 保存交互式结果
			saveInteractiveResult(outputFp, interactiveResult)

			// 输出结果
			printInteractiveResult(interactiveResult)
		}
	} else {
		// 生成SQL
		for i, example := range processedExamples {
			fmt.Printf("处理样例 %d/%d...\n", i+1, len(processedExamples))

			result := generateSQL(client, options, currentDataset, example)

			// 检查是否为模糊查询
			if result.Ambiguous == "True" {
				ambiguousQueriesCount++
			}

			// 保存结果
			saveResult(outputFp, result)

			// 输出结果
			printResult(result)
		}
	}

	fmt.Printf("\n结果已保存到: %s\n", outputFile)

	// 生成预测文件
	generatePredictionFile(outputFile, predFile)

	fmt.Printf("\n总共处理了 %d 个样例，其中 %d 个是模糊查询\n",
		len(processedExamples), ambiguousQueriesCount)
}
