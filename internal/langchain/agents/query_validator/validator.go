package query_validator

import (
	"context"
	"fmt"
	"regexp"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/prompts"
	"github.com/zqzqsb/gosql/internal/langchain/agents/base"
)

// QueryValidationResult holds the result of query validation
type QueryValidationResult struct {
	IsAmbiguous      bool     // Whether the query is ambiguous
	AmbiguousPattern string   // The detected ambiguity pattern
	ClarifyQuestion  string   // Question to ask for clarification
	DetectedEntities []string // Entities detected in the query
}

// QueryValidator detects ambiguous natural language queries and generates clarification questions
type QueryValidator struct {
	base.BaseAgent
	// Threshold for LLM ambiguity detection (0-1)
	AmbiguityThreshold float64
	// Whether to use rule-based detection
	UseRuleBased bool
	// Whether to use LLM-based detection
	UseLLMBased bool
}

// NewQueryValidator creates a new query validator agent
func NewQueryValidator(llmModel llms.Model) *QueryValidator {
	return &QueryValidator{
		BaseAgent: base.BaseAgent{
			Name:        "QueryValidator",
			Description: "Detects ambiguous queries and generates clarification questions",
			LLM:         llmModel,
		},
		AmbiguityThreshold: 0.7,
		UseRuleBased:       true,
		UseLLMBased:        true,
	}
}

// Execute implements the Agent interface
func (qv *QueryValidator) Execute(ctx context.Context, input interface{}) (base.AgentResult, error) {
	// Check input type
	var query string
	var ok bool
	
	switch v := input.(type) {
	case string:
		query = v
	case map[string]interface{}:
		if queryVal, exists := v["query"]; exists {
			if query, ok = queryVal.(string); !ok {
				return base.AgentResult{
					Success: false,
					Error:   "invalid query format in input map",
				}, nil
			}
		} else {
			return base.AgentResult{
				Success: false,
				Error:   "input map does not contain 'query' key",
			}, nil
		}
	case base.AgentContext:
		query = v.OriginalQuery
	case *base.AgentContext:
		query = v.OriginalQuery
	default:
		return base.AgentResult{
			Success: false,
			Error:   "input type not supported by QueryValidator",
		}, nil
	}

	// Perform validation
	result, err := qv.ValidateQuery(ctx, query)
	if err != nil {
		return base.AgentResult{
			Success: false,
			Error:   fmt.Sprintf("validation error: %v", err),
		}, err
	}

	return base.AgentResult{
		Success: true,
		Data: result,
		NextActions: func() []string {
			if result.IsAmbiguous {
				return []string{"Clarify"}
			}
			return []string{"SchemaAnalyze"}
		}(),
		Metadata: map[string]interface{}{
			"is_ambiguous":      result.IsAmbiguous,
			"ambiguous_pattern": result.AmbiguousPattern,
			"clarify_question":  result.ClarifyQuestion,
		},
	}, nil
}

// ValidateQuery checks if a query is ambiguous using rule-based and/or LLM-based detection
func (qv *QueryValidator) ValidateQuery(ctx context.Context, query string) (QueryValidationResult, error) {
	result := QueryValidationResult{
		IsAmbiguous: false,
	}

	// Rule-based detection
	if qv.UseRuleBased {
		isAmbiguous, pattern, entities := qv.detectAmbiguityByRules(query)
		if isAmbiguous {
			result.IsAmbiguous = true
			result.AmbiguousPattern = pattern
			result.DetectedEntities = entities
			
			// Generate clarification question
			result.ClarifyQuestion = qv.generateClarificationQuestion(pattern, entities)
			return result, nil
		}
	}

	// LLM-based detection (only if rule-based didn't detect ambiguity)
	if qv.UseLLMBased && !result.IsAmbiguous {
		isAmbiguous, clarification, err := qv.detectAmbiguityByLLM(ctx, query)
		if err != nil {
			return result, err
		}
		
		if isAmbiguous {
			result.IsAmbiguous = true
			result.ClarifyQuestion = clarification
		}
	}

	return result, nil
}

