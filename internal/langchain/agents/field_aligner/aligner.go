package field_aligner

import (
	"context"
	"fmt"
	"regexp"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/prompts"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/base"
	"github.com/zqzqsb/gosql/internal/langchain/agents/sql_generator"
)

// FieldMapping represents a mapping between query field and database field
type FieldMapping struct {
	QueryField   string // Field mentioned in the natural language query
	DbTable      string // Database table
	DbField      string // Database field/column
	Confidence   float64 // Confidence score (0-1)
	IsAmbiguous  bool   // Whether the mapping is ambiguous
	Alternatives []string // Alternative mappings if ambiguous
}

// AlignmentResult represents the result of field alignment
type AlignmentResult struct {
	Mappings        []FieldMapping        // Field mappings
	ImprovedSQL     string                // SQL with improved field alignment
	OriginalSQL     string                // Original SQL
	UnmappedFields  []string              // Fields in query without DB mapping
	ValidationIssues []string             // Any issues found during validation
	IsFullyMapped   bool                  // Whether all fields are mapped
}

// FieldAligner agent ensures proper alignment between query fields and database fields
type FieldAligner struct {
	base.BaseAgent
}

// NewFieldAligner creates a new field aligner agent
func NewFieldAligner(llmModel llms.Model) *FieldAligner {
	return &FieldAligner{
		BaseAgent: base.BaseAgent{
			Name:        "FieldAligner",
			Description: "Ensures proper alignment between natural language query fields and database fields",
			LLM:         llmModel,
		},
	}
}

// Execute implements the Agent interface
func (fa *FieldAligner) Execute(ctx context.Context, input interface{}) (base.AgentResult, error) {
	var query string
	var sql string
	var dbSchema *dbmodel.DatabaseSchema
	// sqlGenResult声明在需要的地方

	// Extract input parameters
	switch v := input.(type) {
	case base.AgentContext:
		query = v.OriginalQuery
		sql = v.GeneratedSQL
		dbSchema = v.DBSchema
	case *base.AgentContext:
		query = v.OriginalQuery
		sql = v.GeneratedSQL
		dbSchema = v.DBSchema
	case map[string]interface{}:
		// Try to extract query
		if queryVal, exists := v["query"]; exists {
			if q, ok := queryVal.(string); ok {
				query = q
			}
		}

		// Try to extract SQL
		if sqlVal, exists := v["sql"]; exists {
			if s, ok := sqlVal.(string); ok {
				sql = s
			}
		}

		// Try to extract SQL generation result
		if resultVal, exists := v["sql_result"]; exists {
			if result, ok := resultVal.(*sql_generator.SQLGenerationResult); ok {
				query = result.Query
				sql = result.GeneratedSQL
			}
		}

		// Try to extract schema
		if schemaVal, exists := v["schema"]; exists {
			if schema, ok := schemaVal.(*dbmodel.DatabaseSchema); ok {
				dbSchema = schema
			}
		}
	default:
		return base.AgentResult{
			Success: false,
			Error:   "input type not supported by FieldAligner",
		}, nil
	}

	// Check required inputs
	if query == "" {
		return base.AgentResult{
			Success: false,
			Error:   "no query provided",
		}, nil
	}

	if sql == "" {
		return base.AgentResult{
			Success: false,
			Error:   "no SQL provided",
		}, nil
	}

	if dbSchema == nil {
		return base.AgentResult{
			Success: false,
			Error:   "database schema not provided",
		}, nil
	}

	// Perform field alignment
	result, err := fa.AlignFields(ctx, query, sql, dbSchema)
	if err != nil {
		return base.AgentResult{
			Success: false,
			Error:   fmt.Sprintf("field alignment error: %v", err),
		}, err
	}

	return base.AgentResult{
		Success: true,
		Data:    result,
		NextActions: []string{"BusinessInfo"},
		Metadata: map[string]interface{}{
			"fully_mapped": result.IsFullyMapped,
			"unmapped_count": len(result.UnmappedFields),
			"mapping_count": len(result.Mappings),
			"has_improved_sql": result.ImprovedSQL != result.OriginalSQL,
		},
	}, nil
}

