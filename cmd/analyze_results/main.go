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

// SQLResult 结构 - 匹配info.jsonl格式
// DBType 表示支持的数据库类型
type DBType int

// 数据库类型枚举
const (
	DBTypeUnknown DBType = iota
	DBTypeSQLite
	DBTypePostgreSQL
	DBTypeMySQL
)

// String 返回数据库类型的字符串表示
func (t DBType) String() string {
	switch t {
	case DBTypeSQLite:
		return "sqlite"
	case DBTypePostgreSQL:
		return "postgresql"
	case DBTypeMySQL:
		return "mysql"
	default:
		return "unknown"
	}
}

// parseDBType 将字符串转换为DBType
func parseDBType(dbType string) DBType {
	switch strings.ToLower(dbType) {
	case "sqlite":
		return DBTypeSQLite
	case "postgresql", "postgres":
		return DBTypePostgreSQL
	case "mysql":
		return DBTypeMySQL
	default:
		return DBTypeUnknown
	}
}

type SQLResult struct {
	ID           int                    `json:"idx"`                     // 样例ID
	DBName       string                 `json:"db_id"`                   // 数据ID
	Question     string                 `json:"query"`                   // 用户查询问题
	Pred         string                 `json:"pred"`                    // 预测的SQL
	GroundTruth  string                 `json:"ground_truth"`            // 标准SQL/参考答案
	IsCorrect    bool                   `json:"is_correct"`              // 是否正确
	IsEquivalent bool                   `json:"is_equivalent,omitempty"` // 语义等价性标识
	ErrorReason  string                 `json:"error_reason,omitempty"`  // 错误原因
	Thinking     string                 `json:"thinking,omitempty"`      // 思考过程
	DBSchema     string                 `json:"db_schema,omitempty"`     // 数据库Schema
	Metadata     map[string]interface{} `json:"metadata,omitempty"`      // 元数据
	SequenceNum  int                    `json:"sequence_num,omitempty"`  // 序列号
}

