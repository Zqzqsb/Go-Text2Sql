package main

import (
	"bufio"
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"github.com/zqzqsb/gosql/internal/erroranalysis"
)

// SQLResult 结果结构 - 匹配info.jsonl格式
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
	
	// 预先创建目录路径
	incorrectDir := filepath.Join(*resultDir, "incorrect_queries")

	// 收集所有非模糊但错误的查询
	for _, result := range results {
		if result.Pred != "AMBIGUOUS_QUERY" && !result.IsCorrect {
			incorrectResults = append(incorrectResults, result)
			
			// 错误分类逻辑
			errorReason := result.ErrorReason
			
			// 如果错误原因为空，默认分类为“投影错误”
			if errorReason == "" {
				errorReason = "投影错误"
			}
			
			reason := erroranalysis.ClassifyErrorReason(errorReason)
			detailedErrorReasons[reason]++

			// 判断是列错误还是行错误
			if erroranalysis.IsColumnError(reason) {
				columnErrors++
			} else {
				rowErrors++
			}
		}
	}

	// 检查incorrect_queries目录中的数据库错误，并将其整合到总统计中
	if _, err := os.Stat(incorrectDir); !os.IsNotExist(err) {
		// 统计数据库不存在错误
		dbErrors, _, _, _ := AnalyzeIncorrectQueries(incorrectDir)
		
		// 将数据库错误计入执行错误
		detailedErrorReasons["执行错误"] += dbErrors
		rowErrors += dbErrors
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

	// 计算总错误数量（包含数据库错误）
	totalErrorCount := columnErrors + rowErrors // 总错误数 = 列错误 + 行错误

	// 输出错误大类统计
	fmt.Println("\n错误大类分布:")

	// 输出列错误和行错误的比例
	columnErrorPercentage := float64(columnErrors) * 100 / float64(totalErrorCount)
	rowErrorPercentage := float64(rowErrors) * 100 / float64(totalErrorCount)
	fmt.Printf("- 列错误: %d (%.2f%%)\n", columnErrors, columnErrorPercentage)
	fmt.Printf("- 行错误: %d (%.2f%%)\n", rowErrors, rowErrorPercentage)

	// 输出详细错误原因统计
	fmt.Println("\n详细错误原因分布:")
	
	// 将错误原因按次数排序
	type reasonCount struct {
		reason string
		count  int
		example SQLResult // 每种错误类型的示例
	}
	
	// 收集错误类型、计数和示例
	reasonToExample := make(map[string]SQLResult)
	for _, result := range incorrectResults {
		reason := erroranalysis.ClassifyErrorReason(result.ErrorReason)
		// 只保存第一个遇到的每类错误的示例
		if _, exists := reasonToExample[reason]; !exists {
			reasonToExample[reason] = result
		}
	}
	
	var sortedReasons []reasonCount
	for reason, count := range detailedErrorReasons {
		example, _ := reasonToExample[reason]
		sortedReasons = append(sortedReasons, reasonCount{reason, count, example})
	}
	sort.Slice(sortedReasons, func(i, j int) bool {
		return sortedReasons[i].count > sortedReasons[j].count
	})
	
	// 输出按频率排序的错误原因统计
	for _, item := range sortedReasons {
		percentage := float64(item.count) * 100 / float64(totalErrorCount)
		fmt.Printf("- %s: %d (%.2f%%)\n", item.reason, item.count, percentage)
	}
	
	// 输出错误类型示例
	fmt.Println("\n各类错误示例:")
	for _, item := range sortedReasons {
		example := item.example
		fmt.Printf("\n[%s] 错误示例 (%d 个类似错误):\n", item.reason, item.count)
		fmt.Printf("  问题: %s\n", example.Question)
		fmt.Printf("  生成SQL: %s\n", erroranalysis.TruncateString(example.Pred, 120))
		fmt.Printf("  标准SQL: %s\n", erroranalysis.TruncateString(example.GroundTruth, 120))
		fmt.Printf("  错误原因: %s\n", erroranalysis.TruncateString(example.ErrorReason, 120))
	}

	fmt.Println(strings.Repeat("=", 50))

	// 统计模糊查询和错误查询目录
	ambiguousDir := filepath.Join(*resultDir, "ambiguous_queries")
	// 已在前面声明了incorrectDir，这里只需要赋值

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
			
			// 统计数据库不存在错误
			dbErrors, _, _, _ := AnalyzeIncorrectQueries(incorrectDir)
			
			// 重新计算错误统计 - 将数据库不存在错误计入执行错误
			detailedErrorReasons["执行错误"] += dbErrors
			rowErrors += dbErrors
			// 保持与前面一致的错误统计方式
			totalErrorCount = columnErrors + rowErrors
			
			// 重新输出错误大类分布
			fmt.Println("\n更新后的错误大类分布:")
			columnErrorPercentage := float64(columnErrors) * 100 / float64(totalErrorCount)
			rowErrorPercentage := float64(rowErrors) * 100 / float64(totalErrorCount)
			fmt.Printf("- 列错误: %d (%.2f%%)\n", columnErrors, columnErrorPercentage)
			fmt.Printf("- 行错误: %d (%.2f%%)\n", rowErrors, rowErrorPercentage)
			
			// 重新输出详细错误原因分布
			fmt.Println("\n更新后的详细错误原因分布:")
			for reason, count := range detailedErrorReasons {
				percentage := float64(count) * 100 / float64(totalErrorCount)
				fmt.Printf("- %s: %d (%.2f%%)\n", reason, count, percentage)
			}
		}
	}
}

