package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"math"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/eval"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
	"github.com/zqzqsb/gosql/pkg/utils"
)

// 结果结构
type SQLResult struct {
	ID          int                    `json:"idx"`
	DBName      string                 `json:"db_id"`
	Question    string                 `json:"query"`
	Pred        string                 `json:"pred"`
	GroundTruth string                 `json:"ground_truth"`
	IsCorrect   bool                   `json:"is_correct"`
	Thinking    string                 `json:"thinking,omitempty"`
	DBSchema    string                 `json:"db_schema,omitempty"` // 数据库Schema信息
	Metadata    map[string]interface{} `json:"metadata,omitempty"`
	SequenceNum int                    `json:"sequence_num,omitempty"` // 处理顺序
}

var currentDBName string
var currentDataset *dataset.Dataset

func main() {
	// 命令行参数
	configPath := flag.String("config", "configs/config.yaml", "配置文件路径")
	datasetPath := flag.String("dataset", "", "数据集配置文件路径")
	datasetType := flag.String("dataset-type", "", "数据集类型 (spider, cspider)")
	split := flag.String("split", "test", "数据集分割 (train, dev, test)")
	outputDir := flag.String("output-dir", "results", "输出目录")
	provider := flag.String("provider", "", "LLM提供商 (openai, azure, gemini)")
	model := flag.String("model", "", "模型名称")
	startID := flag.Int("start", 0, "起始样例ID或索引")
	endID := flag.Int("end", -1, "结束样例ID或索引")
	targetID := flag.Int("id", -1, "目标样例ID")
	useIndex := flag.Bool("use-index", true, "使用样例索引而不是ID")
	disableThinking := flag.Bool("disable-thinking", false, "禁用思考过程")
	preserveChineseTerms := flag.Bool("preserve-chinese", true, "保留中文词汇不翻译")
	flag.Parse()

	// 检查必要参数
	if *datasetPath == "" && *datasetType == "" {
		fmt.Println("错误: 必须提供数据集配置文件路径 (--dataset) 或数据集类型 (--dataset-type)")
		flag.Usage()
		os.Exit(1)
	}

	// 加载配置
	cfg, err := config.LoadConfig(*configPath)
	if err != nil {
		fmt.Printf("加载配置失败: %v\n", err)
		os.Exit(1)
	}

	// 根据数据集类型设置数据集路径
	if *datasetPath == "" && *datasetType != "" {
		switch *datasetType {
		case "spider":
			*datasetPath = "configs/datasets/spider.json"
		case "cspider":
			*datasetPath = "configs/datasets/cspider.json"
		default:
			fmt.Printf("不支持的数据集类型: %s\n", *datasetType)
			os.Exit(1)
		}
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
	if *provider != "" {
		// 如果命令行指定了提供商，使用命令行参数
		modelName := *model
		client, err = factory.CreateWithProvider(llm.Provider(*provider), modelName)
	} else {
		// 否则使用配置文件中的默认设置
		client, err = factory.Create()
	}

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

	// 生成结果文件名
	timestamp := time.Now().Format("20060102_150405")
	modelName := client.ModelName()

	// 创建运行目录
	runDir := filepath.Join(*outputDir, fmt.Sprintf("%s_%s_%s_%s",
		currentDataset.Type, *split, modelName, timestamp))
	if err := os.MkdirAll(runDir, 0755); err != nil {
		fmt.Printf("创建运行目录失败: %v\n", err)
		os.Exit(1)
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
	var results []SQLResult
	for i, example := range processedExamples {
		fmt.Printf("处理样例 %d/%d...\n", i+1, len(processedExamples))

		// 获取当前数据库名称
		dbName, ok := example["db_id"].(string)
		if !ok {
			fmt.Printf("样例中没有数据库名称\n")
			continue
		}
		currentDBName = dbName

		// 生成SQL
		result := generateSQL(client, options, currentDataset, example)
		result.SequenceNum = i + 1 // 设置处理顺序
		results = append(results, result)

		// 保存结果
		saveResult(outputFp, result)

		// 输出结果
		printResult(result)
	}

	fmt.Printf("\n结果已保存到: %s\n", outputFile)

	// 生成预测文件
	generatePredictionFile(outputFile, *split, predFile)
}

// 获取样例ID
func getExampleID(example map[string]interface{}) int {
	var id int

	// 尝试不同的ID字段
	if idVal, ok := example["id"]; ok {
		switch v := idVal.(type) {
		case float64:
			id = int(v)
		case int:
			id = v
		case string:
			fmt.Sscanf(v, "%d", &id)
		}
	} else if idVal, ok := example["question_id"]; ok {
		switch v := idVal.(type) {
		case float64:
			id = int(v)
		case int:
			id = v
		case string:
			fmt.Sscanf(v, "%d", &id)
		}
	}

	// 对于C-Spider数据集，使用数组索引作为ID
	if id == 0 {
		if dbID, ok := example["db_id"].(string); ok {
			// 使用数据库ID和问题的组合作为唯一标识
			if question, ok := example["question"].(string); ok {
				// 创建一个简单的哈希作为ID
				id = int(stringHash(dbID + ":" + question))
			}
		}
	}

	return id
}

// 简单的字符串哈希函数
func stringHash(s string) uint32 {
	h := uint32(0)
	for i := 0; i < len(s); i++ {
		h = h*31 + uint32(s[i])
	}
	return h
}

// 生成SQL
func generateSQL(client llm.LLM, options llm.Options, ds *dataset.Dataset, example map[string]interface{}) SQLResult {
	// 提取样例信息
	id := getExampleID(example)

	question := ""
	if q, ok := example["question"].(string); ok {
		question = q
	}

	dbName := ""
	if db, ok := example["db_id"].(string); ok {
		dbName = db
	}

	query := ""
	if q, ok := example["query"].(string); ok {
		query = q
	}

	result := SQLResult{
		ID:          id,
		DBName:      dbName,
		Question:    question,
		GroundTruth: query,
		Metadata:    make(map[string]interface{}),
	}

	// 加载数据库Schema
	dbPath := filepath.Join(ds.BaseDir, ds.DBDir, dbName)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		fmt.Printf("加载数据库Schema失败: %v\n", err)
		result.Metadata["error"] = fmt.Sprintf("加载数据库Schema失败: %v", err)
		return result
	}

	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)

	// 保存数据库Schema信息
	result.DBSchema = schemaPrompt

	// 格式化提示
	prompt := utils.FormatPrompt(question, schemaPrompt)

	// 向LLM发送请求
	startTime := time.Now()
	response, err := client.GenerateSQL(prompt, options)
	elapsedTime := time.Since(startTime)

	if err != nil {
		fmt.Printf("向LLM发送请求失败: %v\n", err)
		result.Metadata["error"] = fmt.Sprintf("向LLM发送请求失败: %v", err)
		return result
	}

	// 设置结果
	result.Pred = response.Response

	// 提取思考过程
	thinkingStartTag := "<think>"
	thinkingEndTag := "</think>"

	thinkingStartIndex := strings.Index(response.Response, thinkingStartTag)
	if thinkingStartIndex != -1 {
		thinkingStartIndex += len(thinkingStartTag)
		thinkingEndIndex := strings.Index(response.Response[thinkingStartIndex:], thinkingEndTag)

		if thinkingEndIndex != -1 {
			result.Thinking = strings.TrimSpace(response.Response[thinkingStartIndex : thinkingStartIndex+thinkingEndIndex])
		}
	}

	// 如果从标签中没有提取到思考过程，则使用原始的思考过程
	if result.Thinking == "" {
		result.Thinking = response.Thinking
	}

	result.Metadata["execution_time"] = elapsedTime.Seconds()
	result.Metadata["prompt_tokens"] = response.PromptTokens
	result.Metadata["response_tokens"] = response.ResponseTokens
	result.Metadata["total_tokens"] = response.TotalTokens

	// 判断预测的SQL与标准答案是否一致
	result.IsCorrect = isEquivalentSQL(result.Pred, result.GroundTruth)

	return result
}

