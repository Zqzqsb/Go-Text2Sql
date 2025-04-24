package query_validator

import "regexp"

// AmbiguousPatterns 包含用于检测模糊查询的正则表达式模式
var AmbiguousPatterns = []*regexp.Regexp{
	regexp.MustCompile(`['"]\s*\w+ID\s*['"]`),        // 如 'employeeID'
	regexp.MustCompile(`['"]\s*\w+_id\s*['"]`),       // 如 'employee_id'
	regexp.MustCompile(`['"]\s*\w+名称\s*['"]`),       // 如 '产品名称'
	regexp.MustCompile(`['"]\s*\w+名\s*['"]`),         // 如 '客户名'
	regexp.MustCompile(`['"]\s*\w+\s+name\s*['"]`),   // 如 'product name'
	regexp.MustCompile(`['"]\s*\w+\s+value\s*['"]`),  // 如 'specific value'
	regexp.MustCompile(`\?+`),                        // 问号占位符
	regexp.MustCompile(`\$\w+`),                      // $占位符
}

// AmbiguousTerms 包含可能表示模糊概念的词汇
var AmbiguousTerms = []string{
	"特定", "某个", "某些", "指定", "特定的", "某位", "特殊", 
	"specific", "particular", "certain", "given", "specified",
	"一个", "任何", "any", "some", "one", "a certain",
}
