package utils

import (
	"regexp"
	"strings"
)

// FieldsInfo 表示字段信息
type FieldsInfo struct {
	Info           string
	UseDescription bool
	HasInfo        bool
}

// ExtractFieldsInfo 提取字段信息
func ExtractFieldsInfo(example map[string]interface{}, fieldsInfoType string) FieldsInfo {
	result := FieldsInfo{
		Info:           "",
		UseDescription: false,
		HasInfo:        false,
	}

	if example == nil || fieldsInfoType == "" {
		return result
	}

	switch fieldsInfoType {
	case "fields":
		// 使用精确字段列表
		if fields, ok := example["result_fields"].([]interface{}); ok && len(fields) > 0 {
			fieldStrs := make([]string, 0, len(fields))
			for _, f := range fields {
				if fs, ok := f.(string); ok {
					fieldStrs = append(fieldStrs, fs)
				}
			}
			result.Info = strings.Join(fieldStrs, ", ")
			result.UseDescription = false
			result.HasInfo = true
		}
	case "description":
		// 使用字段描述
		if description, ok := example["result_fields_description"].(string); ok && description != "" {
			result.Info = description
			result.UseDescription = true
			result.HasInfo = true
		}
	}

	return result
}

// ProcessDuplication 处理SQL中的重复部分
func ProcessDuplication(sql string) string {
	// 移除重复的SELECT语句
	re := regexp.MustCompile(`(?i)SELECT\s+SELECT`)
	sql = re.ReplaceAllString(sql, "SELECT")

	// 移除重复的FROM语句
	re = regexp.MustCompile(`(?i)FROM\s+FROM`)
	sql = re.ReplaceAllString(sql, "FROM")

	// 移除重复的WHERE语句
	re = regexp.MustCompile(`(?i)WHERE\s+WHERE`)
	sql = re.ReplaceAllString(sql, "WHERE")

	return sql
}

// ExtractFinalSQL 从LLM响应中提取最终的SQL语句
func ExtractFinalSQL(response string) string {
	// 按行分割响应
	lines := strings.Split(response, "\n")

	// 查找最后一个以SELECT开头的行
	var finalSQL string
	for i := len(lines) - 1; i >= 0; i-- {
		line := strings.TrimSpace(lines[i])
		if strings.HasPrefix(strings.ToUpper(line), "SELECT") {
			finalSQL = line
			break
		}
	}

	// 如果没有找到，则使用整个响应
	if finalSQL == "" {
		finalSQL = strings.TrimSpace(response)
	}

	// 确保SQL以SELECT开头
	if !strings.HasPrefix(strings.ToUpper(finalSQL), "SELECT") {
		if strings.HasPrefix(finalSQL, " ") {
			finalSQL = "SELECT" + finalSQL
		} else {
			finalSQL = "SELECT " + finalSQL
		}
	}

	// 确保SQL以分号结尾
	if !strings.HasSuffix(finalSQL, ";") {
		finalSQL += ";"
	}

	return finalSQL
}

// FormatPrompt 格式化提示
func FormatPrompt(question string, schema string, dbType string) string {
	return FormatPromptWithFields(question, schema, "", false, dbType)
}

// FormatPromptWithFields 格式化提示，并支持字段信息或字段描述
func FormatPromptWithFields(question string, schema string, fieldsInfo string, useDescription bool, dbType string) string {
	// 确定数据库类型描述
	var dbTypeDesc string
	switch strings.ToLower(dbType) {
	case "postgres", "postgresql":
		dbTypeDesc = "PostgreSQL"
	case "sqlite":
		dbTypeDesc = "SQLite"
	default:
		dbTypeDesc = "SQL"
	}

	// 基础提示
	prompt := `请将以下自然语言问题转换为符合 ` + dbTypeDesc + ` 语法的SQL查询语句。

数据库结构:
` + schema + `

问题:
` + question

	// 如果提供了字段信息，添加到提示中
	if fieldsInfo != "" {
		if useDescription {
			prompt += `

字段要求:
` + fieldsInfo
		} else {
			prompt += `

返回字段:
` + fieldsInfo
	}

			prompt += `

请确保返回的字段严格符合上述要求。`
	}

	prompt += `

要求：简洁正确的SQL，单行输出，以分号结尾。`

	return prompt
}
