package tools

import (
	"context"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"
)

// QueryValidatorTool 提供查询验证能力
type QueryValidatorTool struct {
	llm     llms.Model
	patterns []string
}

// NewQueryValidatorTool 创建查询验证工具
func NewQueryValidatorTool(llm llms.Model) *QueryValidatorTool {
	// 定义常用的模糊查询模式
	patterns := []string{
		"特定", "某个", "特别", "具体",
		"某些", "一些", "一定", "指定",
		"specific", "particular", "certain",
		"some", "few", "given", "selected",
	}
	
	return &QueryValidatorTool{
		llm:     llm,
		patterns: patterns,
	}
}

// Name 返回工具名称
func (t *QueryValidatorTool) Name() string {
	return "validate_query"
}

// Description 返回工具描述
func (t *QueryValidatorTool) Description() string {
	return "验证用户查询是否明确，检测模糊查询并提供澄清建议"
}

// ParameterSchema 返回参数schema
func (t *QueryValidatorTool) ParameterSchema() map[string]string {
	return map[string]string{
		"query": "需要验证的用户查询",
	}
}

// Execute 执行工具
func (t *QueryValidatorTool) Execute(ctx context.Context, params map[string]interface{}) (string, error) {
	queryParam, ok := params["query"]
	if !ok {
		return "", fmt.Errorf("缺少查询参数")
	}
	
	query, ok := queryParam.(string)
	if !ok {
		return "", fmt.Errorf("查询参数必须是字符串")
	}
	
	// 简单模式匹配
	isAmbiguous, ambiguousTerms := t.checkAmbiguousPatterns(query)
	
	// 使用LLM进一步验证
	llmResult, err := t.validateWithLLM(ctx, query, isAmbiguous, ambiguousTerms)
	if err != nil {
		return "", err
	}
	
	return llmResult, nil
}

// checkAmbiguousPatterns 检查模糊模式
func (t *QueryValidatorTool) checkAmbiguousPatterns(query string) (bool, []string) {
	query = strings.ToLower(query)
	var ambiguousTerms []string
	
	for _, pattern := range t.patterns {
		if strings.Contains(query, pattern) {
			ambiguousTerms = append(ambiguousTerms, pattern)
		}
	}
	
	return len(ambiguousTerms) > 0, ambiguousTerms
}

// validateWithLLM 使用LLM验证查询
func (t *QueryValidatorTool) validateWithLLM(ctx context.Context, query string, isAmbiguous bool, ambiguousTerms []string) (string, error) {
	template := `
您的任务是判断用户查询是否清晰明确，以便能生成准确的SQL。

用户查询: %s

初始规则检查发现以下潜在的模糊性:
- 模糊词汇出现: %v
- 可能模糊: %v

请分析这个查询，并给出以下判断:
1. 这个查询是否模糊不清？
2. 如果模糊，具体哪些部分需要澄清？
3. 应该向用户提出什么澄清问题？

请用JSON格式回答:
{
  "isAmbiguous": true/false,
  "ambiguousAspects": ["方面1", "方面2"...],
  "clarificationQuestions": ["问题1", "问题2"...],
  "explanation": "详细解释"
}
`
	
	prompt := fmt.Sprintf(template, query, ambiguousTerms, isAmbiguous)
	
	response, err := t.llm.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return "", fmt.Errorf("LLM调用失败: %v", err)
	}
	
	return response, nil
}