// IncorrectQueryResult 表示错误查询的JSON结构
type IncorrectQueryResult struct {
	ID          int       `json:"id"`
	DBID        string    `json:"db_id"`
	Question    string    `json:"question"`
	GTSQL       string    `json:"gt_sql"`
	PredSQL     string    `json:"pred_sql"`
	IsCorrect   bool      `json:"is_correct"`
	IsEquivalent bool     `json:"is_equivalent"`
	ErrorReason string    `json:"error_reason"`
	GTResult    *struct {
		Success bool        `json:"Success"`
		Error   string      `json:"Error"`
		Rows    [][]string  `json:"Rows"`
	} `json:"gt_result"`
	PredResult  *struct {
		Success bool        `json:"Success"`
		Error   string      `json:"Error"`
		Rows    [][]string  `json:"Rows"`
	} `json:"pred_result"`
}

// AnalyzeIncorrectQueries 分析incorrect_queries目录中的JSON文件
// 返回值: 数据库错误数量, 语法错误数量, 投影错误数量, 其他错误数量
func AnalyzeIncorrectQueries(dirPath string) (int, int, int, int) {
	// 错误类型计数
	dbNotExistCount := 0
	syntaxErrorCount := 0
	projectionErrorCount := 0
	otherErrorCount := 0
	totalFileCount := 0
	
	// 遍历目录中的所有JSON文件
	err := filepath.Walk(dirPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return nil // 忽略访问错误，继续遍历
		}
		
		// 只处理JSON文件
		if !info.IsDir() && strings.HasSuffix(strings.ToLower(info.Name()), ".json") {
			totalFileCount++
			
			// 读取文件内容
			data, err := os.ReadFile(path)
			if err != nil {
				fmt.Printf("读取文件失败: %s, 错误: %v\n", path, err)
				return nil // 继续处理其他文件
			}
			
			// 解析JSON
			var result IncorrectQueryResult
			if err := json.Unmarshal(data, &result); err != nil {
				fmt.Printf("解析JSON失败: %s, 错误: %v\n", path, err)
				return nil // 继续处理其他文件
			}
			
			// 检查数据库不存在错误
			hasDBError := false
			
			// 检查GT结果中的数据库错误
			if result.GTResult != nil && result.GTResult.Error != "" {
				if strings.Contains(result.GTResult.Error, "database") && 
				   strings.Contains(result.GTResult.Error, "does not exist") {
					dbNotExistCount++
					hasDBError = true
				}
			}
			
			// 检查Pred结果中的数据库错误 (如果还没有找到)
			if !hasDBError && result.PredResult != nil && result.PredResult.Error != "" {
				if strings.Contains(result.PredResult.Error, "database") && 
				   strings.Contains(result.PredResult.Error, "does not exist") {
					dbNotExistCount++
					hasDBError = true
				}
			}
			
			// 如果不是数据库错误，则根据错误原因分类
			if !hasDBError {
				// 精确分类其他类型的错误
				if result.GTResult != nil && result.GTResult.Error != "" {
					if strings.Contains(result.GTResult.Error, "syntax error") {
						syntaxErrorCount++
					} else {
						otherErrorCount++
					}
				} else if result.ErrorReason == "" { // 没有错误原因通常是投影错误
					projectionErrorCount++
				} else {
					otherErrorCount++
				}
			}
		}
		return nil
	})
	
	if err != nil {
		fmt.Printf("遍历目录失败: %v\n", err)
		return dbNotExistCount, syntaxErrorCount, projectionErrorCount, otherErrorCount
	}
	
	// 输出统计结果
	fmt.Println("\n错误查询文件详细分析:")
	fmt.Printf("- 数据库不存在错误: %d (%.2f%%)\n", dbNotExistCount, float64(dbNotExistCount)*100/float64(totalFileCount))
	fmt.Printf("- 语法错误: %d (%.2f%%)\n", syntaxErrorCount, float64(syntaxErrorCount)*100/float64(totalFileCount))
	fmt.Printf("- 投影错误: %d (%.2f%%)\n", projectionErrorCount, float64(projectionErrorCount)*100/float64(totalFileCount))
	fmt.Printf("- 其他错误: %d (%.2f%%)\n", otherErrorCount, float64(otherErrorCount)*100/float64(totalFileCount))
	
	// 返回统计结果
	return dbNotExistCount, syntaxErrorCount, projectionErrorCount, otherErrorCount
}

// 注意：错误原因分类逻辑已移至 internal/erroranalysis 包中

// 注意：字符串处理功能已移至 internal/erroranalysis 包中

// 注意：错误类型判断功能已移至 internal/erroranalysis 包中
