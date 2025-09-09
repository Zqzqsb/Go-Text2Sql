package sql_generator

import (
	"context"
	"fmt"
	"regexp"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/prompts"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/base"
	"github.com/zqzqsb/gosql/internal/langchain/agents/schema_analyzer"
)

// SQLGenerationResult represents the output of SQL generation
type SQLGenerationResult struct {
	Query           string            // Original natural language query
	GeneratedSQL    string            // Generated SQL statement
	Explanation     string            // Explanation of the generated SQL
	RelevantTables  []string          // Tables used in the SQL
	RelevantColumns map[string]string // Columns used in the SQL (column -> table)
	DBType          string            // Database type (sqlite, postgres, etc.)
	Thinking        string            // Reasoning process
}

// SQLGenerator agent generates SQL based on natural language query and schema
type SQLGenerator struct {
	base.BaseAgent
	DefaultDBType  string // Default database type
	MaxResultLimit int    // Default result limit
}

// NewSQLGenerator creates a new SQL generator agent
func NewSQLGenerator(llmModel llms.Model) *SQLGenerator {
	return &SQLGenerator{
		BaseAgent: base.BaseAgent{
			Name:        "SQLGenerator",
			Description: "Generates SQL statements based on natural language queries and database schema",
			LLM:         llmModel,
		},
		DefaultDBType:  "sqlite", // Default to SQLite
		MaxResultLimit: 100,      // Default limit to 100 rows
	}
}

// Execute implements the Agent interface
func (sg *SQLGenerator) Execute(ctx context.Context, input interface{}) (base.AgentResult, error) {
	var query string
	var dbSchema *dbmodel.DatabaseSchema
	var schemaEnrichment *schema_analyzer.SchemaEnrichmentResult
	var dbType string = sg.DefaultDBType

	// Extract input parameters
	switch v := input.(type) {
	case base.AgentContext:
		query = v.OriginalQuery
		dbSchema = v.DBSchema
		dbType = v.DBType
	case *base.AgentContext:
		query = v.OriginalQuery
		dbSchema = v.DBSchema
		dbType = v.DBType
	case map[string]interface{}:
		// Try to extract query
		if queryVal, exists := v["query"]; exists {
			if q, ok := queryVal.(string); ok {
				query = q
			}
		}

		// Try to extract schema
		if schemaVal, exists := v["schema"]; exists {
			if schema, ok := schemaVal.(*dbmodel.DatabaseSchema); ok {
				dbSchema = schema
			}
		}

		// Try to extract schema enrichment
		if enrichVal, exists := v["schema_enrichment"]; exists {
			if enrich, ok := enrichVal.(*schema_analyzer.SchemaEnrichmentResult); ok {
				schemaEnrichment = enrich
			}
		}

		// Try to extract db type
		if typeVal, exists := v["db_type"]; exists {
			if t, ok := typeVal.(string); ok {
				dbType = t
			}
		}
	default:
		return base.AgentResult{
			Success: false,
			Error:   "input type not supported by SQLGenerator",
		}, nil
	}

	// Check required inputs
	if query == "" {
		return base.AgentResult{
			Success: false,
			Error:   "no query provided",
		}, nil
	}

	if dbSchema == nil {
		return base.AgentResult{
			Success: false,
			Error:   "database schema not provided",
		}, nil
	}

	// Format schema if enrichment not available
	var schemaStr string
	if schemaEnrichment != nil {
		schemaStr = schemaEnrichment.SchemaDescription
	} else {
		schemaStr = sg.formatSchema(dbSchema)
	}

	// Generate SQL
	result, err := sg.GenerateSQL(ctx, query, schemaStr, dbType)
	if err != nil {
		return base.AgentResult{
			Success: false,
			Error:   fmt.Sprintf("SQL generation error: %v", err),
		}, err
	}

	return base.AgentResult{
		Success: true,
		Data:    result,
		NextActions: []string{"FieldAlign"},
		Metadata: map[string]interface{}{
			"db_type":         dbType,
			"tables_used":     result.RelevantTables,
			"columns_used":    result.RelevantColumns,
			"has_explanation": result.Explanation != "",
		},
	}, nil
}

// GenerateSQL generates SQL for a natural language query
func (sg *SQLGenerator) GenerateSQL(ctx context.Context, query, schemaStr, dbType string) (SQLGenerationResult, error) {
	result := SQLGenerationResult{
		Query:          query,
		DBType:         dbType,
		RelevantTables: make([]string, 0),
		RelevantColumns: make(map[string]string),
	}

	// Build prompt
	template := `
You are a database expert that converts natural language queries into SQL.

DATABASE SCHEMA:
{{.schema}}

USER QUERY:
{{.query}}

DATABASE TYPE: {{.db_type}}

Think step by step to create the SQL statement:

1. Identify the tables and columns needed to answer this query
2. Determine the appropriate JOIN conditions if multiple tables are needed
3. Formulate WHERE clauses based on the filtering conditions
4. Organize results with appropriate ORDER BY, GROUP BY, or HAVING clauses if needed
5. Limit the results to a reasonable number (maximum {{.limit}} rows)

Follow these rules:
- Use only tables and columns that exist in the schema
- Use appropriate SQL syntax for {{.db_type}} database
- Always include table alias when referring to columns from multiple tables
- Use clear and efficient SQL patterns
- Ensure the SQL handles NULL values properly
- Include comments to explain complex parts of the query

<think>
Write your step-by-step thinking here.
</think>

The SQL query should be provided in this format:
-- Your SQL query here

EXPLANATION:
Provide a brief explanation of how the SQL works and why it answers the user's question.
`

	promptTemplate := prompts.NewPromptTemplate(template, []string{"schema", "query", "db_type", "limit"})

	prompt, err := promptTemplate.Format(map[string]interface{}{
		"schema":  schemaStr,
		"query":   query,
		"db_type": dbType,
		"limit":   sg.MaxResultLimit,
	})
	if err != nil {
		return result, fmt.Errorf("failed to format prompt: %v", err)
	}

	// Call LLM
	response, err := sg.LLM.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return result, fmt.Errorf("LLM call failed: %v", err)
	}

	// Extract SQL and explanation
	sql, thinking, explanation := extractSQLFromResponse(response)
	result.GeneratedSQL = sql
	result.Thinking = thinking
	result.Explanation = explanation

	// Extract relevant tables and columns from SQL
	relevantTables, relevantColumns := extractTableAndColumnReferences(sql)
	result.RelevantTables = relevantTables
	result.RelevantColumns = relevantColumns

	return result, nil
}

