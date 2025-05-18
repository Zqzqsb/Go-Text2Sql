package main

import (
	"fmt"
	"sort"
	"strings"
)

// 颜色常量
const (
	ColorReset  = "\033[0m"
	ColorRed    = "\033[31m"
	ColorGreen  = "\033[32m"
	ColorYellow = "\033[33m"
	ColorBlue   = "\033[34m"
	ColorPurple = "\033[35m"
	ColorCyan   = "\033[36m"
	ColorWhite  = "\033[37m"
	Bold        = "\033[1m"
)

// SQLAnalyzer 处理SQL分析相关操作
type SQLAnalyzer struct {
	Stats *ErrorStatistics
}

// NewSQLAnalyzer 创建SQL分析器
func NewSQLAnalyzer() *SQLAnalyzer {
	return &SQLAnalyzer{
		Stats: &ErrorStatistics{
			ErrorCounts: make([]ErrorCount, 0),
		},
	}
}

// AnalyzeSQL 分析单个SQL查询
// 使用预先执行后的结果进行分析
func (a *SQLAnalyzer) AnalyzeSQL(input InputResult, gtResult, predResult *ExecResult, gtErr, predErr error) *AnalysisResult {
	// 调试输出：开始分析查询
	result := &AnalysisResult{
		ID:           input.ID,
		DBName:       input.DBName,
		Question:     input.Question,
		GTSQL:        input.GTSQL,
		PredSQL:      input.PredSQL,
		Thinking:     input.Thinking,
		Ambiguous:    input.Ambiguous,
		IsCorrect:    false,
		IsEquivalent: false,
	}

	// 检查是否为模糊查询
	if input.Ambiguous == "True" {
		result.ErrorReason = "模糊查询需要澄清"
		result.ErrorType = "模糊查询"
		a.Stats.AmbiguousCount++
		return result
	}

	// 检查SQL是否为空
	if input.PredSQL == "" {
		result.ErrorReason = "预测SQL为空"
		result.ErrorType = "执行错误"
		a.Stats.SyntaxErrorCount++
		return result
	}

	// 1. 检查SQL规范化后是否完全匹配
	// 包括小写转换、移除分号和添加空格规范化
	if NormalizeSQL(input.PredSQL) == NormalizeSQL(input.GTSQL) {
		result.IsCorrect = true
		result.IsEquivalent = true
		result.ErrorReason = ""
		result.ErrorType = "精准匹配"
		a.Stats.CorrectCount++
		return result
	}

	// 处理执行错误
	if gtErr != nil {
		// 调试输出：标准SQL执行错误
		fmt.Printf("标准SQL执行错误: %v\n", gtErr)
		// 检查是否为数据库连接错误
		errorStr := gtErr.Error()
		if strings.Contains(errorStr, "数据库连接失败") ||
			strings.Contains(errorStr, "connection") ||
			strings.Contains(errorStr, "database") {
			result.ErrorReason = fmt.Sprintf("数据库连接错误: %v", gtErr)
			result.ErrorType = "数据库连接错误"
			// 数据库连接错误应该单独统计，不计入语法错误
			a.Stats.DBNotExistCount++
			return result
		} else {
			result.ErrorReason = fmt.Sprintf("标准SQL执行错误: %v", gtErr)
			result.ErrorType = "参考答案有语法错误"
			a.Stats.ReferenceErrorCount++
			return result
		}
	}

	if predErr != nil {
		// 调试输出：预测SQL执行错误
		fmt.Printf("预测SQL执行错误: %v\n", predErr)
		// 检查是否为数据库连接错误
		errorStr := predErr.Error()
		if strings.Contains(errorStr, "数据库连接失败") ||
			strings.Contains(errorStr, "connection") ||
			strings.Contains(errorStr, "database") {
			result.ErrorReason = fmt.Sprintf("数据库连接错误: %v", predErr)
			result.ErrorType = "数据库连接错误"
			// 数据库连接错误应该单独统计，不计入语法错误
			a.Stats.DBNotExistCount++
			return result
		} else {
			result.ErrorReason = fmt.Sprintf("预测SQL执行错误: %v", predErr)
			result.ErrorType = "执行错误"
			a.Stats.ExecutionErrorCount++
			return result
		}
	}

	// 调试输出：两条SQL执行成功，检查结果是否等价
	if gtResult.Success {
		fmt.Printf("标准SQL执行成功，行数: %d\n", len(gtResult.Rows)-1) // 减去标题行
	}
	if predResult.Success {
		fmt.Printf("预测SQL执行成功，行数: %d\n", len(predResult.Rows)-1) // 减去标题行
	}

	// 检查结果是否等价
	isEquiv, errorReason := a.areResultsEquivalent(gtResult, predResult)

	// 保存执行结果
	result.GTResult = gtResult
	result.PredResult = predResult

	// 如果等价，标记为正确
	if isEquiv {
		result.IsCorrect = true
		result.IsEquivalent = true
		result.ErrorReason = ""
		result.ErrorType = "语义匹配"
		a.Stats.EquivalentCount++
		return result
	}

	// 设置错误原因
	result.ErrorReason = errorReason

	// 分类错误类型
	errorType := a.classifyError(errorReason)
	result.ErrorType = errorType

	// 设置错误类型颜色
	errorColor := ColorRed
	switch errorType {
	case "精准匹配", "语义匹配":
		errorColor = ColorGreen
	case "参考答案有语法错误":
		errorColor = ColorYellow
	case "投影错误":
		errorColor = ColorPurple
	case "行数错误":
		errorColor = ColorBlue
	case "数据不一致错误":
		errorColor = ColorCyan
	default:
		errorColor = ColorRed
	}

	// 打印详细调试信息 - 使用彩色输出
	fmt.Printf("\n%s===== 错误分析结果 =====%s\n", Bold, ColorReset)
	fmt.Printf("%s错误原因:%s %s\n", Bold, ColorReset, errorReason)
	fmt.Printf("%s分类结果:%s %s%s%s\n", Bold, ColorReset, errorColor, errorType, ColorReset)

	// 输出更详细的结果信息
	if len(gtResult.Rows) > 0 && len(predResult.Rows) > 0 {
		// 打印列信息
		fmt.Printf("\n%s列信息对比:%s\n", Bold, ColorReset)
		fmt.Printf("%s标准SQL列:%s %v\n", ColorBlue, ColorReset, gtResult.Rows[0])
		fmt.Printf("%s预测SQL列:%s %v\n", ColorPurple, ColorReset, predResult.Rows[0])

		// 如果行数不多，打印部分数据行进行比较
		maxRowsToPrint := 3 // 最多打印3行数据
		rowsToPrint := minInt(len(gtResult.Rows)-1, len(predResult.Rows)-1, maxRowsToPrint)
		if rowsToPrint > 0 {
			fmt.Printf("\n%s数据对比（前%d行）:%s\n", Bold, rowsToPrint, ColorReset)
			for i := 1; i <= rowsToPrint; i++ {
				fmt.Printf("---------- %s行 %d%s ----------\n", Bold, i, ColorReset)
				if i < len(gtResult.Rows) {
					fmt.Printf("%s标准[%d]:%s %v\n", ColorBlue, i, ColorReset, gtResult.Rows[i])
				}
				if i < len(predResult.Rows) {
					fmt.Printf("%s预测[%d]:%s %v\n", ColorPurple, i, ColorReset, predResult.Rows[i])
				}
			}
		}
	}

	// 更新统计信息
	a.updateErrorStats(errorType)

	return result
}