// 检查SQL语义等价性并更新结果
// 通过比较查询执行结果判断是否等价，即使查询语法不同（如表连接顺序不同）
func checkSQLEquivalence(results []SQLResult, dbDir string, dbType string) []SQLResult {
	// 验证数据库路径
	if dbDir == "" {
		fmt.Println("未提供数据库路径，跳过语义等价性检查")
		return results
	}

	// 先统计查询情况
	totalCount := len(results)
	correctCount := 0
	ambiguousCount := 0
	toCheckCount := 0

	// 统计查询类型
	for _, r := range results {
		if r.IsCorrect {
			correctCount++
		} else if r.Pred == "AMBIGUOUS_QUERY" {
			ambiguousCount++
		} else {
			toCheckCount++
		}
	}

	// 输出查询状态
	fmt.Printf("查询结果状态: 总数=%d, 已正确=%d, 模糊查询=%d, 需检查=%d\n",
		totalCount, correctCount, ambiguousCount, toCheckCount)

	// 遍历所有查询结果进行等价性判断
	equivalentCount := 0
	totalCheckedCount := 0 // 记录检查过的总数，用于比例计算
	for i := range results {
		// 已正确的查询无需检查
		if results[i].IsCorrect {
			continue
		}

		// 模糊查询已单独标记，跳过处理
		if results[i].Pred == "AMBIGUOUS_QUERY" {
			continue
		}

		// 确定数据库路径策略
		var dbPath string

		// 解析数据库类型
		dbTypeEnum := parseDBType(dbType)
		if dbTypeEnum == DBTypeUnknown {
			fmt.Printf("错误: 必须指定有效的数据库类型 (sqlite/postgresql/mysql)\n")
			continue
		}

		// 根据数据库类型构造连接字符串
		if dbTypeEnum == DBTypePostgreSQL {
			// PostgreSQL模式，只需要指定数据库名称
			// 用于Docker中运行的PostgreSQL实例
			// 使用pg:前缀，内部将使用默认的PostgreSQL连接参数
			dbPath = "pg:" + results[i].DBName
			fmt.Printf("使用Docker中的PostgreSQL数据库: %s\n", results[i].DBName)
		} else {
			// SQLite模式，需要完整的文件路径
			if dbDir == "" {
				fmt.Printf("错误: 使用SQLite时必须指定数据库目录\n")
				continue
			}

			dbPath = filepath.Join(dbDir, results[i].DBName)
			if fileInfo, err := os.Stat(dbPath); err == nil && fileInfo.IsDir() {
				// 如果是目录，尝试在其中找到SQLite文件
				dbPath = filepath.Join(dbPath, results[i].DBName+".sqlite")
			}
			fmt.Printf("使用SQLite数据库文件: %s\n", dbPath)
		}

		// 记录检查前的路径以便调试
		fmt.Printf("检查数据库路径: %s\n", dbPath)

		// 记录执行前的SQL语句，便于调试
		fmt.Printf("尝试执行SQL1: %s\n", strings.TrimSpace(results[i].Pred[:min(50, len(results[i].Pred))])+"...")
		fmt.Printf("尝试执行SQL2: %s\n", strings.TrimSpace(results[i].GroundTruth[:min(50, len(results[i].GroundTruth))])+"...")

		// 检查等价性
		isEquivalent, reasonMsg := erroranalysis.IsEquivalentSQL(dbPath, results[i].Pred, results[i].GroundTruth)

		// 记录执行结果
		if !isEquivalent && reasonMsg != "" {
			fmt.Printf("语义等价性检查失败原因: %s\n", reasonMsg)
		}

		// 更新记录检查的总数
		totalCheckedCount++

		// 更新等价性标记
		results[i].IsEquivalent = isEquivalent

		// 如果是语义等价的，也将其标记为正确
		if isEquivalent {
			results[i].IsCorrect = true
			results[i].ErrorReason = "" // 清空错误原因
			equivalentCount++
			fmt.Printf("发现语义等价SQL: %s %d\n", results[i].DBName, results[i].ID) // 打印每个报告结果
		} else if reasonMsg != "" {
			// 如果检查失败且有错误原因，更新错误原因
			results[i].ErrorReason = reasonMsg
		}
	}

	// 输出统计结果
	if totalCheckedCount > 0 {
		fmt.Printf("语义等价性检查: 找到 %d 个语义等价的SQL查询 (占总检查数的 %.2f%%)\n",
			equivalentCount, float64(equivalentCount)*100/float64(totalCheckedCount))
	} else {
		fmt.Printf("语义等价性检查: 没有查询需要进行语义等价性检查\n")
	}
	return results
}

