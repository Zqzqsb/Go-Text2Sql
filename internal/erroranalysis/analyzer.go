// Package erroranalysis 提供SQL错误分析功能
package erroranalysis

import (
	"fmt"
	"math"
	"regexp"
	"sort"
	"strconv"
	"strings"

	"github.com/zqzqsb/gosql/internal/eval"
)

// ErrorType 定义SQL错误的分类类型
type ErrorType string

// 错误类型常量
const (
	ExactMatch    ErrorType = "精准匹配"   // SQL完全匹配
	SemanticMatch ErrorType = "语义匹配"   // 结果集匹配（忽略顺序）
	GTError       ErrorType = "参考答案错误" // 标准答案执行错误
	ExecError     ErrorType = "执行错误"   // 语法错误等
	RowError      ErrorType = "行错误"    // 行数不匹配等
	ColumnError   ErrorType = "列错误"    // 列选择错误等
	UnknownError  ErrorType = "未知错误"   // 未分类错误
)

// IsCorrect 判断结果是否正确（精准匹配或语义匹配）
func IsCorrect(errType ErrorType) bool {
	return errType == ExactMatch || errType == SemanticMatch
}

// IsColumnErrorType 判断是否为列错误
func IsColumnErrorType(errType ErrorType) bool {
	return errType == ColumnError
}

// IsRowErrorType 判断是否为行错误
func IsRowErrorType(errType ErrorType) bool {
	return errType == RowError || errType == ExecError || errType == GTError
}

// AnalysisResult 表示SQL分析结果
type AnalysisResult struct {
	Type        ErrorType // 错误类型
	Description string    // 详细描述
}

// NormalizeSQL 标准化SQL以进行字符串比较
func NormalizeSQL(sql string) string {
	// 转为小写
	sql = strings.ToLower(sql)
	// 去除多余空格
	sql = regexp.MustCompile(`\s+`).ReplaceAllString(sql, " ")
	// 去除首尾空格
	sql = strings.TrimSpace(sql)
	return sql
}

// IsEquivalentSQL 判断两个SQL语句是否等价
// 按照优先级：
// 1. 精准匹配（SQL字符串相同）
// 2. 语义等价（执行结果相同，忽略顺序）
// 3. 错误分类
func IsEquivalentSQL(dbPath, sql1, sql2 string) (bool, string) {
	// 1. 检查是否精准匹配
	if NormalizeSQL(sql1) == NormalizeSQL(sql2) {
		return true, "精准匹配"
	}

	// 如果没有数据库路径，无法继续比较
	if dbPath == "" {
		return false, "未提供数据库路径"
	}

	// 2. 检查语义等价性
	result1, err1 := eval.ExecSQL(dbPath, sql1)
	result2, err2 := eval.ExecSQL(dbPath, sql2)

	// 处理执行错误
	if err2 != nil {
		return false, fmt.Sprintf("标准SQL执行错误: %v", err2)
	}
	if !result2.Success {
		return false, fmt.Sprintf("标准SQL执行失败: %s", result2.Error)
	}
	if err1 != nil {
		return false, fmt.Sprintf("预测SQL执行错误: %v", err1)
	}
	if !result1.Success {
		return false, fmt.Sprintf("预测SQL执行失败: %s", result1.Error)
	}

	// 检查行数是否相同
	if len(result1.Rows) != len(result2.Rows) {
		return false, fmt.Sprintf("行数不匹配: %d vs %d", len(result1.Rows), len(result2.Rows))
	}

	// 如果结果为空（只有表头），视为等价
	if len(result1.Rows) <= 1 {
		return true, "等价（空结果集）"
	}

	// 检查是否需要忽略顺序
	hasOrderBy := hasOrderByClause(sql2) // sql2是标准SQL

	// 如果标准SQL中没有ORDER BY，则按集合比较（忽略顺序）
	if !hasOrderBy {
		// 对结果排序
		sortedRows1 := sortResultRows(result1.Rows)
		sortedRows2 := sortResultRows(result2.Rows)

		// 比较排序后的结果
		for i := 1; i < len(sortedRows1); i++ {
			if len(sortedRows1[i]) != len(sortedRows2[i]) {
				return false, fmt.Sprintf("列数不匹配: %d vs %d", len(sortedRows1[i]), len(sortedRows2[i]))
			}

			// 比较每个单元格的值
			for j := 0; j < len(sortedRows1[i]); j++ {
				val1 := strings.TrimSpace(sortedRows1[i][j])
				val2 := strings.TrimSpace(sortedRows2[i][j])

				// 如果字符串相等或数值相等，继续比较
				if val1 == val2 {
					continue
				}

				// 尝试数值比较
				num1, err1 := strconv.ParseFloat(val1, 64)
				num2, err2 := strconv.ParseFloat(val2, 64)
				if err1 == nil && err2 == nil && math.Abs(num1-num2) < 1e-10 {
					continue
				}

				return false, fmt.Sprintf("值不匹配: '%s' vs '%s'", val1, val2)
			}
		}

		return true, "语义等价（忽略顺序）"
	}

	// 如果有ORDER BY，则考虑顺序进行比较
	for i := 1; i < len(result1.Rows); i++ {
		if len(result1.Rows[i]) != len(result2.Rows[i]) {
			return false, fmt.Sprintf("列数不匹配: %d vs %d", len(result1.Rows[i]), len(result2.Rows[i]))
		}

		for j := 0; j < len(result1.Rows[i]); j++ {
			val1 := strings.TrimSpace(result1.Rows[i][j])
			val2 := strings.TrimSpace(result2.Rows[i][j])

			if val1 == val2 {
				continue
			}

			// 尝试数值比较
			num1, err1 := strconv.ParseFloat(val1, 64)
			num2, err2 := strconv.ParseFloat(val2, 64)
			if err1 == nil && err2 == nil && math.Abs(num1-num2) < 1e-10 {
				continue
			}

			return false, fmt.Sprintf("值不匹配: '%s' vs '%s'", val1, val2)
		}
	}

	return true, "语义等价（考虑顺序）"
}

