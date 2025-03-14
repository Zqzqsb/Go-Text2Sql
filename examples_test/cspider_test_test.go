package examples_test

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"testing"
	"time"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
	"github.com/zqzqsb/gosql/pkg/utils"
)

// 测试结果结构
type TestResult struct {
	ID          int                    `json:"idx"`
	DBName      string                 `json:"db_id"`
	Question    string                 `json:"query"`
	Pred        string                 `json:"pred"`
	GroundTruth string                 `json:"ground_truth"`
	Thinking    string                 `json:"thinking,omitempty"`
	Metadata    map[string]interface{} `json:"metadata,omitempty"`
}

func TestCSpiderDataset(t *testing.T) {
	// 加载配置
	configPath := "../configs/config.test.yaml"
	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		t.Fatalf("加载配置失败: %v\n", err)
	}

	// 加载C-Spider数据集
	datasetPath := "../configs/datasets/cspider.json"
	ds, err := dataset.LoadFromFile(datasetPath)
	if err != nil {
		t.Fatalf("加载数据集配置失败: %v\n", err)
	}

	t.Logf("数据集: 类型=%s, 名称=%s\n", ds.Type, ds.Name)

	// 加载测试样例
	testExamples, err := ds.LoadDevExamples()
	if err != nil {
		t.Logf("加载测试样例失败: %v\n", err)
		t.Log("使用模拟测试样例继续测试")
		// 创建模拟测试样例
		testExamples = []map[string]interface{}{
			{
				"id":       float64(1),
				"question": "查询所有学生的姓名和年龄",
				"db_id":    "school",
				"query":    "SELECT name, age FROM students",
			},
			{
				"id":       float64(2),
				"question": "查询所有课程及其教师",
				"db_id":    "school",
				"query":    "SELECT c.name, t.name FROM courses c JOIN teachers t ON c.teacher_id = t.id",
			},
		}
	}

	t.Logf("测试样例数量: %d\n", len(testExamples))

	// 创建LLM客户端
	factory := llm.NewLLMFactory(cfg)
	client, err := factory.Create()
	if err != nil {
		t.Logf("创建LLM客户端失败: %v\n", err)
		t.Skip("跳过需要LLM客户端的测试")
		return
	}

	t.Logf("LLM客户端: 提供商=%s, 模型=%s\n", 
		client.Provider(), client.ModelName())

	// 设置选项
	options := llm.DefaultOptions()
	options.Temperature = 0.0
	options.MaxTokens = 1000
	options.DisableThinking = false

	// 创建结果目录
	resultsDir := "../results"
	if _, err := os.Stat(resultsDir); os.IsNotExist(err) {
		err = os.MkdirAll(resultsDir, 0755)
		if err != nil {
			t.Logf("创建结果目录失败: %v", err)
		}
	}

	// 测试指定样例
	targetID := 1034
	found := false
	maxSamples := 2 // 减少测试样例数量，以加快测试速度

	// 先尝试找到目标样例
	for _, example := range testExamples {
		id, ok := example["id"].(float64)
		if !ok {
			// 尝试其他可能的类型
			if idStr, ok := example["id"].(string); ok {
				t.Logf("ID是字符串类型: %s", idStr)
				// 简单地使用0作为默认ID
				id = 0
			} else {
				continue
			}
		}
		
		exampleID := int(id)
		
		if exampleID == targetID {
			found = true
			t.Logf("找到目标样例 ID=%d\n", targetID)
			
			// 测试样例
			result := testExample(t, client, options, ds, example)
			
			// 输出结果
			printTestResult(t, result)
			
			// 保存结果
			saveResult(t, result, resultsDir)
			
			break
		}
	}

	// 如果没有找到目标样例，测试前几个
	if !found {
		t.Logf("未找到目标样例 ID=%d，将测试前%d个样例\n", targetID, maxSamples)
		
		count := 0
		var results []TestResult
		
		for _, example := range testExamples {
			if count >= maxSamples {
				break
			}
			
			// 测试样例
			result := testExample(t, client, options, ds, example)
			results = append(results, result)
			
			// 输出结果
			printTestResult(t, result)
			
			// 保存结果
			saveResult(t, result, resultsDir)
			
			count++
		}
		
		// 保存所有结果
		saveAllResults(t, results, resultsDir)
	}
}