// 保存结果
func saveResult(file *os.File, result SQLResult) {
	data, err := json.Marshal(result)
	if err != nil {
		fmt.Printf("序列化结果失败: %v\n", err)
		return
	}

	_, err = file.Write(data)
	if err != nil {
		fmt.Printf("写入结果失败: %v\n", err)
		return
	}

	_, err = file.WriteString("\n")
	if err != nil {
		fmt.Printf("写入换行符失败: %v\n", err)
		return
	}
}

// 输出结果
func printResult(result SQLResult) {
	fmt.Printf("\n问题: %s\n", result.Question)
	fmt.Printf("生成的SQL: %s\n", result.Pred)
	fmt.Printf("标准SQL: %s\n", result.GroundTruth)

	if execTime, ok := result.Metadata["execution_time"].(float64); ok {
		fmt.Printf("执行时间: %.2f秒\n", execTime)
	}

	if promptTokens, ok := result.Metadata["prompt_tokens"].(float64); ok {
		fmt.Printf("Token使用: 提示=%d", int(promptTokens))

		if responseTokens, ok := result.Metadata["response_tokens"].(float64); ok {
			fmt.Printf(", 响应=%d", int(responseTokens))
		}

		if totalTokens, ok := result.Metadata["total_tokens"].(float64); ok {
			fmt.Printf(", 总计=%d", int(totalTokens))
		}

		fmt.Println()
	}

	fmt.Println("----------------------------------------")
}

