package erroranalysis

import (
	"fmt"
	"math"
	"regexp"
	"strconv"
	"strings"

	"github.com/zqzqsb/gosql/internal/database"
	"github.com/zqzqsb/gosql/internal/eval"
)

// IsEquivalentSQL 判断两个SQL语句是否等价（通过比较执行结果）
// 参数:
// - dbPath: 数据库路径，可以是SQLite文件路径或PostgreSQL连接字符串
// - sql1, sql2: 要比较的两条SQL语句
// 返回:
// - bool: 是否等价
// - string: 不等价时的错误原因
func IsEquivalentSQL(dbPath string, sql1 string, sql2 string) (bool, string) {
	// 如果SQL语句完全相同（忽略大小写和空格），则认为它们等价
	if NormalizeSQL(sql1) == NormalizeSQL(sql2) {
		return true, ""
	}

	// 如果数据库路径为空，无法执行SQL进行比较
	if dbPath == "" {
		return false, "未提供数据库路径"
	}

	// 使用数据库抽象层判断等价性
	executor := database.NewDBExecutor()
	isEquivalent, err := executor.IsEquivalentSQL(dbPath, sql1, sql2)
	if err == nil {
		return isEquivalent, ""
	}

	// 如果抽象层判断失败，回退到原有方式
	result1, err1 := eval.ExecSQL(dbPath, sql1)
	result2, err2 := eval.ExecSQL(dbPath, sql2)

	// 如果任一查询执行失败，则认为它们不等价
	if err1 != nil || err2 != nil {
		return false, fmt.Sprintf("SQL执行错误: %v, %v", err1, err2)
	}

	if !result1.Success || !result2.Success {
		return false, fmt.Sprintf("SQL执行不成功: %v, %v", result1.Error, result2.Error)
	}

	// 比较结果行数（不包括列名行）
	if len(result1.Rows) != len(result2.Rows) {
		return false, fmt.Sprintf("结果行数不同: %d vs %d", len(result1.Rows), len(result2.Rows))
	}

	// 如果只有列名行，则认为结果为空，此时两个查询等价
	if len(result1.Rows) == 1 {
		return true, ""
	}

	// 比较结果内容（忽略列名）
	for i := 1; i < len(result1.Rows); i++ {
		if len(result1.Rows[i]) != len(result2.Rows[i]) {
			return false, fmt.Sprintf("行 %d 的列数不同: %d vs %d", i, len(result1.Rows[i]), len(result2.Rows[i]))
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
			return false, fmt.Sprintf("行 %d 列 %d 的值不同: '%s' vs '%s'", i, j, val1, val2)
		}
	}

	// 所有检查都通过，认为两个SQL查询等价
	return true, ""
}

// NormalizeSQL 标准化SQL语句，用于简单的文本比较
func NormalizeSQL(sql string) string {
	// 转换为小写
	sql = strings.ToLower(sql)

	// 移除分号
	sql = strings.TrimSuffix(sql, ";")

	// 移除多余的空格
	sql = strings.Join(strings.Fields(sql), " ")

	return sql
}

