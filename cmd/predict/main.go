package main

import (
	"bufio"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/agents/query_validator"
	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/erroranalysis"
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
	ErrorReason string                 `json:"error_reason,omitempty"`
	Thinking    string                 `json:"thinking,omitempty"`
	DBSchema    string                 `json:"db_schema,omitempty"` // 数据库Schema信息
	Metadata    map[string]interface{} `json:"metadata,omitempty"`
	SequenceNum int                    `json:"sequence_num,omitempty"` // 处理顺序
}

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

	// 检查和打印字段信息类型
	if options.FieldsInfoType != "" {
		if options.FieldsInfoType == "fields" || options.FieldsInfoType == "description" {
			fmt.Printf("启用字段信息类型: %s\n", options.FieldsInfoType)
		} else {
			fmt.Printf("警告: 不支持的字段信息类型 %s，将不使用字段信息\n", options.FieldsInfoType)
			options.FieldsInfoType = ""
		}
	}

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
	generatePredictionFile(outputFile,  predFile)

	// 统计评测指标
	fmt.Println(strings.Repeat("=", 50))
	fmt.Println("评测指标:")
	fmt.Printf("总样例数: %d\n", len(results))
	fmt.Printf("模糊查询数: %d (%.2f%%)\n", ambiguousQueriesCount, float64(ambiguousQueriesCount)*100/float64(len(results)))
	fmt.Printf("有效样例数: %d (排除模糊查询)\n", len(results)-ambiguousQueriesCount)

	if len(results)-ambiguousQueriesCount > 0 {
		correctCount := 0
		for _, result := range results {
			if result.Pred != "AMBIGUOUS_QUERY" && result.IsCorrect {
				correctCount++
			}
		}
		fmt.Printf("正确样例数: %d\n", correctCount)
		fmt.Printf("准确率: %.2f%%\n", float64(correctCount)*100/float64(len(results)-ambiguousQueriesCount))
	}
	fmt.Println(strings.Repeat("=", 50))
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

	// 获取数据库ID和问题
	dbID, _ := example["db_id"].(string)
	question, _ := example["question"].(string)

	// 创建QueryValidator检测模糊查询
	validator := query_validator.NewQueryValidator()
	validator.WithLLM(client) // 使用同一个LLM客户端

	// 检测查询是否模糊
	isAmbiguous, ambiguousType, confidence := validator.DetectAmbiguity(context.Background(), question)

	// 如果是模糊查询，返回特殊的SQLResult
	if isAmbiguous {
		ambiguousQueriesCount++ // 增加模糊查询计数

		// 获取澄清问题
		clarificationQuestions := query_validator.GenerateClarificationQuestions(question)

		return SQLResult{
			ID:          id,
			DBName:      dbID,
			Question:    question,
			Pred:        "AMBIGUOUS_QUERY", // 特殊标记
			GroundTruth: example["query"].(string),
			IsCorrect:   false,
			ErrorReason: "模糊查询需要澄清",
			Metadata: map[string]interface{}{
				"is_ambiguous":            true,
				"ambiguous_type":          ambiguousType,
				"confidence":              confidence,
				"clarification_questions": clarificationQuestions,
			},
		}
	}

	// 如果不是模糊查询，继续正常处理
	question = example["question"].(string)

	result := SQLResult{
		ID:          id,
		DBName:      dbID,
		Question:    question,
		GroundTruth: example["query"].(string),
		Metadata:    make(map[string]interface{}),
	}

	// 加载数据库Schema
	dbPath := filepath.Join(ds.BaseDir, ds.DBDir, dbID)
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

	// 检查是否是PostgreSQL数据库并且数据里包含字段信息
	useFieldsInfo := usePostgreSQL && options.FieldsInfoType != ""

	// 参数初始化
	var fieldsInfo string
	useDescription := false

	// 如果启用字段信息
	if useFieldsInfo && example != nil {
		// 检查result_fields和result_fields_description字段
		switch options.FieldsInfoType {
		case "fields":
			// 使用精确字段列表
			if fields, ok := example["result_fields"].([]interface{}); ok && len(fields) > 0 {
				// 将字段转换为字符串
				fieldStrs := make([]string, 0, len(fields))
				for _, f := range fields {
					if fs, ok := f.(string); ok {
						fieldStrs = append(fieldStrs, fs)
					}
				}
				fieldsInfo = strings.Join(fieldStrs, ", ")
				useDescription = false

				// 添加到元数据
				result.Metadata["fields_info_type"] = "fields"
				result.Metadata["fields_info"] = fieldsInfo
			}
		case "description":
			// 使用字段描述
			if description, ok := example["result_fields_description"].(string); ok && description != "" {
				fieldsInfo = description
				useDescription = true

				// 添加到元数据
				result.Metadata["fields_info_type"] = "description"
				result.Metadata["fields_info"] = fieldsInfo
			}
		}
	}

	// 格式化提示
	var prompt string
	if useFieldsInfo && fieldsInfo != "" {
		prompt = utils.FormatPromptWithFields(question, schemaPrompt, fieldsInfo, useDescription)
		fmt.Printf("使用字段%s: %s\n",
			map[bool]string{true: "描述", false: "列表"}[useDescription],
			fieldsInfo)
	} else {
		prompt = utils.FormatPrompt(question, schemaPrompt)
	}

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
	// 重新构建数据库路径
	// 使用=而非:=，因为dbPath已经在函数前面声明过
	dbPath = filepath.Join(ds.BaseDir, ds.DBDir, dbID)

	// 根据数据库类型决定路径
	var fullDBPath string

	if usePostgreSQL {
		// PostgreSQL模式直接使用特殊前缀路径
		fullDBPath = "pg:" + dbID
	} else if strings.Contains(dbPath, "ccsipder_pg") || strings.Contains(dbPath, "ccspider_pg") ||
		strings.Contains(dbPath, "pg_hr") || strings.Contains(dbPath, "postgres_") {
		// 对于具有 PostgreSQL 特征的路径，也使用 PostgreSQL 模式
		fullDBPath = dbPath
	} else {
		// SQLite模式需要检查文件是否存在
		sqlitePath := filepath.Join(dbPath, dbID+".sqlite")
		if _, err := os.Stat(sqlitePath); os.IsNotExist(err) {
			// 尝试直接使用 dbName.sqlite 文件
			altDbPath := filepath.Join(filepath.Dir(dbPath), dbID+".sqlite")
			// 使用赋值而非声明，因为err已经在上文中声明
			if _, err = os.Stat(altDbPath); os.IsNotExist(err) {
				result.IsCorrect = false
				result.ErrorReason = "数据库文件不存在"
				return result
			}
			// 使用替代路径
			fullDBPath = altDbPath
		} else {
			fullDBPath = sqlitePath
		}
	}

	// 使用统一的错误分析包判断SQL等价性
	result.IsCorrect, result.ErrorReason = erroranalysis.IsEquivalentSQL(fullDBPath, result.Pred, result.GroundTruth)

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

	if !result.IsCorrect {
		fmt.Printf("错误原因: %s\n", result.ErrorReason)
	}

	fmt.Println("----------------------------------------")
}