// detectAmbiguityByRules uses pattern matching to detect ambiguous queries
func (qv *QueryValidator) detectAmbiguityByRules(query string) (bool, string, []string) {
	lowercaseQuery := strings.ToLower(query)
	
	// Check for ambiguous patterns
	for _, scenario := range FuzzyScenarios {
		pattern := scenario.Pattern
		r, err := regexp.Compile(pattern)
		if err != nil {
			continue
		}
		
		matches := r.FindAllString(lowercaseQuery, -1)
		if len(matches) > 0 {
			// Extract entities (nouns) near the ambiguous pattern
			// In a real implementation, this would use more sophisticated NLP
			words := strings.Fields(lowercaseQuery)
			entities := extractEntitiesNearMatches(words, matches)
			
			return true, pattern, entities
		}
	}
	
	return false, "", nil
}

// extractEntitiesNearMatches extracts potential entities near ambiguous patterns
// This is a simplified implementation; in practice you'd use NLP tools
func extractEntitiesNearMatches(words []string, matches []string) []string {
	entities := make([]string, 0)
	
	// Simple extraction logic: look for nouns after ambiguous words
	// In practice, you'd use proper NLP for this
	for i, word := range words {
		for _, match := range matches {
			if strings.Contains(word, match) && i+1 < len(words) {
				// Assume the next word might be an entity
				entities = append(entities, words[i+1])
			}
		}
	}
	
	// If we couldn't find entities, use some defaults
	if len(entities) == 0 {
		entities = []string{"item", "record", "information"}
	}
	
	return entities
}

// generateClarificationQuestion creates a question to clarify ambiguous query
func (qv *QueryValidator) generateClarificationQuestion(pattern string, entities []string) string {
	// Find appropriate template for this pattern
	var templateStr string
	for patternKey, template := range ClarificationTemplates {
		if strings.Contains(pattern, patternKey) {
			templateStr = template
			break
		}
	}
	
	// If no matching template, use a default one
	if templateStr == "" {
		templateStr = "Your query is ambiguous. Could you provide more specific criteria for %s?"
	}
	
	// Use first entity or default to "items"
	entity := "items"
	if len(entities) > 0 {
		entity = entities[0]
	}
	
	// Format the template with detected ambiguous pattern and entity
	matchedPattern := pattern
	return fmt.Sprintf(templateStr, matchedPattern, entity)
}

// detectAmbiguityByLLM uses LLM to detect ambiguity and generate clarification
func (qv *QueryValidator) detectAmbiguityByLLM(ctx context.Context, query string) (bool, string, error) {
	if qv.LLM == nil {
		return false, "", fmt.Errorf("LLM model not set")
	}

	// LLM prompt template for ambiguity detection
	template := `
You are a database query validator that detects ambiguity in natural language queries.

Analyze the following query and determine if it is ambiguous (lacking specific filtering criteria).

Examples of ambiguous queries:
1. "Show me information about some customers"
2. "Get data for a specific product"
3. "Display transactions from certain dates"

Examples of clear queries:
1. "List all customers who made purchases in January 2023"
2. "Show product details for product ID 12345"
3. "Display all transactions between January 1, 2023 and January 31, 2023"

Query to analyze: "{{.query}}"

First, determine if the query is ambiguous. Then, if it is ambiguous, suggest a clarification question.

Output your analysis in this format:
AMBIGUOUS: [Yes/No]
REASON: [Briefly explain why the query is ambiguous or not]
CLARIFICATION: [If ambiguous, provide a clarification question]
`

	promptTemplate := prompts.NewPromptTemplate(template, []string{"query"})

	prompt, err := promptTemplate.Format(map[string]interface{}{
		"query": query,
	})
	if err != nil {
		return false, "", fmt.Errorf("failed to format prompt: %v", err)
	}

	// Call LLM
	response, err := qv.LLM.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return false, "", fmt.Errorf("LLM call failed: %v", err)
	}

	// Parse response
	isAmbiguous := strings.Contains(response, "AMBIGUOUS: Yes")
	
	// Extract clarification question
	clarification := ""
	if isAmbiguous {
		clarificationIdx := strings.Index(response, "CLARIFICATION:")
		if clarificationIdx >= 0 {
			clarification = strings.TrimSpace(response[clarificationIdx+14:])
		}
	}

	return isAmbiguous, clarification, nil
}

// CanHandle implements the Agent interface
func (qv *QueryValidator) CanHandle(input interface{}) bool {
	switch input.(type) {
	case string, map[string]interface{}, base.AgentContext, *base.AgentContext:
		return true
	default:
		return false
	}
}
