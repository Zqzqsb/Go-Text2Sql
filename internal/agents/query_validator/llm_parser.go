package query_validator

import (
	"encoding/json"
	"fmt"
	"strings"
)

// LLMResponse 表示从LLM返回的检测结果
type LLMResponse struct {
	IsAmbiguous bool      `json:"is_ambiguous"`
	Confidence  float64   `json:"confidence"`
	Reason      string    `json:"reason"`
	MissingInfo []string  `json:"missing_info"`
}

// ParseLLMResponse 尝试解析LLM的响应为结构化数据
func ParseLLMResponse(response string) (*LLMResponse, error) {
	// 提取JSON部分
	jsonContent := extractJSON(response)
	if jsonContent == "" {
		return nil, fmt.Errorf("无法从响应中提取JSON")
	}
	
	var result LLMResponse
	err := json.Unmarshal([]byte(jsonContent), &result)
	if err != nil {
		return nil, fmt.Errorf("解析JSON失败: %v", err)
	}
	
	return &result, nil
}

// extractJSON 从响应文本中提取JSON部分
func extractJSON(text string) string {
	// 查找第一个{
	start := strings.Index(text, "{")
	if start == -1 {
		return ""
	}
	
	// 查找最后一个}
	end := strings.LastIndex(text, "}")
	if end == -1 || end <= start {
		return ""
	}
	
	// 提取JSON
	return text[start : end+1]
}

// GenerateClarificationQuestionsFromLLM 基于LLM响应生成澄清问题
func GenerateClarificationQuestionsFromLLM(llmResponse *LLMResponse) []ClarificationQuestion {
	var questions []ClarificationQuestion
	
	// 如果LLM提供了缺失信息，基于它们生成问题
	for i, info := range llmResponse.MissingInfo {
		question := ClarificationQuestion{
			Question: fmt.Sprintf("请提供%s的具体信息。", info),
			Type:     "llm_generated",
			Priority: i + 1,
		}
		questions = append(questions, question)
	}
	
	// 如果没有具体的缺失信息，但判定为模糊，提供一个通用问题
	if len(questions) == 0 && llmResponse.IsAmbiguous {
		question := ClarificationQuestion{
			Question: fmt.Sprintf("您的查询存在不明确之处: %s。请提供更多细节。", llmResponse.Reason),
			Type:     "llm_general",
			Priority: 1,
		}
		questions = append(questions, question)
	}
	
	return questions
}
