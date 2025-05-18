package main

import (
	"context"
	"fmt"
	"path/filepath"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/agents/query_validator"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
	"github.com/zqzqsb/gosql/pkg/utils"
)

// 生成SQL
func generateSQL(client llm.LLM, options llm.Options, ds *dataset.Dataset, example map[string]interface{}) SQLResult {
	// 提取样例信息
	id := getExampleID(example)

	// 获取数据库ID和问题
	dbID, _ := example["db_id"].(string)
	question, _ := example["question"].(string)
	gtSQL, _ := example["query"].(string)

	// 创建QueryValidator检测模糊查询
	validator := query_validator.NewQueryValidator()
	validator.WithLLM(client) // 使用同一个LLM客户端

	// 检测查询是否模糊
	isAmbiguous, _, _ := validator.DetectAmbiguity(context.Background(), question)

	// 如果是模糊查询，返回特殊的SQLResult
	if isAmbiguous {
		return SQLResult{
			ID:        id,
			DBName:    dbID,
			Question:  question,
			GTSQL:     gtSQL,
			PredSQL:   "AMBIGUOUS_QUERY", // 特殊标记
			Thinking:  "模糊查询需要澄清",
			Ambiguous: "模糊查询需要澄清",
		}
	}

	// 如果不是模糊查询，继续正常处理
	result := SQLResult{
		ID:       id,
		DBName:   dbID,
		Question: question,
		GTSQL:    gtSQL,
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
			}
		case "description":
			// 使用字段描述
			if description, ok := example["result_fields_description"].(string); ok && description != "" {
				fieldsInfo = description
				useDescription = true
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