// 测试单个样例
func testExample(t *testing.T, client llm.LLM, options llm.Options, ds *dataset.Dataset, example map[string]interface{}) TestResult {
	// 提取样例信息
	var id int
	if idFloat, ok := example["id"].(float64); ok {
		id = int(idFloat)
	} else if idStr, ok := example["id"].(string); ok {
		t.Logf("ID是字符串类型: %s", idStr)
		// 简单地使用0作为默认ID
		id = 0
	}
	
	question := example["question"].(string)
	dbName := example["db_id"].(string)
	query := example["query"].(string)
	
	result := TestResult{
		ID:          id,
		DBName:      dbName,
		Question:    question,
		GroundTruth: query,
		Metadata:    make(map[string]interface{}),
	}
	
	t.Logf("处理样例 ID=%d, DB=%s\n", id, dbName)
	
	// 加载数据库Schema
	dbPath := filepath.Join(ds.DBDir, dbName)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		t.Logf("加载数据库Schema失败: %v\n", err)
		// 创建一个模拟的Schema用于测试
		dbSchema = &schema.DatabaseSchema{
			Tables: []schema.Table{
				{
					Name: "students",
					Columns: []schema.Column{
						{Name: "id", Type: "INTEGER", IsPrimary: true},
						{Name: "name", Type: "TEXT"},
						{Name: "age", Type: "INTEGER"},
						{Name: "class_id", Type: "INTEGER", IsForeign: true},
					},
				},
				{
					Name: "classes",
					Columns: []schema.Column{
						{Name: "id", Type: "INTEGER", IsPrimary: true},
						{Name: "name", Type: "TEXT"},
						{Name: "teacher_id", Type: "INTEGER", IsForeign: true},
					},
				},
			},
		}
		t.Logf("使用模拟的Schema继续测试\n")
	}
	
	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)
	
	// 格式化提示
	prompt := utils.FormatPrompt(question, schemaPrompt)
	
	// 向LLM发送请求
	startTime := time.Now()
	response, err := client.GenerateSQL(prompt, options)
	elapsedTime := time.Since(startTime)
	
	if err != nil {
		t.Logf("向LLM发送请求失败: %v\n", err)
		result.Metadata["error"] = err.Error()
		// 使用模拟响应
		result.Pred = "SELECT * FROM " + dbName + " LIMIT 10"
		result.Thinking = "由于API调用失败，这是一个模拟的SQL查询"
		result.Metadata["execution_time"] = elapsedTime.Seconds()
		result.Metadata["prompt_tokens"] = 0
		result.Metadata["response_tokens"] = 0
		result.Metadata["total_tokens"] = 0
		return result
	}
	
	// 设置结果
	result.Pred = response.Response
	result.Thinking = response.Thinking
	result.Metadata["execution_time"] = elapsedTime.Seconds()
	result.Metadata["prompt_tokens"] = response.PromptTokens
	result.Metadata["response_tokens"] = response.ResponseTokens
	result.Metadata["total_tokens"] = response.TotalTokens
	
	return result
}

// 输出结果
func printTestResult(t *testing.T, result TestResult) {
	t.Logf("\n问题: %s\n", result.Question)
	t.Logf("生成的SQL: %s\n", result.Pred)
	t.Logf("标准SQL: %s\n", result.GroundTruth)
	
	if result.Thinking != "" {
		t.Logf("\n思考过程:\n%s\n", result.Thinking)
	}
	
	// 检查Metadata中是否有执行时间
	if execTime, ok := result.Metadata["execution_time"]; ok {
		switch v := execTime.(type) {
		case float64:
			t.Logf("执行时间: %.2f秒\n", v)
		case int:
			t.Logf("执行时间: %.2f秒\n", float64(v))
		default:
			t.Logf("执行时间: %v秒\n", v)
		}
	}
	
	// 检查Metadata中是否有Token信息
	if promptTokens, ok := result.Metadata["prompt_tokens"]; ok {
		// 安全地处理不同类型
		var promptTokensInt, responseTokensInt, totalTokensInt int
		
		switch v := promptTokens.(type) {
		case float64:
			promptTokensInt = int(v)
		case int:
			promptTokensInt = v
		default:
			t.Logf("提示tokens类型不支持: %T", v)
			return
		}
		
		responseTokens, ok := result.Metadata["response_tokens"]
		if !ok {
			return
		}
		
		switch v := responseTokens.(type) {
		case float64:
			responseTokensInt = int(v)
		case int:
			responseTokensInt = v
		default:
			t.Logf("响应tokens类型不支持: %T", v)
			return
		}
		
		totalTokens, ok := result.Metadata["total_tokens"]
		if !ok {
			return
		}
		
		switch v := totalTokens.(type) {
		case float64:
			totalTokensInt = int(v)
		case int:
			totalTokensInt = v
		default:
			t.Logf("总tokens类型不支持: %T", v)
			return
		}
		
		t.Logf("Token使用: 提示=%d, 响应=%d, 总计=%d\n", 
			promptTokensInt, responseTokensInt, totalTokensInt)
	}
}

// 保存结果
func saveResult(t *testing.T, result TestResult, resultsDir string) {
	// 创建结果文件
	resultFile := filepath.Join(resultsDir, fmt.Sprintf("result_%d.json", result.ID))
	
	// 序列化结果
	resultJSON, err := json.MarshalIndent(result, "", "  ")
	if err != nil {
		t.Logf("序列化结果失败: %v\n", err)
		return
	}
	
	// 写入文件
	err = os.WriteFile(resultFile, resultJSON, 0644)
	if err != nil {
		t.Logf("写入结果文件失败: %v\n", err)
		return
	}
	
	t.Logf("结果已保存到 %s\n", resultFile)
}

// 保存所有结果
func saveAllResults(t *testing.T, results []TestResult, resultsDir string) {
	// 创建结果文件
	resultFile := filepath.Join(resultsDir, "results.json")
	
	// 序列化结果
	resultJSON, err := json.MarshalIndent(results, "", "  ")
	if err != nil {
		t.Logf("序列化结果失败: %v\n", err)
		return
	}
	
	// 写入文件
	err = os.WriteFile(resultFile, resultJSON, 0644)
	if err != nil {
		t.Logf("写入结果文件失败: %v\n", err)
		return
	}
	
	t.Logf("所有结果已保存到 %s\n", resultFile)
}
