package main

import (
	"encoding/json"
	"fmt"
	"os"
	"sort"
	"strings"
)

// SQLResult 表示SQL预测结果
type SQLResult struct {
	ID          int                    `json:"idx"`
	DBName      string                 `json:"db_id"`
	Question    string                 `json:"query"`
	Pred        string                 `json:"pred"`
	GroundTruth string                 `json:"ground_truth"`
	IsCorrect   bool                   `json:"is_correct"`
	Thinking    string                 `json:"thinking,omitempty"`
	Metadata    map[string]interface{} `json:"metadata"`
	SequenceNum int                    `json:"sequence_num"`
}

func main() {
	if len(os.Args) != 3 {
		fmt.Println("用法: go run extract_sql.go <info.jsonl文件路径> <输出pred.sql文件路径>")
		os.Exit(1)
	}

	jsonlFile := os.Args[1]
	predFile := os.Args[2]

	// 读取JSONL文件
	data, err := os.ReadFile(jsonlFile)
	if err != nil {
		fmt.Printf("读取结果文件失败: %v\n", err)
		os.Exit(1)
	}

	// 解析JSONL
	var results []SQLResult
	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		if line == "" {
			continue
		}

		var result SQLResult
		if err := json.Unmarshal([]byte(line), &result); err != nil {
			fmt.Printf("解析结果行失败: %v\n", err)
			continue
		}

		results = append(results, result)
	}

	// 排序结果
	sort.Slice(results, func(i, j int) bool {
		return results[i].SequenceNum < results[j].SequenceNum
	})

	// 生成SQL文件
	var sqlLines []string
	for _, result := range results {
		// 将SQL查询中的换行符替换为空格，确保每个查询只占一行
		sql := strings.ReplaceAll(result.Pred, "\n", " ")
		// 移除多余的空格
		sql = strings.Join(strings.Fields(sql), " ")
		sqlLines = append(sqlLines, sql)
	}

	fmt.Printf("处理了 %d 条记录\n", len(results))
	fmt.Printf("生成了 %d 条SQL语句\n", len(sqlLines))

	err = os.WriteFile(predFile, []byte(strings.Join(sqlLines, "\n")), 0644)
	if err != nil {
		fmt.Printf("写入SQL文件失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("预测文件已保存到: %s\n", predFile)
}