// 生成预测文件
func generatePredictionFile(jsonlFile string, split string, predFile string) {
	// 读取JSONL文件
	data, err := os.ReadFile(jsonlFile)
	if err != nil {
		fmt.Printf("读取结果文件失败: %v\n", err)
		return
	}

	// 解析JSONL
	var results []SQLResult
	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		if line == "" {
			continue
		}

		var result SQLResult
		if err := json.Unmarshal([]byte(line), &result); err != nil {
			fmt.Printf("解析结果行失败: %v\n", err)
			continue
		}

		results = append(results, result)
	}

	// 排序结果
	sort.Slice(results, func(i, j int) bool {
		return results[i].SequenceNum < results[j].SequenceNum
	})

	// 生成SQL文件
	var sqlLines []string
	for _, result := range results {
		// 将SQL查询中的换行符替换为空格，确保每个查询只占一行
		sql := strings.ReplaceAll(result.Pred, "\n", " ")
		// 移除多余的空格
		sql = strings.Join(strings.Fields(sql), " ")
		sqlLines = append(sqlLines, sql)
	}

	// 检查SQL语句数量是否与info.jsonl中的记录数一致
	if len(sqlLines) != len(results) {
		fmt.Printf("警告：SQL语句数量(%d)与结果记录数(%d)不一致\n", len(sqlLines), len(results))
	}

	err = os.WriteFile(predFile, []byte(strings.Join(sqlLines, "\n")), 0644)
	if err != nil {
		fmt.Printf("写入SQL文件失败: %v\n", err)
		return
	}

	fmt.Printf("预测文件已保存到: %s\n", predFile)
}

// 判断两个SQL语句是否等价（通过比较执行结果）
func isEquivalentSQL(sql1 string, sql2 string) bool {
	// 如果SQL语句完全相同（忽略大小写和空格），则认为它们等价
	if normalizeSQL(sql1) == normalizeSQL(sql2) {
		return true
	}

	// 获取当前正在处理的数据库路径
	dbName := currentDBName
	if dbName == "" {
		// 如果没有当前数据库名称，则无法执行SQL查询
		return false
	}

	// 构建数据库路径
	dbPath := filepath.Join(currentDataset.BaseDir, currentDataset.DBDir, dbName)

	// 检查数据库文件是否存在
	sqlitePath := filepath.Join(dbPath, dbName+".sqlite")
	if _, err := os.Stat(sqlitePath); os.IsNotExist(err) {
		// 尝试直接使用 dbName.sqlite 文件
		altDbPath := filepath.Join(filepath.Dir(dbPath), dbName+".sqlite")
		if _, err := os.Stat(altDbPath); os.IsNotExist(err) {
			fmt.Printf("数据库文件不存在: %s\n", sqlitePath)
			// 如果数据库文件不存在，则回退到文本比较
			return false
		}
		// 使用替代路径
		sqlitePath = altDbPath
	}

	// 执行两个SQL查询
	result1, err1 := eval.ExecSQL(sqlitePath, sql1)
	result2, err2 := eval.ExecSQL(sqlitePath, sql2)

	// 如果任一查询执行失败，则认为它们不等价
	if err1 != nil || err2 != nil {
		fmt.Printf("SQL执行错误: %v, %v\n", err1, err2)
		return false
	}

	if !result1.Success || !result2.Success {
		fmt.Printf("SQL执行不成功: %v, %v\n", result1.Error, result2.Error)
		return false
	}

	// 比较结果行数（不包括列名行）
	if len(result1.Rows) != len(result2.Rows) {
		fmt.Printf("结果行数不同: %d vs %d\n", len(result1.Rows), len(result2.Rows))
		return false
	}

	// 如果只有列名行，则认为结果为空，此时两个查询等价
	if len(result1.Rows) == 1 {
		return true
	}

	// 比较结果内容（忽略列名）
	for i := 1; i < len(result1.Rows); i++ {
		if len(result1.Rows[i]) != len(result2.Rows[i]) {
			fmt.Printf("行 %d 的列数不同: %d vs %d\n", i, len(result1.Rows[i]), len(result2.Rows[i]))
			return false
		}

		// 比较每一行的内容
		for j := 0; j < len(result1.Rows[i]); j++ {
			// 尝试将字符串转换为数字进行比较
			val1 := strings.TrimSpace(result1.Rows[i][j])
			val2 := strings.TrimSpace(result2.Rows[i][j])

			// 如果两个值完全相同，则继续比较下一个值
			if val1 == val2 {
				continue
			}

			// 尝试将值转换为浮点数进行比较
			float1, err1 := strconv.ParseFloat(val1, 64)
			float2, err2 := strconv.ParseFloat(val2, 64)
			if err1 == nil && err2 == nil {
				// 如果两个浮点数相等（允许一定的误差），则继续比较下一个值
				if math.Abs(float1-float2) < 1e-10 {
					continue
				}
			}

			// 如果值不相等，则认为两个查询不等价
			fmt.Printf("行 %d 列 %d 的值不同: '%s' vs '%s'\n", i, j, val1, val2)
			return false
		}
	}

	fmt.Println("SQL查询等价")
	// 所有检查都通过，认为两个SQL查询等价
	return true
}

// 标准化SQL语句
func normalizeSQL(sql string) string {
	// 转换为小写
	sql = strings.ToLower(sql)

	// 移除分号
	sql = strings.TrimSuffix(sql, ";")

	// 移除多余的空格
	sql = strings.Join(strings.Fields(sql), " ")

	return sql
}