// AnalyzeSQL 分析SQL查询结果并返回结果类型和描述
func AnalyzeSQL(dbPath, predSQL, gtSQL, errorReason string) AnalysisResult {
	// 1. 检查精准匹配
	if NormalizeSQL(predSQL) == NormalizeSQL(gtSQL) {
		return AnalysisResult{Type: ExactMatch, Description: "精准匹配"}
	}

	// 已提供错误原因的情况
	if errorReason != "" {
		// 2. 判断标准答案是否有错误
		if strings.Contains(errorReason, "标准SQL执行错误") || strings.Contains(errorReason, "标准SQL执行失败") {
			return AnalysisResult{Type: GTError, Description: errorReason}
		}

		// 3. 判断预测结果是否有执行错误
		if strings.Contains(errorReason, "预测SQL执行错误") || strings.Contains(errorReason, "预测SQL执行失败") {
			return AnalysisResult{Type: ExecError, Description: errorReason}
		}

		// 4. 判断行数错误
		if strings.Contains(errorReason, "行数不匹配") {
			return AnalysisResult{Type: RowError, Description: errorReason}
		}

		// 5. 判断列错误
		if strings.Contains(errorReason, "列数不匹配") || strings.Contains(errorReason, "投影错误") {
			return AnalysisResult{Type: ColumnError, Description: errorReason}
		}
	}

	// 6. 检查语义等价性
	if dbPath != "" {
		isEquivalent, reason := IsEquivalentSQL(dbPath, predSQL, gtSQL)
		if isEquivalent {
			return AnalysisResult{Type: SemanticMatch, Description: reason}
		}

		// 根据不等价原因进行分类
		if strings.Contains(reason, "标准SQL执行") {
			return AnalysisResult{Type: GTError, Description: reason}
		}
		if strings.Contains(reason, "预测SQL执行") {
			return AnalysisResult{Type: ExecError, Description: reason}
		}
		if strings.Contains(reason, "行数") {
			return AnalysisResult{Type: RowError, Description: reason}
		}
		if strings.Contains(reason, "列数") || strings.Contains(reason, "投影") {
			return AnalysisResult{Type: ColumnError, Description: reason}
		}

		// 默认为未知错误
		return AnalysisResult{Type: UnknownError, Description: reason}
	}

	// 没有足够信息时返回未知错误
	return AnalysisResult{Type: UnknownError, Description: "无法确定错误类型"}
}

