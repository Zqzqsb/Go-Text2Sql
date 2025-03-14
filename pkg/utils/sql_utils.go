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
	return `请将以下自然语言问题转换为SQL查询语句。

数据库结构:
` + schema + `

问题:
` + question + `

请提供详细的思考过程，然后给出最终的SQL查询。确保最终的SQL查询是单独一行，以分号结尾。`
}