// AlignFields aligns fields between natural language query and database schema
func (fa *FieldAligner) AlignFields(ctx context.Context, query, sql string, schema *dbmodel.DatabaseSchema) (AlignmentResult, error) {
	result := AlignmentResult{
		Mappings:        make([]FieldMapping, 0),
		OriginalSQL:     sql,
		ImprovedSQL:     sql, // Start with original, may be improved
		UnmappedFields:  make([]string, 0),
		ValidationIssues: make([]string, 0),
		IsFullyMapped:   true, // Assume all fields are mapped until proven otherwise
	}

	// Extract potential query fields
	queryFields := extractQueryFields(query)

	// No fields to align
	if len(queryFields) == 0 {
		return result, nil
	}

	// Extract SQL fields
	sqlFields := extractSQLFields(sql)

	// Format schema for prompt
	schemaStr := formatSchemaForPrompt(schema)

	// Use LLM to align fields
	mappings, err := fa.alignFieldsWithLLM(ctx, query, sql, schemaStr, queryFields, sqlFields)
	if err != nil {
		return result, err
	}

	// Process mappings
	for _, mapping := range mappings {
		result.Mappings = append(result.Mappings, mapping)
		
		// Track unmapped or ambiguous fields
		if mapping.DbField == "" {
			result.UnmappedFields = append(result.UnmappedFields, mapping.QueryField)
			result.IsFullyMapped = false
		} else if mapping.IsAmbiguous {
			// Field is mapped but ambiguously
			result.ValidationIssues = append(
				result.ValidationIssues, 
				fmt.Sprintf("Ambiguous mapping for '%s': mapped to %s.%s but could also be %s", 
					mapping.QueryField, mapping.DbTable, mapping.DbField,
					strings.Join(mapping.Alternatives, ", ")))
		}
	}

	// Try to improve SQL if needed
	if !result.IsFullyMapped || len(result.ValidationIssues) > 0 {
		improvedSQL, err := fa.improveSQLWithLLM(ctx, sql, schemaStr, result.Mappings)
		if err == nil && improvedSQL != "" {
			result.ImprovedSQL = improvedSQL
		}
	}

	return result, nil
}

// extractQueryFields extracts potential fields from the natural language query
func extractQueryFields(query string) []string {
	// This is a simplified implementation
	// A more robust implementation would use NLP techniques
	fields := make([]string, 0)
	
	// Split query into words
	words := strings.Fields(strings.ToLower(query))
	
	// Filter out common stopwords and keep potential fields
	stopwords := map[string]bool{
		"the": true, "a": true, "an": true, "in": true, "on": true, "at": true,
		"by": true, "for": true, "with": true, "about": true, "from": true,
		"to": true, "of": true, "show": true, "find": true, "list": true,
		"get": true, "select": true, "where": true, "how": true, "many": true,
		"much": true, "and": true, "or": true, "is": true, "are": true,
	}
	
	for _, word := range words {
		// Remove punctuation
		word = strings.Trim(word, ",.?!:;()")
		
		// Skip stopwords and short words
		if !stopwords[word] && len(word) > 2 {
			// Check if it's a multi-word phrase (e.g. "first name")
			if strings.Contains(word, "_") {
				fields = append(fields, word)
			} else {
				// Look for phrases in the original query
				phraseRegex := regexp.MustCompile(fmt.Sprintf(`\b%s\s+\w+\b|\b\w+\s+%s\b`, word, word))
				phrases := phraseRegex.FindAllString(query, -1)
				
				if len(phrases) > 0 {
					// Found a phrase
					for _, phrase := range phrases {
						// Clean and normalize phrase
						cleanPhrase := strings.ToLower(strings.Trim(phrase, ",.?!:;()"))
						if !contains(fields, cleanPhrase) {
							fields = append(fields, cleanPhrase)
						}
					}
				} else {
					// Single word
					if !contains(fields, word) {
						fields = append(fields, word)
					}
				}
			}
		}
	}
	
	return fields
}

// extractSQLFields extracts fields used in SQL
func extractSQLFields(sql string) map[string]string {
	fields := make(map[string]string) // column -> table
	
	// Match table.column or table.* patterns
	tableColRegex := regexp.MustCompile(`([a-zA-Z0-9_]+)\.([a-zA-Z0-9_*]+)`)
	matches := tableColRegex.FindAllStringSubmatch(sql, -1)
	
	for _, match := range matches {
		if len(match) > 2 {
			table := match[1]
			column := match[2]
			fields[column] = table
		}
	}
	
	// Match standalone column names in SELECT clause
	selectRegex := regexp.MustCompile(`(?i)SELECT\s+(.*?)\s+FROM`)
	selectMatches := selectRegex.FindStringSubmatch(sql)
	
	if len(selectMatches) > 1 {
		selectClause := selectMatches[1]
		
		// Handle case when SELECT has * 
		if selectClause == "*" {
			fields["*"] = ""
		} else {
			// Split by commas
			parts := strings.Split(selectClause, ",")
			
			for _, part := range parts {
				part = strings.TrimSpace(part)
				
				// Skip if it's a table.column (already handled above)
				if !strings.Contains(part, ".") {
					// Handle aliases (e.g. "column AS alias")
					aliasRegex := regexp.MustCompile(`([a-zA-Z0-9_]+)(\s+AS\s+|\s+)([a-zA-Z0-9_]+)`)
					aliasMatch := aliasRegex.FindStringSubmatch(part)
					
					if len(aliasMatch) > 3 {
						// It has an alias
						fields[aliasMatch[1]] = ""
					} else {
						// No alias
						fields[part] = ""
					}
				}
			}
		}
	}
	
	return fields
}