// ClassifyErrorReason 将错误原因分类为标准类别
// 参数:
// - errorReason: 原始错误原因描述
// 返回:
// - string: 标准化的错误类别
func ClassifyErrorReason(errorReason string) string {
	// 错误分类原则：
	// 1. 行错误拥有最高优先级 - 包括行数错误、执行错误、语法错误等
	// 2. 列错误只有在行数一致的情况下才能被判定

	// --- 第一级优先级：行错误 ---

	// 1. 空错误原因特殊处理 - 只有确定不存在行错误时才被判定为投影错误
	// 不放在开头，因为要先排除是否是行错误

	// 2. 语法错误检测（最高优先级）
	if strings.Contains(errorReason, "SQL执行不成功") && 
		(strings.Contains(errorReason, "near") || 
		strings.Contains(errorReason, "syntax error")) {
		return "参考答案有语法错误"
	}

	// 3. 执行错误检测
	if strings.Contains(errorReason, "SQL执行错误") || 
		strings.Contains(errorReason, "execution error") {
		return "执行错误"
	}

	// 4. 行数错误检测
	rowDiffRegex := regexp.MustCompile("结果行数不同: (\\d+) vs (\\d+)")
	if rowDiffRegex.MatchString(errorReason) || strings.Contains(errorReason, "行数不同") {
		return "行数错误"
	}

	// --- 第二级优先级：列错误（只有行数一致才有意义）---

	// 5. 列数错误检测
	colDiffRegex := regexp.MustCompile("列数不同: (\\d+) vs (\\d+)")
	if colDiffRegex.MatchString(errorReason) {
		return "列数错误"
	}
	if regexp.MustCompile("column.*(count|number).*different.*?(\\d+).*?(\\d+)").MatchString(errorReason) {
		return "列数错误"
	}

	// 6. 列值错误检测
	rowColValueRegex := regexp.MustCompile("行 (\\d+) 列 (\\d+) 的值不同")
	if rowColValueRegex.MatchString(errorReason) {
		matches := rowColValueRegex.FindStringSubmatch(errorReason)
		row := matches[1]

		// 如果是第1行的值不同，可能是列选择错误
		if row == "1" {
			return "列选择错误"
		} else {
			return "行值错误"
		}
	}

	// 7. 最后处理空错误原因，更可能是投影错误
	// 只有在确定不存在行错误的情况下才这样判定
	if errorReason == "" || errorReason == "未知原因" {
		return "投影错误"
	}

	// 8. 其他类型错误检测（使用正则表达式匹配其他常见错误模式）
	syntaxErrorRegex := regexp.MustCompile(`(?i)(syntax|parse|token|valid|expect|illegal).*error`)
	columnErrorRegex := regexp.MustCompile(`(?i)(column|field|attribute).*(not|unknown|missing|invalid)`)
	tableErrorRegex := regexp.MustCompile(`(?i)(table|relation).*(not|unknown|missing|invalid)`)
	joinErrorRegex := regexp.MustCompile(`(?i)(join|foreign key|relation|reference)`)
	groupByErrorRegex := regexp.MustCompile(`(?i)(group by|aggregate|having)`)
	orderByErrorRegex := regexp.MustCompile(`(?i)(order by|sort)`)
	limitErrorRegex := regexp.MustCompile(`(?i)(limit|offset)`)
	subqueryErrorRegex := regexp.MustCompile(`(?i)(subquery|sub-query|nested)`)
	typeErrorRegex := regexp.MustCompile(`(?i)(type|conversion|cast|datatype)`)

	// 匹配其他常见的错误类型
	switch {
	case syntaxErrorRegex.MatchString(errorReason):
		return "语法错误"
	case columnErrorRegex.MatchString(errorReason):
		return "列/字段错误"
	case tableErrorRegex.MatchString(errorReason):
		return "表/关系错误"
	case joinErrorRegex.MatchString(errorReason):
		return "连接错误"
	case groupByErrorRegex.MatchString(errorReason):
		return "分组错误"
	case orderByErrorRegex.MatchString(errorReason):
		return "排序错误"
	case limitErrorRegex.MatchString(errorReason):
		return "限制错误"
	case subqueryErrorRegex.MatchString(errorReason):
		return "子查询错误"
	case typeErrorRegex.MatchString(errorReason):
		return "类型错误"
	case strings.Contains(errorReason, "execution") || strings.Contains(errorReason, "执行"):
		return "执行错误"
	case strings.Contains(errorReason, "result") || strings.Contains(errorReason, "结果"):
		return "结果不匹配"
	default:
		// 检查是否有行列值比较的错误，但没有标准形式
		if strings.Contains(errorReason, "行") && strings.Contains(errorReason, "列") && strings.Contains(errorReason, "值不同") {
			return "值不匹配错误"
		}

		// 如果不是已知类型，存储原始错误消息（截取前50个字符）
		if len(errorReason) > 50 {
			return errorReason[:50] + "..."
		}
		return errorReason
	}
}

// IsColumnError 判断错误原因是否属于列错误
func IsColumnError(reason string) bool {
	// 标准答案本身就存在语法错误的情况，应当判定为行错误
	if reason == "参考答案有语法错误" {
		return false
	}

	// 没有错误原因的情况，这通常是投影列不匹配
	if reason == "未知原因" || reason == "" || reason == "投影错误" {
		// 判断为列错误（投影错误）
		return true
	}

	// 列数错误
	if strings.Contains(reason, "列数错误") {
		return true
	}

	// 列选择错误
	if strings.Contains(reason, "列选择错误") {
		return true
	}

	// 类型错误通常与列有关
	if strings.Contains(reason, "类型错误") {
		return true
	}

	// 列/字段错误
	if strings.Contains(reason, "列/字段错误") {
		return true
	}

	// 投影错误 - 不同SELECT字段
	if strings.Contains(reason, "不同>") || strings.Contains(reason, "字段不匹配") {
		return true
	}

	// 默认其他错误都算作行错误
	return false
}

// TruncateString 截断过长的字符串并添加省略号
func TruncateString(s string, maxLen int) string {
	if len(s) <= maxLen {
		return s
	}
	return s[:maxLen-3] + "..."
}

// AnalyzeErrorDistribution 分析错误分布并返回统计结果
// 参数:
// - results: SQL结果列表
// 返回:
// - map[string]int: 每种错误类型的计数
// - int: 列错误总数
// - int: 行错误总数
// - map[string]interface{}: 每种错误类型的示例
func AnalyzeErrorDistribution(results []interface{}) (map[string]int, int, int, map[string]interface{}) {
	detailedErrorReasons := make(map[string]int)
	reasonToExample := make(map[string]interface{})
	columnErrors := 0
	rowErrors := 0

	// 遍历结果，收集错误统计信息
	for _, resultObj := range results {
		result, ok := resultObj.(map[string]interface{})
		if !ok {
			continue
		}

		// 检查是否是不正确的结果
		isCorrect, _ := result["is_correct"].(bool)
		pred, _ := result["pred"].(string)
		if !isCorrect && pred != "AMBIGUOUS_QUERY" {
			errorReason, _ := result["error_reason"].(string)
			reason := ClassifyErrorReason(errorReason)
			detailedErrorReasons[reason]++

			// 保存该错误类型的示例（如果尚未有）
			if _, exists := reasonToExample[reason]; !exists {
				reasonToExample[reason] = result
			}

			// 判断是列错误还是行错误
			if IsColumnError(reason) {
				columnErrors++
			} else {
				rowErrors++
			}
		}
	}

	return detailedErrorReasons, columnErrors, rowErrors, reasonToExample
}
