package main

import (
	"bufio"
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strings"
)

// SQLResult 结果结构
type SQLResult struct {
	ID          int                    `json:"idx"`
	DBName      string                 `json:"db_id"`
	Question    string                 `json:"query"`
	Pred        string                 `json:"pred"`
	GroundTruth string                 `json:"ground_truth"`
	IsCorrect   bool                   `json:"is_correct"`
	ErrorReason string                 `json:"error_reason,omitempty"`
	Thinking    string                 `json:"thinking,omitempty"`
	DBSchema    string                 `json:"db_schema,omitempty"`
	Metadata    map[string]interface{} `json:"metadata,omitempty"`
	SequenceNum int                    `json:"sequence_num,omitempty"`
}

func main() {
	// 命令行参数
	resultDir := flag.String("dir", "", "结果目录路径")
	flag.Parse()

	if *resultDir == "" {
		fmt.Println("请提供结果目录路径")
		fmt.Println("使用方法: go run cmd/analyze_results.go --dir=结果目录路径")
		os.Exit(1)
	}

	// 查看目录是否存在
	if _, err := os.Stat(*resultDir); os.IsNotExist(err) {
		fmt.Printf("结果目录不存在: %s\n", *resultDir)
		os.Exit(1)
	}

	// 读取info.jsonl文件
	jsonlFile := filepath.Join(*resultDir, "info.jsonl")
	if _, err := os.Stat(jsonlFile); os.IsNotExist(err) {
		fmt.Printf("info.jsonl 文件不存在: %s\n", jsonlFile)
		os.Exit(1)
	}

	// 打开文件
	file, err := os.Open(jsonlFile)
	if err != nil {
		fmt.Printf("打开文件失败: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	// 读取并解析每一行
	var results []SQLResult
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		var result SQLResult
		if err := json.Unmarshal([]byte(line), &result); err != nil {
			fmt.Printf("解析行失败: %v\n", err)
			continue
		}
		results = append(results, result)
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("读取文件失败: %v\n", err)
		os.Exit(1)
	}

	// 统计模糊查询
	ambiguousQueriesCount := 0
	for _, result := range results {
		if result.Pred == "AMBIGUOUS_QUERY" {
			ambiguousQueriesCount++
		}
	}

	// 错误原因分类统计
	// 使用两个大类：行错误和列错误
	columnErrors := 0 // 列错误计数
	rowErrors := 0    // 行错误计数

	// 详细错误原因统计（用于调试和分析）
	detailedErrorReasons := make(map[string]int)
	var incorrectResults []SQLResult

	// 收集所有非模糊但错误的查询
	for _, result := range results {
		if result.Pred != "AMBIGUOUS_QUERY" && !result.IsCorrect {
			incorrectResults = append(incorrectResults, result)
			reason := classifyErrorReason(result.ErrorReason)
			detailedErrorReasons[reason]++

			// 判断是列错误还是行错误
			if isColumnError(reason) {
				columnErrors++
			} else {
				rowErrors++
			}
		}
	}

	// 统计评测指标
	fmt.Println(strings.Repeat("=", 50))
	fmt.Println("评测指标:")
	fmt.Printf("总样例数: %d\n", len(results))
	fmt.Printf("模糊查询数: %d (%.2f%%)\n", ambiguousQueriesCount, float64(ambiguousQueriesCount)*100/float64(len(results)))
	fmt.Printf("有效样例数: %d (排除模糊查询)\n", len(results)-ambiguousQueriesCount)

	if len(results)-ambiguousQueriesCount > 0 {
		correctCount := 0
		for _, result := range results {
			if result.Pred != "AMBIGUOUS_QUERY" && result.IsCorrect {
				correctCount++
			}
		}
		fmt.Printf("正确样例数: %d\n", correctCount)
		fmt.Printf("准确率: %.2f%%\n", float64(correctCount)*100/float64(len(results)-ambiguousQueriesCount))
	}

	// 输出合并后的错误大类统计
	fmt.Println("\n错误大类分布:")
	totalErrorCount := len(incorrectResults)

	// 输出列错误和行错误的比例
	columnErrorPercentage := float64(columnErrors) * 100 / float64(totalErrorCount)
	rowErrorPercentage := float64(rowErrors) * 100 / float64(totalErrorCount)
	fmt.Printf("- 列错误: %d (%.2f%%)\n", columnErrors, columnErrorPercentage)
	fmt.Printf("- 行错误: %d (%.2f%%)\n", rowErrors, rowErrorPercentage)

	// 输出详细错误原因统计（用于参考）
	fmt.Println("\n详细错误原因分布:")
	type reasonCount struct {
		reason string
		count  int
	}

	var reasonCounts []reasonCount
	for r, c := range detailedErrorReasons {
		reasonCounts = append(reasonCounts, reasonCount{r, c})
	}

	// 按数量排序
	sort.Slice(reasonCounts, func(i, j int) bool {
		return reasonCounts[i].count > reasonCounts[j].count
	})

	for _, rc := range reasonCounts {
		percentage := float64(rc.count) * 100 / float64(totalErrorCount)
		fmt.Printf("- %s: %d (%.2f%%)\n", rc.reason, rc.count, percentage)
	}

	fmt.Println(strings.Repeat("=", 50))

	// 统计模糊查询和错误查询目录
	ambiguousDir := filepath.Join(*resultDir, "ambiguous_queries")
	incorrectDir := filepath.Join(*resultDir, "incorrect_queries")

	if _, err := os.Stat(ambiguousDir); !os.IsNotExist(err) {
		files, err := os.ReadDir(ambiguousDir)
		if err == nil {
			fmt.Printf("模糊查询目录文件数: %d\n", len(files))
		}
	}

	if _, err := os.Stat(incorrectDir); !os.IsNotExist(err) {
		files, err := os.ReadDir(incorrectDir)
		if err == nil {
			fmt.Printf("错误查询目录文件数: %d\n", len(files))
		}
	}
}

// classifyErrorReason 将错误原因分类为标准类别
// 列错误: 列数错误、列选择错误、类型错误、列/字段错误
// 行错误: 行数错误、语法错误、执行错误、表/关系错误、连接错误等
func classifyErrorReason(errorReason string) string {
	// 如果错误原因为空，返回“未知原因”
	if errorReason == "" {
		return "未知原因"
	}

	// 先分离行错误和列错误
	rowCountRegex := regexp.MustCompile("(?i)(row|行).*(count|number|different|数|不同)|(行\\s*\\d+).*(列\\s*\\d+)\\s*的值不同")

	// 检测行列数量错误
	if rowCountRegex.MatchString(errorReason) && strings.Contains(errorReason, "行数不同") {
		return "行数错误"
	}
	if regexp.MustCompile("列数不同: (\\d+) vs (\\d+)").MatchString(errorReason) {
		return "列数错误"
	}
	if regexp.MustCompile("column.*(count|number).*different.*?(\\d+).*?(\\d+)").MatchString(errorReason) {
		return "列数错误"
	}

	// 检测行中的列值错误
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

	// 使用正则表达式匹配其他常见错误模式
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

// isColumnError 判断错误原因是否属于列错误
func isColumnError(reason string) bool {
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

	// 默认其他错误都算作行错误
	return false
}