// alignFieldsWithLLM uses LLM to align fields between query and database
func (fa *FieldAligner) alignFieldsWithLLM(
	ctx context.Context,
	query string,
	sql string,
	schemaStr string,
	queryFields []string,
	sqlFields map[string]string,
) ([]FieldMapping, error) {
	// Define prompt template
	template := `
You are a database expert that aligns fields mentioned in natural language queries with their corresponding database fields.

DATABASE SCHEMA:
{{.schema}}

USER QUERY:
{{.query}}

GENERATED SQL:
{{.sql}}

POTENTIAL QUERY FIELDS:
{{range .query_fields}}
- {{.}}
{{end}}

FIELDS USED IN SQL:
{{range $column, $table := .sql_fields}}
{{if eq $table ""}}
- {{$column}}
{{else}}
- {{$table}}.{{$column}}
{{end}}
{{end}}

For each potential field in the query, determine the most likely database table and column it refers to.
If a field cannot be mapped confidently, mark it as unmapped.
If a field has multiple possible mappings, list the alternatives.

Return your analysis in the following format:

FIELD: [Query Field]
TABLE: [Database Table]
COLUMN: [Database Column]
CONFIDENCE: [High/Medium/Low]
AMBIGUOUS: [Yes/No]
ALTERNATIVES: [List if ambiguous, otherwise "None"]

Repeat this format for each query field.
`

	promptTemplate := prompts.NewPromptTemplate(template, []string{
		"schema", "query", "sql", "query_fields", "sql_fields",
	})

	prompt, err := promptTemplate.Format(map[string]interface{}{
		"schema":       schemaStr,
		"query":        query,
		"sql":          sql,
		"query_fields": queryFields,
		"sql_fields":   sqlFields,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to format prompt: %v", err)
	}

	// Call LLM
	response, err := fa.LLM.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return nil, fmt.Errorf("LLM call failed: %v", err)
	}

	// Parse response
	mappings, err := parseMappingsFromResponse(response)
	if err != nil {
		return nil, fmt.Errorf("failed to parse mappings: %v", err)
	}

	return mappings, nil
}

// improveSQLWithLLM tries to improve SQL based on field mappings
func (fa *FieldAligner) improveSQLWithLLM(
	ctx context.Context,
	sql string,
	schemaStr string,
	mappings []FieldMapping,
) (string, error) {
	// Only try to improve if we have actual mappings
	if len(mappings) == 0 {
		return sql, nil
	}
	
	// Define prompt template
	template := `
		You are a database expert that improves SQL queries based on field mappings.

		DATABASE SCHEMA:
		{{.schema}}

		ORIGINAL SQL:
		{{.sql}}

		FIELD MAPPINGS:
		{{range .mappings}}
		FIELD: {{.QueryField}}
		TABLE: {{.DbTable}}
		COLUMN: {{.DbField}}
		AMBIGUOUS: {{if .IsAmbiguous}}Yes{{else}}No{{end}}
		{{end}}

		Your task is to improve the SQL query based on these field mappings. Consider:
		1. Are all mapped fields correctly included in the SQL?
		2. Are column references clear and unambiguous?
		3. Could the query be rewritten to be more efficient or clear?

		If the SQL is already optimal, return it unchanged.
		If you can improve it, provide the improved SQL only.

		IMPROVED SQL:
		{{.sql}}
	`
	promptTemplate := prompts.NewPromptTemplate(template, []string{
		"schema", "sql", "mappings",
	})

	prompt, err := promptTemplate.Format(map[string]interface{}{
		"schema":   schemaStr,
		"sql":      sql,
		"mappings": mappings,
	})
	if err != nil {
		return sql, fmt.Errorf("failed to format prompt: %v", err)
	}

	// Call LLM
	response, err := fa.LLM.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return sql, fmt.Errorf("LLM call failed: %v", err)
	}

	// Extract SQL from response
	improved := extractSQLFromResponse(response)
	if improved == "" {
		return sql, nil // Return original if extraction failed
	}

	return improved, nil
}