// 生成预测文件
func generatePredictionFile(jsonlFile string, predFile string) {
	var results []SQLResult

	// 读取jsonl文件
	file, err := os.Open(jsonlFile)
	if err != nil {
		fmt.Printf("打开%s失败: %v\n", jsonlFile, err)
		return
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		var result SQLResult
		if err := json.Unmarshal([]byte(line), &result); err != nil {
			fmt.Printf("解析行失败: %v\n", err)
			continue
		}
		results = append(results, result)
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("读取文件失败: %v\n", err)
		return
	}

	// 生成预测文件
	predFileObj, err := os.Create(predFile)
	if err != nil {
		fmt.Printf("创建预测文件失败: %v\n", err)
		return
	}
	defer predFileObj.Close()

	for _, result := range results {
		if result.Pred == "AMBIGUOUS_QUERY" {
			// 对于模糊查询，写入特殊标记
			fmt.Fprintf(predFileObj, "AMBIGUOUS_QUERY\t%d\n", result.ID)
		} else {
			fmt.Fprintf(predFileObj, "%s\t%d\n", result.Pred, result.ID)
		}
	}

	fmt.Printf("预测文件已保存到: %s\n", predFile)

	// 创建sql_results子文件夹
	resultDir := filepath.Dir(jsonlFile)
	sqlResultsDir := filepath.Join(resultDir, "sql_results")
	if _, err := os.Stat(sqlResultsDir); os.IsNotExist(err) {
		if err := os.MkdirAll(sqlResultsDir, 0755); err != nil {
			fmt.Printf("创建SQL结果目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 创建错误SQL查询目录
	incorrectQueriesDir := filepath.Join(resultDir, "incorrect_queries")
	if _, err := os.Stat(incorrectQueriesDir); os.IsNotExist(err) {
		if err := os.MkdirAll(incorrectQueriesDir, 0755); err != nil {
			fmt.Printf("创建错误SQL查询目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 创建模糊问题目录
	ambiguousQueriesDir := filepath.Join(resultDir, "ambiguous_queries")
	if _, err := os.Stat(ambiguousQueriesDir); os.IsNotExist(err) {
		if err := os.MkdirAll(ambiguousQueriesDir, 0755); err != nil {
			fmt.Printf("创建模糊问题目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 为每条SQL生成执行结果文件
	for _, result := range results {
		if result.DBName == "" {
			continue // 跳过没有数据库名称的结果
		}

		// 构建数据库路径
		dbPath := filepath.Join(currentDataset.BaseDir, currentDataset.DBDir, result.DBName)
		var fullDBPath string

		// 根据数据库类型决定路径
		if usePostgreSQL {
			// PostgreSQL模式直接使用特殊前缀路径
			fullDBPath = "pg:" + result.DBName
			fmt.Printf("评估使用 PostgreSQL 模式，数据库: %s\n", result.DBName)
		} else if strings.Contains(dbPath, "ccsipder_pg") || strings.Contains(dbPath, "ccspider_pg") ||
			strings.Contains(dbPath, "pg_hr") || strings.Contains(dbPath, "postgres_") {
			// 对于具有 PostgreSQL 特征的路径，也使用 PostgreSQL 模式
			fullDBPath = dbPath
			fmt.Printf("评估检测到 PostgreSQL 路径特征: %s\n", dbPath)
		} else {
			// SQLite模式需要检查文件是否存在
			sqlitePath := filepath.Join(dbPath, result.DBName+".sqlite")
			if _, err := os.Stat(sqlitePath); os.IsNotExist(err) {
				// 尝试直接使用 dbName.sqlite 文件
				altDbPath := filepath.Join(filepath.Dir(dbPath), result.DBName+".sqlite")
				if _, err := os.Stat(altDbPath); os.IsNotExist(err) {
					fmt.Printf("数据库文件不存在: %s，跳过生成SQL结果\n", sqlitePath)
					continue
				}
				// 使用替代路径
				fullDBPath = altDbPath
			} else {
				fullDBPath = sqlitePath
			}
		}

		// 执行预测的SQL和标准SQL
		var predResult *eval.ExecResult
		var predErr error
		var sqlResultData map[string]interface{}

		// 对于非模糊查询，执行SQL并评估结果
		if result.Pred != "AMBIGUOUS_QUERY" {
			predResult, predErr = eval.ExecSQL(fullDBPath, result.Pred)
			gtResult, gtErr := eval.ExecSQL(fullDBPath, result.GroundTruth)

			// 构建结果JSON
			sqlResultData = map[string]interface{}{
				"id":            result.ID,
				"db_id":         result.DBName,
				"question":      result.Question,
				"pred_sql":      result.Pred,
				"gt_sql":        result.GroundTruth,
				"pred_result":   nil,
				"pred_error":    nil,
				"gt_result":     nil,
				"gt_error":      nil,
				"is_equivalent": false,
				"is_correct":    result.IsCorrect,
				"error_reason":  result.ErrorReason,
			}

			// 添加预测SQL的执行结果
			if predErr != nil {
				sqlResultData["pred_error"] = predErr.Error()
			} else {
				sqlResultData["pred_result"] = predResult
			}

			// 添加标准SQL的执行结果
			if gtErr != nil {
				sqlResultData["gt_error"] = gtErr.Error()
			} else {
				sqlResultData["gt_result"] = gtResult
			}

			// 判断两个SQL是否等价
			if predErr == nil && gtErr == nil && predResult.Success && gtResult.Success {
				// 使用统一的错误分析包判断SQL等价性
				var isEquiv bool
				isEquiv, _ = erroranalysis.IsEquivalentSQL(fullDBPath, result.Pred, result.GroundTruth)
				sqlResultData["is_equivalent"] = isEquiv
			}
		} else {
			// 对于模糊查询，不执行SQL
			sqlResultData = map[string]interface{}{
				"id":           result.ID,
				"db_id":        result.DBName,
				"question":     result.Question,
				"pred":         result.Pred,
				"ground_truth": result.GroundTruth,
				"is_correct":   result.IsCorrect,
				"error_reason": result.ErrorReason,
				"is_ambiguous": true,
			}

			// 添加模糊查询的元数据
			if len(result.Metadata) > 0 {
				sqlResultData["metadata"] = result.Metadata
			}
		}

		// 如果存在思考过程，添加到结果中
		if result.Thinking != "" {
			sqlResultData["thinking"] = result.Thinking
		}

		// 创建结果文件
		resultFileName := fmt.Sprintf("%d.json", result.ID)
		resultFilePath := filepath.Join(sqlResultsDir, resultFileName)

		// 写入结果文件
		resultJSON, err := json.MarshalIndent(sqlResultData, "", "  ")
		if err != nil {
			fmt.Printf("序列化SQL结果失败: %v\n", err)
			continue
		}

		if err := os.WriteFile(resultFilePath, resultJSON, 0644); err != nil {
			fmt.Printf("写入SQL结果文件失败: %v\n", err)
			continue
		}

		// 如果是模糊查询，保存到模糊问题目录
		if result.Pred == "AMBIGUOUS_QUERY" {
			ambiguousFilePath := filepath.Join(ambiguousQueriesDir, fmt.Sprintf("ambiguous_%d.json", result.ID))
			if err := os.WriteFile(ambiguousFilePath, resultJSON, 0644); err != nil {
				fmt.Printf("写入模糊问题文件失败: %v\n", err)
			}
		}

		// 如果SQL查询不正确且不是模糊查询，保存到错误SQL查询目录
		if !result.IsCorrect && result.Pred != "AMBIGUOUS_QUERY" {
			incorrectFilePath := filepath.Join(incorrectQueriesDir, fmt.Sprintf("incorrect_%d.json", result.ID))
			if err := os.WriteFile(incorrectFilePath, resultJSON, 0644); err != nil {
				fmt.Printf("写入错误SQL查询文件失败: %v\n", err)
			}
		}
	}

	fmt.Printf("SQL执行结果已保存到: %s\n", sqlResultsDir)
	fmt.Printf("错误SQL查询结果已保存到: %s\n", incorrectQueriesDir)
	fmt.Printf("模糊问题结果已保存到: %s\n", ambiguousQueriesDir)
}
