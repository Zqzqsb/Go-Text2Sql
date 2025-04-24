package query_validator

import (
	"context"
	"regexp"
	"strings"
	
	"github.com/zqzqsb/gosql/internal/agents/base"
	"github.com/zqzqsb/gosql/internal/llm"
)

// QueryValidator 实现了模糊查询检测Agent
type QueryValidator struct {
	patterns       []*regexp.Regexp
	ambiguousTerms []string
	config         map[string]interface{}
	llmClient      llm.LLM
	useLLM         bool
}

// NewQueryValidator 创建新的查询验证Agent
func NewQueryValidator() *QueryValidator {
	return &QueryValidator{
		patterns:       AmbiguousPatterns,
		ambiguousTerms: AmbiguousTerms,
		config:         make(map[string]interface{}),
		useLLM:         false,
	}
}

// WithLLM 设置LLM客户端
func (qv *QueryValidator) WithLLM(client llm.LLM) *QueryValidator {
	qv.llmClient = client
	qv.useLLM = true
	return qv
}

// WithConfig 设置配置并返回实例
func (qv *QueryValidator) WithConfig(config map[string]interface{}) *QueryValidator {
	qv.config = config
	return qv
}

// GetName 实现Agent接口
func (qv *QueryValidator) GetName() string {
	return "query_validator"
}

// GetDescription 实现Agent接口
func (qv *QueryValidator) GetDescription() string {
	return "检测并处理模糊查询，提供澄清问题"
}

// CanHandle 实现Agent接口
func (qv *QueryValidator) CanHandle(input interface{}) bool {
	_, ok := input.(string)
	return ok
}

// Execute 实现Agent接口
func (qv *QueryValidator) Execute(ctx context.Context, input interface{}) base.AgentResult {
	query, ok := input.(string)
	if !ok {
		return base.AgentResult{
			Success: false,
			Error:   "输入类型必须是字符串",
		}
	}
	
	isAmbiguous, ambiguousType, confidence := qv.DetectAmbiguity(ctx, query)
	if !isAmbiguous {
		return base.AgentResult{
			Success: true,
			Data:    false,  // 不是模糊查询
			Metadata: map[string]interface{}{
				"is_ambiguous": false,
				"confidence":   confidence,
			},
		}
	}
	
	// 生成澄清问题
	clarificationQuestions := GenerateClarificationQuestions(query)
	
	return base.AgentResult{
		Success: true,
		Data:    true,  // 是模糊查询
		Metadata: map[string]interface{}{
			"is_ambiguous":            true,
			"ambiguous_type":          ambiguousType,
			"clarification_questions": clarificationQuestions,
			"confidence":              confidence,
		},
		NextActions: []string{"request_clarification"},
	}
}

// DetectAmbiguity 检测查询的模糊性，结合规则和LLM
func (qv *QueryValidator) DetectAmbiguity(ctx context.Context, query string) (bool, string, float64) {
	// 首先使用规则检测
	isAmbiguousByRules, ambiguousType := qv.IsAmbiguousQuery(query)
	
	// 如果没有启用LLM或者规则已经明确判定为模糊，直接返回结果
	if !qv.useLLM || (isAmbiguousByRules && ambiguousType == "placeholder") {
		return isAmbiguousByRules, ambiguousType, 1.0 // 规则匹配时置信度为1.0
	}
	
	// 使用LLM进行模糊性检测
	isAmbiguousByLLM, confidenceScore, llmReason := qv.detectAmbiguityWithLLM(ctx, query)
	
	// 结合规则和LLM的结果
	// 如果规则判定为模糊，但LLM判定为明确，使用更高的阈值
	if isAmbiguousByRules && !isAmbiguousByLLM && confidenceScore > 0.8 {
		return false, "", confidenceScore
	}
	
	// 如果规则判定为明确，但LLM判定为模糊，使用更高的阈值
	if !isAmbiguousByRules && isAmbiguousByLLM && confidenceScore > 0.7 {
		return true, "llm_detected:" + llmReason, confidenceScore
	}
	
	// 其他情况优先使用规则的结果
	if isAmbiguousByRules {
		return true, ambiguousType, confidenceScore
	}
	
	return isAmbiguousByLLM, "llm_detected:" + llmReason, confidenceScore
}

// detectAmbiguityWithLLM 使用LLM检测查询的模糊性
func (qv *QueryValidator) detectAmbiguityWithLLM(ctx context.Context, query string) (bool, float64, string) {
	if qv.llmClient == nil {
		return false, 0.0, ""
	}
	
	// 构建提示
	prompt := `作为SQL查询解析专家，请判断以下自然语言查询是否含有模糊或不明确的条件，需要用户进一步澄清？
查询中如果含有"特定"、"某个"、"指定"等词语，或者使用了占位符，一般表示需要进一步明确。
请分析该查询是否可以直接转换为明确的SQL，还是需要获取更多信息。

请按照以下JSON格式回答：
{
  "is_ambiguous": true/false,  // 查询是否模糊
  "confidence": 0.0-1.0,       // 判断的置信度，0.0-1.0
  "reason": "判断理由",         // 简短解释为什么查询是模糊的或明确的
  "missing_info": ["缺失的信息1", "缺失的信息2"]  // 如果模糊，列出缺失的信息
}

查询: ` + query

	// 发送到LLM
	options := llm.Options{
		Temperature: 0.1,
		MaxTokens:   500,
	}
	
	response, err := qv.llmClient.GenerateSQL(prompt, options)
	if err != nil {
		// LLM调用失败时，回退到规则判断
		return false, 0.5, "llm_error"
	}
	
	// 解析LLM响应
	llmResponse, err := ParseLLMResponse(response.Response)
	if err != nil {
		// 解析失败时，使用简单的字符串匹配
		isAmbiguous := strings.Contains(response.Response, `"is_ambiguous": true`) || 
		               strings.Contains(response.Response, `"is_ambiguous":true`)
		return isAmbiguous, 0.6, "parse_error"
	}
	
	// 如果LLM返回结果包含缺失信息，将其添加到上下文
	if len(llmResponse.MissingInfo) > 0 {
		// 生成基于LLM的澄清问题
		_ = GenerateClarificationQuestionsFromLLM(llmResponse)
		
		// 将这些问题保存到上下文中，以便后续使用
		// 这需要在实际集成时处理
	}
	
	return llmResponse.IsAmbiguous, llmResponse.Confidence, llmResponse.Reason
}

// IsAmbiguousQuery 检查查询是否包含模糊条件（基于规则）
func (qv *QueryValidator) IsAmbiguousQuery(query string) (bool, string) {
	// 检查是否包含模糊术语
	for _, term := range qv.ambiguousTerms {
		if strings.Contains(strings.ToLower(query), strings.ToLower(term)) {
			return true, "ambiguous_term"
		}
	}
	
	// 检查是否匹配模糊模式
	for _, pattern := range qv.patterns {
		if pattern.MatchString(query) {
			return true, "pattern_match"
		}
	}
	
	// 检查是否有明显的占位符
	if strings.Contains(query, "___") || 
	   strings.Contains(query, "...") || 
	   strings.Contains(query, "[填写]") ||
	   strings.Contains(query, "[请输入]") {
		return true, "placeholder"
	}
	
	return false, ""
}