// classifyError 根据错误原因分类错误类型
// 按照文档中定义的优先级顺序进行错误分类
func (a *SQLAnalyzer) classifyError(errorReason string) string {
	// 优先级 1（最高）：未知的错误 (Unknown Error)
	// 当从执行引擎或系统中获得的原始错误原因字符串为空，或者其内容不匹配任何已知的错误模式时。
	if errorReason == "" {
		return "未知错误"
	}

	// 优先级 2：参考答案语法错误 (Reference Answer Syntax Error)
	// 当错误原因表明用于对比的标准答案SQL本身存在语法错误或执行失败。
	if strings.Contains(strings.ToLower(errorReason), "标准sql执行失败") ||
		strings.Contains(strings.ToLower(errorReason), "标准sql执行错误") {
		return "参考答案有语法错误"
	}

	// 优先级 3：执行错误 (Execution Error)
	// 当错误原因表明用户提交的预测SQL在执行过程中发生错误（例如语法错误、运行时错误等）。
	if strings.Contains(strings.ToLower(errorReason), "预测sql执行失败") ||
		strings.Contains(strings.ToLower(errorReason), "预测sql执行错误") ||
		strings.Contains(strings.ToLower(errorReason), "syntax error") {
		return "执行错误"
	}

	// 优先级 4：行数错误 (Row Count Error)
	// 当错误原因包含与执行结果“行数”不符相关的提示。
	if strings.Contains(strings.ToLower(errorReason), "行数不匹配") ||
		strings.Contains(strings.ToLower(errorReason), "数据行数") {
		return "行数错误"
	}

	// 优先级 5：投影错误 (Projection Error)
	// 当错误原因包含与执行结果的“列数”、“列名”不符，或者与查询的“投影”（即选择和组织列的方式）相关的提示。
	if strings.Contains(strings.ToLower(errorReason), "列数不匹配") ||
		strings.Contains(strings.ToLower(errorReason), "列名不匹配") ||
		strings.Contains(strings.ToLower(errorReason), "列名数量") {
		return "投影错误"
	}

	// 结果对比阶段的差异（优先级低于上述错误）

	// 数据不一致错误
	if strings.Contains(strings.ToLower(errorReason), "数据不匹配") ||
		strings.Contains(strings.ToLower(errorReason), "数据不一致") {
		return "数据不一致错误"
	}

	// 排序错误
	if strings.Contains(strings.ToLower(errorReason), "顺序") ||
		strings.Contains(strings.ToLower(errorReason), "order") {
		return "排序错误"
	}

	// 表连接错误
	if strings.Contains(strings.ToLower(errorReason), "join") ||
		strings.Contains(strings.ToLower(errorReason), "连接") {
		return "表连接错误"
	}

	// 查询条件错误
	if strings.Contains(strings.ToLower(errorReason), "where") ||
		strings.Contains(strings.ToLower(errorReason), "条件") ||
		strings.Contains(strings.ToLower(errorReason), "condition") {
		return "查询条件错误"
	}

	// 如果不匹配任何已知模式，则为其他错误
	return "其他错误"
}

