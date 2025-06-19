package predict

import (
	"fmt"
	"path/filepath"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
	"github.com/zqzqsb/gosql/pkg/utils"
)

// GenerateSQL 生成SQL
func GenerateSQL(client llm.LLM, options llm.Options, ds *dataset.Dataset, example map[string]interface{}, dbType string) SQLResult {
	// 提取样例信息
	id := GetExampleID(example)

	// 获取数据库ID和问题
	dbID, _ := example["db_id"].(string)
	question, _ := example["question"].(string)
	gtSQL, _ := example["query"].(string)

	// 如果不是模糊查询，继续正常处理
	result := SQLResult{
		ID:        id,
		DBName:    dbID,
		Question:  question,
		GTSQL:     gtSQL,
		Ambiguous: "False",
		Thinking:  "",
	}

	// 加载数据库Schema
	dbPath := filepath.Join(ds.BaseDir, ds.DBDir, dbID)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		fmt.Printf("加载数据库Schema失败: %v\n", err)
		result.PredSQL = "ERROR: 加载数据库Schema失败"
		return result
	}

	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)

	// 提取字段信息
	fieldsInfo := utils.ExtractFieldsInfo(example, options.FieldsInfoType)

	// 格式化提示
	var prompt string
	if fieldsInfo.HasInfo {
		prompt = utils.FormatPromptWithFields(question, schemaPrompt, fieldsInfo.Info, fieldsInfo.UseDescription, dbType)
		fmt.Printf("使用字段%s: %s\n",
			map[bool]string{true: "描述", false: "列表"}[fieldsInfo.UseDescription],
			fieldsInfo.Info)
	} else {
		prompt = utils.FormatPrompt(question, schemaPrompt, dbType)
	}

	// 向LLM发送请求
	startTime := time.Now()
	response, err := client.GenerateSQL(prompt, options)
	elapsedTime := time.Since(startTime)

	if err != nil {
		fmt.Printf("向LLM发送请求失败: %v\n", err)
		result.PredSQL = "ERROR: 向LLM发送请求失败"
		return result
	}

	// 设置结果
	result.PredSQL = response.Response

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

	fmt.Printf("SQL生成耗时: %.2f秒, 提示词: %d tokens, 响应: %d tokens\n",
		elapsedTime.Seconds(), response.PromptTokens, response.ResponseTokens)

	return result
}
