package query_validator

// FuzzyPatterns defines common words/phrases that indicate ambiguous queries
var FuzzyPatterns = []string{
	"特定",
	"某个",
	"某些",
	"一些",
	"指定",
	"特别",
	"特殊",
	"具体",
	"哪些",
	"哪个",
	"什么",
	"几个",
	"任意",
	"random",
	"specific",
	"particular",
	"certain",
	"some",
	"any",
	"which",
	"what",
}

// FuzzyScenario represents a specific type of ambiguity in queries
type FuzzyScenario struct {
	Pattern     string
	Description string
	Example     string
}

// FuzzyScenarios defines common ambiguity patterns in queries
var FuzzyScenarios = []FuzzyScenario{
	{
		Pattern:     "特定|某个|具体",
		Description: "Query with ambiguous object qualifiers",
		Example:     "Find information about specific employees",
	},
	{
		Pattern:     "哪些|哪个|什么",
		Description: "Query with question words needing clarification",
		Example:     "Show which departments have more than 10 employees",
	},
	{
		Pattern:     "一些|某些|几个",
		Description: "Query with ambiguous quantity specifiers",
		Example:     "Display some products with high sales",
	},
}

// ClarificationTemplates provides response templates for different ambiguity scenarios
var ClarificationTemplates = map[string]string{
	"特定|某个|具体": "You mentioned '%s' but did not specify criteria. Which %s specifically? Can you provide filtering conditions?",
	"哪些|哪个|什么": "Your query includes '%s' which requires clarification. What criteria would you like to use to filter %s?",
	"一些|某些|几个": "You mentioned '%s' without specifying quantity or conditions. How many %s would you like, or based on what criteria?",
}