// ClassifyErrorReason 将错误原因分类为标准类别
func ClassifyErrorReason(errorReason string) string {
	if errorReason == "" {
		return "未知的错误" // 默认错误类型
	}

	// 判断是否是参考答案执行错误
	if strings.Contains(errorReason, "标准SQL执行错误") || strings.Contains(errorReason, "标准SQL执行失败") {
		return "参考答案有语法错误"
	}

	// 判断是否是执行错误
	if strings.Contains(errorReason, "预测SQL执行错误") || strings.Contains(errorReason, "预测SQL执行失败") ||
		strings.Contains(errorReason, "语法错误") {
		return "执行错误"
	}

	// 判断是否是行错误
	if strings.Contains(errorReason, "行数") {
		return "行数错误"
	}

	// 判断是否是列错误
	if strings.Contains(errorReason, "列数") || strings.Contains(errorReason, "列名") ||
		strings.Contains(errorReason, "投影") {
		return "投影错误"
	}

	// 其他错误情况
	return "其他错误"
}

// 判断SQL是否包含ORDER BY子句
func hasOrderByClause(sql string) bool {
	// 简单实现，不考虑字符串内容和注释中的"order by"
	return regexp.MustCompile(`(?i)\border\s+by\b`).MatchString(sql)
}

// 结果集行转换为字符串
func resultRowToString(row []string) string {
	return strings.Join(row, "\t")
}

// 对结果集进行排序（忽略表头行）
func sortResultRows(rows [][]string) [][]string {
	if len(rows) <= 1 {
		return rows
	}

	// 创建结果的深拷贝
	result := make([][]string, len(rows))
	for i, row := range rows {
		result[i] = make([]string, len(row))
		copy(result[i], row)
	}

	// 保留表头
	header := result[0]

	// 将数据行转换为可排序的格式
	type sortableRow struct {
		key      string   // 用于排序的键
		original []string // 原始行数据
	}

	// 提取数据行
	dataRows := make([]sortableRow, len(result)-1)
	for i := 1; i < len(result); i++ {
		dataRows[i-1] = sortableRow{
			key:      resultRowToString(result[i]),
			original: result[i],
		}
	}

	// 排序
	sort.Slice(dataRows, func(i, j int) bool {
		return dataRows[i].key < dataRows[j].key
	})

	// 重构结果
	sorted := make([][]string, len(rows))
	sorted[0] = header
	for i := 0; i < len(dataRows); i++ {
		sorted[i+1] = dataRows[i].original
	}

	return sorted
}

// IsColumnError 判断错误类型是否为列错误(兼容旧代码)
func IsColumnError(reason string) bool {
	// 根据错误原因的文本判断是否是列错误
	return strings.Contains(reason, "列数") ||
		strings.Contains(reason, "列名") ||
		strings.Contains(reason, "投影") ||
		strings.Contains(reason, "类型") ||
		reason == "投影错误"
}

// TruncateString 截断字符串到指定长度并添加省略号
func TruncateString(s string, maxLen int) string {
	if len(s) <= maxLen {
		return s
	}
	return s[:maxLen-3] + "..."
}

// AnalyzeErrorDistribution 分析错误分布
func AnalyzeErrorDistribution(results []interface{}) (map[string]int, int, int, map[string]interface{}) {
	errorReasons := make(map[string]int)
	examplesByReason := make(map[string]interface{})
	columnErrors := 0
	rowErrors := 0

	for _, resultObj := range results {
		result, ok := resultObj.(map[string]interface{})
		if !ok {
			continue
		}

		// 跳过正确和模糊查询
		isCorrect, _ := result["is_correct"].(bool)
		pred, _ := result["pred"].(string)
		if isCorrect || pred == "AMBIGUOUS_QUERY" {
			continue
		}

		// 获取错误原因
		errorReason, _ := result["error_reason"].(string)
		standardReason := ClassifyErrorReason(errorReason)

		// 统计错误类型
		errorReasons[standardReason]++

		// 保存示例（如果还没有）
		if _, exists := examplesByReason[standardReason]; !exists {
			examplesByReason[standardReason] = result
		}

		// 判断错误类别
		if standardReason == "投影错误" {
			columnErrors++
		} else {
			rowErrors++
		}
	}

	return errorReasons, columnErrors, rowErrors, examplesByReason
}
