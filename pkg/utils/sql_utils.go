package utils

import (
	"regexp"
	"strings"
)

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
func FormatPrompt(question string, schema string) string {
	return FormatPromptWithFields(question, schema, "", false)
}

// FormatPromptWithFields 格式化提示，并支持字段信息或字段描述
func FormatPromptWithFields(question string, schema string, fieldsInfo string, useDescription bool) string {
	// 基础提示
	prompt := `请将以下自然语言问题转换为 符合 PostgreSQL 语法的 SQL查询语句。

数据库结构:
` + schema + `

问题:
` + question

	// 如果提供了字段信息，添加到提示中
	if fieldsInfo != "" {
		if useDescription {
			prompt += `

查询字段描述:
` + fieldsInfo
		} else {
			prompt += `

需要返回的字段:
` + fieldsInfo
		}
	}

	if fieldsInfo != "" {
		if useDescription {
			prompt += `

请特别注意上面给出的字段描述，确保你生成的SQL查询返回的字段符合这些要求。`
		} else {
			prompt += `

请特别注意上面给出的字段列表，确保你生成的SQL查询的SELECT部分只返回这些字段，不多不少。`
		}
	}

	prompt += `

sql在保证正确性的情况下尽可能简单可读，确保最终的SQL查询是单独一行，以分号结尾。注意,请不要给出多个sql，答案仅仅需要最可能是正确的一个sql查询。`

	return prompt
}