// formatSchema formats the database schema as a string for the prompt
func (sg *SQLGenerator) formatSchema(schema *dbmodel.DatabaseSchema) string {
	var sb strings.Builder

	// Output each table with its columns
	for _, table := range schema.Tables {
		sb.WriteString(fmt.Sprintf("Table: %s\n", table.Name))
		sb.WriteString("Columns:\n")

		for _, column := range table.Columns {
			// Format column information
			nullable := "NULL"
			// 主键通常不为空
			if column.IsPrimary {
				nullable = "NOT NULL"
			}

			// Add primary key marker
			pk := ""
			if column.IsPrimary {
				pk = "PRIMARY KEY"
			}

			// Add foreign key information
			fk := ""
			if column.IsForeign {
				fk = "REFERENCES other_table(id)"
			}

			// Combine all parts
			info := strings.TrimSpace(fmt.Sprintf("%s %s %s", nullable, pk, fk))
			if info != "" {
				info = " (" + info + ")"
			}

			sb.WriteString(fmt.Sprintf("  - %s: %s%s\n", 
				column.Name, 
				column.Type, 
				info))
		}
		sb.WriteString("\n")
	}

	return sb.String()
}

// extractSQLFromResponse extracts SQL and explanation from LLM response
func extractSQLFromResponse(response string) (string, string, string) {
	// Extract thinking
	thinking := ""
	thinkRegex := regexp.MustCompile(`<think>\s*([\s\S]*?)\s*</think>`)
	thinkMatches := thinkRegex.FindStringSubmatch(response)
	if len(thinkMatches) > 1 {
		thinking = strings.TrimSpace(thinkMatches[1])
	}

	// Extract SQL
	sql := ""
	sqlRegex := regexp.MustCompile("```sql\\s*([\\s\\S]*?)\\s*```")
	sqlMatches := sqlRegex.FindStringSubmatch(response)
	if len(sqlMatches) > 1 {
		sql = strings.TrimSpace(sqlMatches[1])
	} else {
		// Try alternative format without language specifier
		altRegex := regexp.MustCompile("```\\s*([\\s\\S]*?)\\s*```")
		altMatches := altRegex.FindStringSubmatch(response)
		if len(altMatches) > 1 {
			sql = strings.TrimSpace(altMatches[1])
		}
	}

	// Extract explanation (assuming it comes after the SQL)
	explanation := ""
	explRegex := regexp.MustCompile("(?i)EXPLANATION:\\s*(.[\\s\\S]*)")
	explMatches := explRegex.FindStringSubmatch(response)
	if len(explMatches) > 1 {
		explanation = strings.TrimSpace(explMatches[1])
	}

	return sql, thinking, explanation
}

// extractTableAndColumnReferences extracts table and column references from SQL
func extractTableAndColumnReferences(sql string) ([]string, map[string]string) {
	tables := make([]string, 0)
	columns := make(map[string]string) // column -> table

	// Simple regex-based extraction (a more robust approach would use SQL parsing)
	
	// Extract table references
	// Look for FROM and JOIN clauses
	fromRegex := regexp.MustCompile(`(?i)FROM\s+([a-zA-Z0-9_]+)`)
	joinRegex := regexp.MustCompile(`(?i)JOIN\s+([a-zA-Z0-9_]+)`)
	
	fromMatches := fromRegex.FindAllStringSubmatch(sql, -1)
	for _, match := range fromMatches {
		if len(match) > 1 {
			tableName := strings.TrimSpace(match[1])
			if tableName != "" && !contains(tables, tableName) {
				tables = append(tables, tableName)
			}
		}
	}
	
	joinMatches := joinRegex.FindAllStringSubmatch(sql, -1)
	for _, match := range joinMatches {
		if len(match) > 1 {
			tableName := strings.TrimSpace(match[1])
			if tableName != "" && !contains(tables, tableName) {
				tables = append(tables, tableName)
			}
		}
	}
	
	// Extract column references with table alias
	colRegex := regexp.MustCompile(`([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)`)
	colMatches := colRegex.FindAllStringSubmatch(sql, -1)
	
	for _, match := range colMatches {
		if len(match) > 2 {
			table := match[1]
			column := match[2]
			columns[column] = table
		}
	}

	return tables, columns
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
func (sg *SQLGenerator) CanHandle(input interface{}) bool {
	switch v := input.(type) {
	case base.AgentContext, *base.AgentContext:
		return true
	case map[string]interface{}:
		_, hasQuery := v["query"]
		_, hasSchema := v["schema"]
		return hasQuery && hasSchema
	default:
		return false
	}
}
