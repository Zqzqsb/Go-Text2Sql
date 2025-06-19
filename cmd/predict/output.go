package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

// 生成预测文件
func generatePredictionFile(jsonlFile string, predFile string) {
	var results []SQLResult

	// 读取jsonl文件
	data, err := os.ReadFile(jsonlFile)
	if err != nil {
		fmt.Printf("读取%s失败: %v\n", jsonlFile, err)
		return
	}

	// 按行解析
	lines := splitLines(string(data))
	for _, line := range lines {
		if line == "" {
			continue
		}

		// 首先尝试解析为交互式结果
		var interactiveResult InteractiveResult
		if err := json.Unmarshal([]byte(line), &interactiveResult); err == nil && (interactiveResult.IsInteractive || len(interactiveResult.Steps) > 0) {
			// 如果是交互式结果，提取 SQLResult 部分
			results = append(results, interactiveResult.SQLResult)
			continue
		}

		// 否则按普通结果解析
		var result SQLResult
		if err := json.Unmarshal([]byte(line), &result); err != nil {
			fmt.Printf("解析行失败: %v\n", err)
			continue
		}
		results = append(results, result)
	}

	// 生成预测文件
	predFileObj, err := os.Create(predFile)
	if err != nil {
		fmt.Printf("创建预测文件失败: %v\n", err)
		return
	}
	defer predFileObj.Close()

	for _, result := range results {
		if result.Ambiguous == "True" {
			// 对于模糊查询，写入特殊标记
			fmt.Fprintf(predFileObj, "AMBIGUOUS_QUERY\t%d\n", result.ID)
		} else {
			fmt.Fprintf(predFileObj, "%s\t%d\n", result.PredSQL, result.ID)
		}
	}

	fmt.Printf("预测文件已保存到: %s\n", predFile)

	// 创建sql_results子文件夹
	resultDir := filepath.Dir(jsonlFile)
	sqlResultsDir := filepath.Join(resultDir, "sql_results")
	if _, err := os.Stat(sqlResultsDir); os.IsNotExist(err) {
		if err := os.MkdirAll(sqlResultsDir, 0755); err != nil {
			fmt.Printf("创建SQL结果目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 创建错误SQL查询目录
	incorrectQueriesDir := filepath.Join(resultDir, "incorrect_queries")
	if _, err := os.Stat(incorrectQueriesDir); os.IsNotExist(err) {
		if err := os.MkdirAll(incorrectQueriesDir, 0755); err != nil {
			fmt.Printf("创建错误SQL查询目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 创建模糊问题目录
	ambiguousQueriesDir := filepath.Join(resultDir, "ambiguous_queries")
	if _, err := os.Stat(ambiguousQueriesDir); os.IsNotExist(err) {
		if err := os.MkdirAll(ambiguousQueriesDir, 0755); err != nil {
			fmt.Printf("创建模糊问题目录失败: %v\n", err)
			os.Exit(1)
		}
	}

	// 为每条SQL生成单独的结果文件
	for _, result := range results {
		if result.DBName == "" {
			continue // 跳过没有数据库名称的结果
		}

		// 创建简化的结果文件
		resultData := map[string]interface{}{
			"id":                 result.ID,
			"db_id":              result.DBName,
			"question":           result.Question,
			"gt_sql":             result.GTSQL,
			"pred_sql":           result.PredSQL,
			"thinking[optional]": result.Thinking,
		}

		// 如果是模糊查询，添加 Ambiguous 字段
		if result.Ambiguous == "True" {
			resultData["ambigous[optional]"] = result.Ambiguous
		}

		// 创建结果文件
		resultFileName := fmt.Sprintf("%d.json", result.ID)
		resultFilePath := filepath.Join(sqlResultsDir, resultFileName)

		// 写入结果文件
		resultJSON, err := json.MarshalIndent(resultData, "", "  ")
		if err != nil {
			fmt.Printf("序列化SQL结果失败: %v\n", err)
			continue
		}

		if err := os.WriteFile(resultFilePath, resultJSON, 0644); err != nil {
			fmt.Printf("写入SQL结果文件失败: %v\n", err)
			continue
		}

		// 如果是模糊查询，保存到模糊问题目录
		if result.Ambiguous == "True" {
			ambiguousFilePath := filepath.Join(ambiguousQueriesDir, fmt.Sprintf("ambiguous_%d.json", result.ID))
			if err := os.WriteFile(ambiguousFilePath, resultJSON, 0644); err != nil {
				fmt.Printf("写入模糊问题文件失败: %v\n", err)
			}
		}
	}

	fmt.Printf("SQL结果已保存到: %s\n", sqlResultsDir)
	fmt.Printf("模糊问题结果已保存到: %s\n", ambiguousQueriesDir)
}

// 保存交互式结果
func saveInteractiveResult(fp *os.File, result InteractiveResult) {
	// 将交互式结果转换为JSON并写入文件
	jsonData, err := json.Marshal(result)
	if err != nil {
		fmt.Printf("序列化交互式结果失败: %v\n", err)
		return
	}

	if _, err := fp.Write(jsonData); err != nil {
		fmt.Printf("写入交互式结果失败: %v\n", err)
		return
	}

	if _, err := fp.WriteString("\n"); err != nil {
		fmt.Printf("写入换行符失败: %v\n", err)
	}
}

// 输出交互式结果
func printInteractiveResult(result InteractiveResult) {
	fmt.Printf("样例ID: %d\n", result.ID)
	fmt.Printf("数据库: %s\n", result.DBName)
	fmt.Printf("问题: %s\n", result.Question)

	if result.IsInteractive {
		fmt.Printf("交互模式: 是 (%d步，%d次查询)\n", result.TotalSteps, result.QueryCount)
		fmt.Printf("查询步骤:\n")
		for i, step := range result.Steps {
			if step.StepType == "query" {
				fmt.Printf("  步骤%d - 查询: %s\n", i+1, step.Query)
				fmt.Printf("  推理: %s\n", step.Reasoning)
			} else {
				fmt.Printf("  步骤%d - 最终生成\n", i+1)
			}
		}
	} else {
		fmt.Printf("交互模式: 否\n")
	}

	fmt.Printf("预测SQL: %s\n", result.PredSQL)
	if result.Ambiguous == "True" {
		fmt.Printf("模糊查询: 是\n")
	}
	fmt.Println("---")
}

// 按行分割字符串
func splitLines(s string) []string {
	s = strings.ReplaceAll(s, "\r\n", "\n")
	return strings.Split(s, "\n")
}
