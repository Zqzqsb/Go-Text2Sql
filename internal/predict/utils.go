package predict

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"
)

// GetExampleID 获取样例ID
func GetExampleID(example map[string]interface{}) int {
	// 尝试从id字段获取
	if idVal, ok := example["id"]; ok {
		switch id := idVal.(type) {
		case float64:
			return int(id)
		case int:
			return id
		case string:
			// 尝试将字符串转换为整数
			var intID int
			if _, err := fmt.Sscanf(id, "%d", &intID); err == nil {
				return intID
			}
		}
	}

	// 如果没有id字段或无法解析，使用question的哈希值
	if question, ok := example["question"].(string); ok {
		return int(stringHash(question))
	}

	// 最后的后备方案：使用整个样例的哈希
	jsonBytes, _ := json.Marshal(example)
	return int(stringHash(string(jsonBytes)))
}

// stringHash 简单的字符串哈希函数
func stringHash(s string) uint32 {
	h := uint32(0)
	for i := 0; i < len(s); i++ {
		h = h*31 + uint32(s[i])
	}
	return h
}

// SaveResult 保存结果
func SaveResult(file *os.File, result SQLResult) {
	// 将结果序列化为JSON
	resultBytes, err := json.Marshal(result)
	if err != nil {
		fmt.Printf("序列化结果失败: %v\n", err)
		return
	}

	// 写入文件
	if _, err := file.Write(resultBytes); err != nil {
		fmt.Printf("写入结果失败: %v\n", err)
		return
	}

	// 写入换行符
	if _, err := file.WriteString("\n"); err != nil {
		fmt.Printf("写入换行符失败: %v\n", err)
		return
	}

	// 刷新文件
	if err := file.Sync(); err != nil {
		fmt.Printf("刷新文件失败: %v\n", err)
		return
	}
}

// PrintResult 输出结果
func PrintResult(result SQLResult) {
	fmt.Printf("ID: %d\n", result.ID)
	fmt.Printf("数据库: %s\n", result.DBName)
	fmt.Printf("问题: %s\n", result.Question)
	fmt.Printf("预测SQL: %s\n", result.PredSQL)

	// 如果有思考过程，输出思考过程的前200个字符
	if result.Thinking != "" {
		thinking := result.Thinking
		if len(thinking) > 200 {
			thinking = thinking[:200] + "..."
		}
		fmt.Printf("思考过程: %s\n", thinking)
	}

	fmt.Println(strings.Repeat("-", 80))
}