// updateErrorStats 更新错误统计信息
func (a *SQLAnalyzer) updateErrorStats(errorType string) {
	// 更新错误计数
	found := false
	for i, ec := range a.Stats.ErrorCounts {
		if ec.Type == errorType {
			a.Stats.ErrorCounts[i].Count++
			found = true
			break
		}
	}

	if !found {
		a.Stats.ErrorCounts = append(a.Stats.ErrorCounts, ErrorCount{
			Type:  errorType,
			Count: 1,
		})
	}

	// 更新错误类型统计
	switch errorType {
	case "参考答案有语法错误":
		// 参考答案错误应该单独计算，不计入SyntaxErrorCount
		a.Stats.ReferenceErrorCount++
	case "执行错误":
		// 预测SQL的执行错误计入语法错误
		a.Stats.ExecutionErrorCount++
	case "数据库连接错误":
		a.Stats.DBNotExistCount++ // 数据库连接错误单独统计
	case "行数错误":
		a.Stats.RowErrorCount++ // 使用专用的行数错误计数器
	case "投影错误":
		a.Stats.ProjectionErrorCount++
	case "数据不一致错误":
		a.Stats.DataErrorCount++
	default:
		a.Stats.OtherErrorCount++
	}
}

// GetStatistics 获取错误统计信息
func (a *SQLAnalyzer) GetStatistics() *ErrorStatistics {
	return a.Stats
}

// NormalizeSQL 规范化SQL查询以便比较
func NormalizeSQL(sql string) string {
	// 转换为小写
	sql = strings.ToLower(sql)

	// 删除末尾的分号
	sql = strings.TrimSuffix(sql, ";")

	// 规范化空白字符
	sql = strings.Join(strings.Fields(sql), " ")

	return sql
}

// minInt 返回多个整数中的最小值
func minInt(values ...int) int {
	if len(values) == 0 {
		return 0
	}
	min := values[0]
	for _, v := range values[1:] {
		if v < min {
			min = v
		}
	}
	return min
}

