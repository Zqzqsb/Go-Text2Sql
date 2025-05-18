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
		if result.Ambiguous != "" {
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
			"id":               result.ID,
			"db_id":            result.DBName,
			"question":         result.Question,
			"gt_sql":           result.GTSQL,
			"pred_sql":         result.PredSQL,
			"thinking[optional]": result.Thinking,
		}
		
		// 如果是模糊查询，添加 Ambiguous 字段
		if result.Ambiguous != "" {
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
		if result.Ambiguous != "" {
			ambiguousFilePath := filepath.Join(ambiguousQueriesDir, fmt.Sprintf("ambiguous_%d.json", result.ID))
			if err := os.WriteFile(ambiguousFilePath, resultJSON, 0644); err != nil {
				fmt.Printf("写入模糊问题文件失败: %v\n", err)
			}
		}
	}

	fmt.Printf("SQL结果已保存到: %s\n", sqlResultsDir)
	fmt.Printf("模糊问题结果已保存到: %s\n", ambiguousQueriesDir)
}

// 按行分割字符串
func splitLines(s string) []string {
	return filepath.SplitList(strings.ReplaceAll(s, "\r\n", "\n"))
}