func main() {
	// 命令行参数
	resultDir := flag.String("dir", "", "结果目录路径")
	dbDir := flag.String("db-dir", "", "数据库目录路径，用于找到相应的数据库文件")
	dbType := flag.String("db-type", "", "数据库类型，可选值为sqlite或postgresql")
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

	// 如果提供了数据库路径，执行语义等价性检查
	if *dbDir != "" {
		fmt.Println("正在执行SQL语义等价性检查...")

		// 如果没有明确指定数据库类型，尝试自动检测
		actualDbType := *dbType
		if actualDbType == "" {
			// 根据路径特征自动检测数据库类型
			if strings.Contains(*dbDir, "pg") || strings.Contains(*dbDir, "postgres") {
				actualDbType = "postgresql"
				fmt.Println("自动检测到PostgreSQL数据库")
			} else {
				actualDbType = "sqlite"
				fmt.Println("自动检测到SQLite数据库")
			}
		} else {
			fmt.Printf("使用指定的数据库类型: %s\n", actualDbType)
		}

		results = checkSQLEquivalence(results, *dbDir, actualDbType)
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

	// 预先创建目录路径
	incorrectDir := filepath.Join(*resultDir, "incorrect_queries")

	// 收集所有非模糊但错误的查询
	for _, result := range results {
		if result.Pred != "AMBIGUOUS_QUERY" && !result.IsCorrect {

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
	fmt.Println("\n" + strings.Repeat("=", 50))
	fmt.Println("SQL评测报告")
	fmt.Println(strings.Repeat("-", 50))

	// 定义有效样例计数
	validCount := len(results) - ambiguousQueriesCount

	if validCount > 0 {
		// 统计正确查询和语义等价查询
		correctCount := 0
		equivalentCount := 0
		for _, result := range results {
			if result.Pred != "AMBIGUOUS_QUERY" {
				if result.IsCorrect {
					correctCount++
				}
				if result.IsEquivalent {
					equivalentCount++
				}
			}
		}

		// 计算统计数据
		exactMatchCount := correctCount - equivalentCount // 提取精确匹配的数量
		errorCount := validCount - correctCount

		// 1. 总体统计
		fmt.Println("1. 总体统计")
		fmt.Printf("  • 总样例数: %d\n", len(results))
		fmt.Printf("  • 有效样例数: %d (排除 %d 个模糊查询, %.2f%%)\n",
			validCount,
			ambiguousQueriesCount,
			float64(ambiguousQueriesCount)*100/float64(len(results)))

		// 2. 正确/错误分布
		fmt.Println("\n2. 正确/错误分布")
		fmt.Printf("  • 正确查询: %d (%.2f%%)\n", correctCount, float64(correctCount)*100/float64(validCount))
		fmt.Printf("  • 错误查询: %d (%.2f%%)\n", errorCount, float64(errorCount)*100/float64(validCount))

		// 输出语义等价性相关数据
		fmt.Printf("\n3. 正确查询细分\n")
		fmt.Printf("  • 精确匹配: %d (%.2f%% 占总体)\n", exactMatchCount, float64(exactMatchCount)*100/float64(validCount))
		// 注意：这里只显示主流程中检测到的语义等价查询
		// 错误目录分析中的语义等价查询将在后面单独显示
		fmt.Printf("  • 语义等价: %d (%.2f%% 占总体)\n", equivalentCount, float64(equivalentCount)*100/float64(validCount))
	}

	// 计算总错误数量（包含数据库错误）
	// 重新统计正确和错误查询的数量，考虑语义等价性
	correctCount := 0
	for _, result := range results {
		if result.Pred != "AMBIGUOUS_QUERY" && result.IsCorrect {
			correctCount++
		}
	}
	totalErrorCount := validCount - correctCount

	if totalErrorCount > 0 {
		// 计算错误大类的百分比
		columnErrorPercentage := float64(columnErrors) * 100 / float64(totalErrorCount)
		rowErrorPercentage := float64(rowErrors) * 100 / float64(totalErrorCount)

		// 4. 错误查询细分
		fmt.Println("\n4. 错误查询细分")

		// 先输出错误大类
		fmt.Printf("  4.1 错误大类\n")
		fmt.Printf("    • 列错误: %d (%.2f%%)\n", columnErrors, columnErrorPercentage)
		fmt.Printf("    • 行错误: %d (%.2f%%)\n", rowErrors, rowErrorPercentage)
	}

	fmt.Println("\n" + strings.Repeat("=", 50))

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

			// 统计数据库不存在错误和语义等价查询
			// 只需要使用dbErrors变量，其他就不单独计数了
			dbErrors, _, _, _ := AnalyzeIncorrectQueries(incorrectDir)

			// 计算语义等价查询的数量和比例
			// 统计文件中以标记为IsEquivalent=true的文件数
			equivalentCount := 0
			equivalentIDSet := make(map[int]bool) // 用于跟踪等价查询的ID
			for _, file := range files {
				filePath := filepath.Join(incorrectDir, file.Name())
				data, err := os.ReadFile(filePath)
				if err != nil {
					continue
				}

				var result IncorrectQueryResult
				if err := json.Unmarshal(data, &result); err != nil {
					continue
				}

				if result.IsEquivalent {
					equivalentCount++
					equivalentIDSet[result.ID] = true

					// 更新主要结果列表中对应的项
					for i := range results {
						if results[i].ID == result.ID {
							results[i].IsEquivalent = true
							results[i].IsCorrect = true // 语义等价应视为正确
							break
						}
					}
				}
			}

			// 输出错误目录中的语义等价查询统计
			fmt.Printf("\n错误目录语义等价性分析 (增补检查):\n")
			totalIncorrect := len(files)
			fmt.Printf("  • 错误目录中发现的语义等价查询: %d (%.2f%% 占错误数)\n",
				equivalentCount,
				float64(equivalentCount)*100/float64(totalIncorrect))

			// 重新计算错误统计 - 将数据库不存在错误计入执行错误
			detailedErrorReasons["执行错误"] += dbErrors
			rowErrors += dbErrors

			// 生成语义等价查询的挂载文件
			if equivalentCount > 0 {
				// 将语义等价查询时的结果写入源文件
				jsonlFile := filepath.Join(*resultDir, "info.jsonl")
				outFile, err := os.Create(jsonlFile + ".updated")
				if err == nil {
					defer outFile.Close()

					// 将更新后的结果重新写入文件
					for _, result := range results {
						data, _ := json.Marshal(result)
						outFile.WriteString(string(data) + "\n")
					}

					// 将分析结果保存到单独的文件
					analysisFile := jsonlFile + ".analysis"
					os.Rename(jsonlFile+".updated", analysisFile)
					fmt.Printf("\n分析结果已保存到: %s\n", analysisFile)
				}
			}

			// 重新统计正确的查询数量
			correctCount := 0
			for _, result := range results {
				if result.Pred != "AMBIGUOUS_QUERY" && result.IsCorrect {
					correctCount++
				}
			}
			validCount := len(results) - ambiguousQueriesCount
			totalErrorCount = validCount - correctCount

			// 重新输出错误大类分布
			fmt.Println("\n更新后的错误大类分布（考虑语义等价性）:")
			if totalErrorCount > 0 { // 避免除零错误
				columnErrorPercentage := float64(columnErrors) * 100 / float64(totalErrorCount)
				rowErrorPercentage := float64(rowErrors) * 100 / float64(totalErrorCount)
				fmt.Printf("- 列错误: %d (%.2f%%)\n", columnErrors, columnErrorPercentage)
				fmt.Printf("- 行错误: %d (%.2f%%)\n", rowErrors, rowErrorPercentage)

				// 重新输出详细错误原因分布
				fmt.Println("\n更新后的详细错误原因分布:")

				// 将错误原因按次数排序
				type errorCount struct {
					reason string
					count  int
				}
				var sortedErrors []errorCount
				for reason, count := range detailedErrorReasons {
					sortedErrors = append(sortedErrors, errorCount{reason, count})
				}
				sort.Slice(sortedErrors, func(i, j int) bool {
					return sortedErrors[i].count > sortedErrors[j].count
				})

				// 按频率降序输出错误类型
				for _, item := range sortedErrors {
					percentage := float64(item.count) * 100 / float64(totalErrorCount)
					fmt.Printf("- %s: %d (%.2f%%)\n", item.reason, item.count, percentage)
				}
			}
		}
	}
}

// IncorrectQueryResult 表示错误查询的JSON结构
type IncorrectQueryResult struct {
	ID           int    `json:"id"`
	DBID         string `json:"db_id"`
	Question     string `json:"question"`
	GTSQL        string `json:"gt_sql"`
	PredSQL      string `json:"pred_sql"`
	IsCorrect    bool   `json:"is_correct"`
	IsEquivalent bool   `json:"is_equivalent"`
	ErrorReason  string `json:"error_reason"`
	GTResult     *struct {
		Success bool       `json:"Success"`
		Error   string     `json:"Error"`
		Rows    [][]string `json:"Rows"`
	} `json:"gt_result"`
	PredResult *struct {
		Success bool       `json:"Success"`
		Error   string     `json:"Error"`
		Rows    [][]string `json:"Rows"`
	} `json:"pred_result"`
}

// AnalyzeIncorrectQueries 分析incorrect_queries目录中的JSON文件，检测SQL语义等价性
// 返回值: 数据库错误数量, 语法错误数量, 投影错误数量, 其他错误数量
func AnalyzeIncorrectQueries(dirPath string) (int, int, int, int) {
	// 错误类型计数
	dbNotExistCount := 0
	syntaxErrorCount := 0
	projectionErrorCount := 0
	otherErrorCount := 0
	totalFileCount := 0
	// 语义等价查询计数
	equivalentQueryCount := 0

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

			// 跳过已经标记为等价的文件
			if result.IsEquivalent {
				equivalentQueryCount++
				return nil
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

			// 排除数据库相关的错误，进行其他分类和语义等价性检查
			if !hasDBError {
				// 判断查询是否语义等价（基于查询结果）
				if result.PredResult != nil && result.GTResult != nil &&
					result.PredResult.Success && result.GTResult.Success {

					// 只有在两个结果都有数据时才比较内容
					// 注意：空结果也是合法结果，需要考虑
					isEquivalent := false

					// 第一步：如果两个查询都返回空结果（只有列标题行），则视为等价
					if len(result.PredResult.Rows) == 1 && len(result.GTResult.Rows) == 1 {
						isEquivalent = true
					} else if len(result.PredResult.Rows) > 0 && len(result.GTResult.Rows) > 0 {
						// 检查列数是否相同
						if len(result.PredResult.Rows[0]) == len(result.GTResult.Rows[0]) {
							// 检查行数是否相同
							if len(result.PredResult.Rows) == len(result.GTResult.Rows) {
								// 将结果转换为集合进行无序比较
								predRowsSet := make(map[string]bool)
								gtRowsSet := make(map[string]bool)

								// 跳过列标题行，只比较数据行
								for i := 1; i < len(result.PredResult.Rows); i++ {
									rowStr := strings.Join(result.PredResult.Rows[i], "\t")
									predRowsSet[rowStr] = true
								}

								for i := 1; i < len(result.GTResult.Rows); i++ {
									rowStr := strings.Join(result.GTResult.Rows[i], "\t")
									gtRowsSet[rowStr] = true
								}

								// 检查集合是否完全相同（忽略顺序）
								isEquivalent = true

								if len(predRowsSet) != len(gtRowsSet) {
									isEquivalent = false
								} else {
									// 检查pred结果中的每一行是否都在gt结果中存在
									for rowStr := range predRowsSet {
										if !gtRowsSet[rowStr] {
											isEquivalent = false
											break
										}
									}
								}
							}
						}
					}

					// 如果两个SQL查询实际上是等价的
					if isEquivalent {
						// 更新等价性标志
						result.IsEquivalent = true
						result.IsCorrect = true // 同时标记为正确
						equivalentQueryCount++

						// 将分析结果保存到单独的文件
						analysisPath := path + ".analysis"
						updatedData, _ := json.MarshalIndent(result, "", "  ")
						_ = os.WriteFile(analysisPath, updatedData, 0644)
						fmt.Printf("找到等价SQL: %s (分析结果已保存到: %s)\n",
							filepath.Base(path), filepath.Base(analysisPath))
						return nil // 跳过错误统计
					}
				}

				// 如果不是语义等价，进行错误分类
				if result.GTResult != nil && result.GTResult.Error != "" {
					if strings.Contains(result.GTResult.Error, "syntax error") {
						syntaxErrorCount++
					} else {
						otherErrorCount++
					}
				} else if result.ErrorReason == "" { // 没有错误原因通常是投影错误
					projectionErrorCount++
				} else {
					// 使用erroranalysis包中的错误分类功能
					reason := erroranalysis.ClassifyErrorReason(result.ErrorReason)
					if reason == "投影错误" {
						projectionErrorCount++
					} else if reason == "参考答案有语法错误" {
						syntaxErrorCount++
					} else {
						otherErrorCount++
					}
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