// areResultsEquivalent 检查两个执行结果是否等价
func (a *SQLAnalyzer) areResultsEquivalent(result1, result2 *ExecResult) (bool, string) {
	// 如果有任何一个执行失败，则不等价
	if !result1.Success || !result2.Success {
		if !result1.Success {
			return false, "标准SQL执行失败: " + result1.Error
		}
		return false, "预测SQL执行失败: " + result2.Error
	}

	// 如果没有数据，认为是等价的
	if len(result1.Rows) <= 1 || len(result2.Rows) <= 1 { // 只有标题行或者没有行
		// 如果两者都没有数据行，则认为是等价的
		if len(result1.Rows) <= 1 && len(result2.Rows) <= 1 {
			return true, ""
		}
		// 如果一个有数据行而另一个没有，则不等价
		return false, fmt.Sprintf("行数不匹配: 标准SQL返回%d行, 预测SQL返回%d行",
			len(result1.Rows)-1, len(result2.Rows)-1) // 减去标题行
	}

	// 第一步：获取列名和列索引映射
	headers1 := result1.Rows[0]
	headers2 := result2.Rows[0]

	// 创建列名到索引的映射（不区分大小写）
	headerToIndex1 := make(map[string]int)
	headerToIndex2 := make(map[string]int)

	for i, h := range headers1 {
		headerToIndex1[strings.ToLower(h)] = i
	}

	for i, h := range headers2 {
		headerToIndex2[strings.ToLower(h)] = i
	}

	// 第二步：检查行数是否相同
	dataRows1 := len(result1.Rows) - 1 // 减去标题行
	dataRows2 := len(result2.Rows) - 1 // 减去标题行

	if dataRows1 != dataRows2 {
		return false, fmt.Sprintf("行数不匹配: 标准SQL返回%d行, 预测SQL返回%d行",
			dataRows1, dataRows2)
	}

	// 第三步：检查列名列表是否完全匹配（不考虑顺序）
	if len(headerToIndex1) != len(headerToIndex2) {
		return false, fmt.Sprintf("列数不匹配: 标准SQL返回%d列, 预测SQL返回%d列",
			len(headerToIndex1), len(headerToIndex2))
	}

	// 检查每个列名是否存在于两个结果中
	for header := range headerToIndex1 {
		if _, exists := headerToIndex2[header]; !exists {
			return false, "列名不匹配"
		}
	}

	// 第四步：对结果集进行转换，使其可比较（不考虑列顺序）
	// 对于每一行，创建一个按列名排序的值数组

	// 转换结果集到可比较的格式
	convertedRows1 := make([]map[string]string, dataRows1)
	convertedRows2 := make([]map[string]string, dataRows2)

	// 将标准SQL结果转化为按列名索引的数据
	for i := 1; i <= dataRows1; i++ {
		rowMap := make(map[string]string)
		for headerName, headerIndex := range headerToIndex1 {
			if headerIndex < len(result1.Rows[i]) { // 防止索引越界
				rowMap[headerName] = result1.Rows[i][headerIndex]
			}
		}
		convertedRows1[i-1] = rowMap
	}

	// 将预测SQL结果转化为按列名索引的数据
	for i := 1; i <= dataRows2; i++ {
		rowMap := make(map[string]string)
		for headerName, headerIndex := range headerToIndex2 {
			if headerIndex < len(result2.Rows[i]) { // 防止索引越界
				rowMap[headerName] = result2.Rows[i][headerIndex]
			}
		}
		convertedRows2[i-1] = rowMap
	}

	// 第五步：比较数据内容（考虑行的顺序无关性）
	// 首先将每一行转换为一个唯一的字符串表示
	rowStrings1 := make(map[string]bool)
	rowStrings2 := make(map[string]bool)

	for _, row := range convertedRows1 {
		// 按列名字典序排序列名
		sortedColumns := make([]string, 0, len(row))
		for colName := range row {
			sortedColumns = append(sortedColumns, colName)
		}
		sort.Strings(sortedColumns)

		// 按排序后的列名创建行字符串
		values := make([]string, 0, len(sortedColumns))
		for _, colName := range sortedColumns {
			values = append(values, fmt.Sprintf("%s=%s", colName, row[colName]))
		}

		// 使用空格连接列值
		rowStr := strings.Join(values, "|")
		rowStrings1[rowStr] = true
	}

	for _, row := range convertedRows2 {
		// 使用相同的方法处理预测SQL结果
		sortedColumns := make([]string, 0, len(row))
		for colName := range row {
			sortedColumns = append(sortedColumns, colName)
		}
		sort.Strings(sortedColumns)

		values := make([]string, 0, len(sortedColumns))
		for _, colName := range sortedColumns {
			values = append(values, fmt.Sprintf("%s=%s", colName, row[colName]))
		}

		rowStr := strings.Join(values, "|")
		rowStrings2[rowStr] = true
	}

	// 比较两个结果集的行集合
	if len(rowStrings1) != len(rowStrings2) {
		return false, "数据行数不匹配"
	}

	// 检查每一行是否存在于另一个结果集中
	for rowStr := range rowStrings1 {
		if !rowStrings2[rowStr] {
			return false, "数据不一致错误"
		}
	}

	// 通过所有检查，认为结果等价
	return true, ""
}