// parseMappingsFromResponse parses field mappings from LLM response
func parseMappingsFromResponse(response string) ([]FieldMapping, error) {
	mappings := make([]FieldMapping, 0)
	
	// Split response by field sections
	fieldSections := strings.Split(response, "FIELD:")
	
	// Skip the first section (preamble)
	for i := 1; i < len(fieldSections); i++ {
		section := strings.TrimSpace(fieldSections[i])
		if section == "" {
			continue
		}
		
		// Parse individual mapping
		mapping := FieldMapping{
			Confidence:   0.5, // Default medium confidence
			Alternatives: make([]string, 0),
		}
		
		// Extract query field
		lines := strings.Split(section, "\n")
		if len(lines) > 0 {
			mapping.QueryField = strings.TrimSpace(lines[0])
		}
		
		// Extract other fields
		for _, line := range lines {
			line = strings.TrimSpace(line)
			
			if strings.HasPrefix(line, "TABLE:") {
				mapping.DbTable = strings.TrimSpace(strings.TrimPrefix(line, "TABLE:"))
			} else if strings.HasPrefix(line, "COLUMN:") {
				mapping.DbField = strings.TrimSpace(strings.TrimPrefix(line, "COLUMN:"))
			} else if strings.HasPrefix(line, "CONFIDENCE:") {
				confidenceStr := strings.TrimSpace(strings.TrimPrefix(line, "CONFIDENCE:"))
				switch strings.ToLower(confidenceStr) {
				case "high":
					mapping.Confidence = 0.9
				case "medium":
					mapping.Confidence = 0.6
				case "low":
					mapping.Confidence = 0.3
				}
			} else if strings.HasPrefix(line, "AMBIGUOUS:") {
				ambiguousStr := strings.TrimSpace(strings.TrimPrefix(line, "AMBIGUOUS:"))
				mapping.IsAmbiguous = strings.ToLower(ambiguousStr) == "yes"
			} else if strings.HasPrefix(line, "ALTERNATIVES:") {
				altsStr := strings.TrimSpace(strings.TrimPrefix(line, "ALTERNATIVES:"))
				if strings.ToLower(altsStr) != "none" {
					alts := strings.Split(altsStr, ",")
					for _, alt := range alts {
						if alt = strings.TrimSpace(alt); alt != "" {
							mapping.Alternatives = append(mapping.Alternatives, alt)
						}
					}
				}
			}
		}
		
		mappings = append(mappings, mapping)
	}
	
	return mappings, nil
}

// formatSchemaForPrompt formats database schema for prompt
func formatSchemaForPrompt(schema *dbmodel.DatabaseSchema) string {
	var sb strings.Builder
	
	for _, table := range schema.Tables {
		sb.WriteString(fmt.Sprintf("Table: %s\n", table.Name))
		sb.WriteString("Columns:\n")
		
		for _, column := range table.Columns {
			// Format basic info
			info := column.Type
			
			// Add PK/FK info
			if column.IsPrimary {
				info += " (Primary Key)"
			}
			if column.IsForeign {
				info += " (Foreign Key)"
			}
			
			sb.WriteString(fmt.Sprintf("  - %s: %s\n", column.Name, info))
		}
		
		sb.WriteString("\n")
	}
	
	return sb.String()
}

// extractSQLFromResponse extracts SQL from LLM response
func extractSQLFromResponse(response string) string {
	// Try to extract SQL between ```sql and ``` markers
	sqlRegex := regexp.MustCompile("(?s)```sql\\s*(.+?)\\s*```")
	matches := sqlRegex.FindStringSubmatch(response)
	
	if len(matches) > 1 {
		return strings.TrimSpace(matches[1])
	}
	
	// Try alternative format without language specifier
	altRegex := regexp.MustCompile("(?s)```\\s*(.+?)\\s*```")
	altMatches := altRegex.FindStringSubmatch(response)
	
	if len(altMatches) > 1 {
		return strings.TrimSpace(altMatches[1])
	}
	
	return ""
}

// contains checks if a string slice contains a specific value
func contains(slice []string, value string) bool {
	for _, item := range slice {
		if item == value {
			return true
		}
	}
	return false
}

// CanHandle implements the Agent interface
func (fa *FieldAligner) CanHandle(input interface{}) bool {
	switch v := input.(type) {
	case base.AgentContext, *base.AgentContext:
		// Accept context if it has query and SQL
		if ctx, ok := v.(*base.AgentContext); ok {
			return ctx.OriginalQuery != "" && ctx.GeneratedSQL != ""
		}
		if ctx, ok := v.(base.AgentContext); ok {
			return ctx.OriginalQuery != "" && ctx.GeneratedSQL != ""
		}
		return false
	case map[string]interface{}:
		// Check for required fields
		_, hasQuery := v["query"]
		_, hasSQL := v["sql"]
		_, hasSQLResult := v["sql_result"]
		return hasQuery && (hasSQL || hasSQLResult)
	default:
		return false
	}
}
