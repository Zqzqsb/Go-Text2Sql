package schema_analyzer

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/prompts"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/base"
)

// SchemaEnrichmentResult contains enriched schema information
type SchemaEnrichmentResult struct {
	// Original schema
	OriginalSchema *dbmodel.DatabaseSchema
	// Enriched tables with descriptions
	Tables map[string]TableEnrichment
	// Simplified schema format for LLM consumption
	SchemaDescription string
}

// TableEnrichment contains enriched table information
type TableEnrichment struct {
	Name        string
	Description string
	Columns     map[string]ColumnEnrichment
}

// ColumnEnrichment contains enriched column information
type ColumnEnrichment struct {
	Name          string
	DataType      string
	Description   string
	IsPrimaryKey  bool
	IsForeignKey  bool
	ReferencedCol string
}

// SchemaAnalyzer agent analyzes database schema and provides semantic information
type SchemaAnalyzer struct {
	base.BaseAgent
}

// NewSchemaAnalyzer creates a new schema analyzer agent
func NewSchemaAnalyzer(llmModel llms.Model) *SchemaAnalyzer {
	return &SchemaAnalyzer{
		BaseAgent: base.BaseAgent{
			Name:        "SchemaAnalyzer",
			Description: "Analyzes database schema and provides semantic information about tables and fields",
			LLM:         llmModel,
		},
	}
}

// Execute implements the Agent interface
func (sa *SchemaAnalyzer) Execute(ctx context.Context, input interface{}) (base.AgentResult, error) {
	// Check if input is valid
	var dbSchema *dbmodel.DatabaseSchema
	var query string

	switch v := input.(type) {
	case *dbmodel.DatabaseSchema:
		dbSchema = v
	case base.AgentContext:
		dbSchema = v.DBSchema
		query = v.OriginalQuery
	case *base.AgentContext:
		dbSchema = v.DBSchema
		query = v.OriginalQuery
	case map[string]interface{}:
		// Try to extract schema from the map
		if schemaVal, exists := v["schema"]; exists {
			if schema, ok := schemaVal.(*dbmodel.DatabaseSchema); ok {
				dbSchema = schema
			}
		}
		// Try to extract query from the map
		if queryVal, exists := v["query"]; exists {
			if q, ok := queryVal.(string); ok {
				query = q
			}
		}
	default:
		return base.AgentResult{
			Success: false,
			Error:   "input type not supported by SchemaAnalyzer",
		}, nil
	}

	// Check if schema is available
	if dbSchema == nil {
		return base.AgentResult{
			Success: false,
			Error:   "database schema not provided",
		}, nil
	}

	// Analyze schema
	result, err := sa.AnalyzeSchema(ctx, dbSchema, query)
	if err != nil {
		return base.AgentResult{
			Success: false,
			Error:   fmt.Sprintf("schema analysis error: %v", err),
		}, err
	}

	return base.AgentResult{
		Success: true,
		Data:    result,
		NextActions: []string{"SQLGenerate"},
		Metadata: map[string]interface{}{
			"table_count":    len(result.Tables),
			"schema_quality": "high", // placeholder for actual quality assessment
		},
	}, nil
}

// AnalyzeSchema enriches the database schema with semantic information
func (sa *SchemaAnalyzer) AnalyzeSchema(ctx context.Context, schema *dbmodel.DatabaseSchema, query string) (SchemaEnrichmentResult, error) {
	result := SchemaEnrichmentResult{
		OriginalSchema: schema,
		Tables:         make(map[string]TableEnrichment),
	}

	// First, format the schema into a readable structure for the LLM
	formattedSchema := sa.formatSchemaForLLM(schema)
	result.SchemaDescription = formattedSchema

	// If no query or LLM provided, just return the formatted schema
	if sa.LLM == nil || query == "" {
		// Basic enrichment without LLM
		for _, table := range schema.Tables {
			tableName := table.Name
			tableEnrich := TableEnrichment{
				Name:        tableName,
				Description: "", // No LLM-generated description
				Columns:     make(map[string]ColumnEnrichment),
			}
			
			for _, col := range table.Columns {
				tableEnrich.Columns[col.Name] = ColumnEnrichment{
					Name:         col.Name,
					DataType:     col.Type,
					Description:  "", // No LLM-generated description
					IsPrimaryKey: col.IsPrimary,
					IsForeignKey: col.IsForeign,
				}
			}
			
			result.Tables[tableName] = tableEnrich
		}
		
		return result, nil
	}

	// Use LLM to enrich schema with semantic information
	enrichedSchema, err := sa.enrichSchemaWithLLM(ctx, schema, formattedSchema, query)
	if err != nil {
		return result, err
	}
	
	// Merge LLM enrichments into result
	for tableName, tableEnrich := range enrichedSchema {
		result.Tables[tableName] = tableEnrich
	}

	return result, nil
}

// formatSchemaForLLM converts database schema to a string format for LLM
func (sa *SchemaAnalyzer) formatSchemaForLLM(schema *dbmodel.DatabaseSchema) string {
	var sb strings.Builder

	sb.WriteString("Database Schema:\n\n")
	
	// Process each table
	for _, table := range schema.Tables {
		sb.WriteString(fmt.Sprintf("Table: %s\n", table.Name))
		
		// Process columns
		sb.WriteString("Columns:\n")
		for _, column := range table.Columns {
			nullable := ""
			if column.IsPrimary { // Primary keys are usually not null
				nullable = " NOT NULL"
			}
			
			// Mark primary key
			pk := ""
			if column.IsPrimary {
				pk = " PRIMARY KEY"
			}
			
			// Mark foreign key
			fk := ""
			if column.IsForeign {
				// We don't have detailed foreign key info in this model
				fk = " REFERENCES other_table(other_column)"
			}
			
			sb.WriteString(fmt.Sprintf("  - %s: %s%s%s%s\n", 
				column.Name, column.Type, nullable, pk, fk))
		}
		sb.WriteString("\n")
	}

	return sb.String()
}

// enrichSchemaWithLLM uses LLM to add semantic descriptions to tables and columns
func (sa *SchemaAnalyzer) enrichSchemaWithLLM(
	ctx context.Context, 
	schema *dbmodel.DatabaseSchema, 
	formattedSchema string, 
	query string,
) (map[string]TableEnrichment, error) {
	// Define prompt template
	template := `
As a database expert, analyze this database schema and provide semantic descriptions for tables and columns that might be relevant to the user's query.

DATABASE SCHEMA:
{{.schema}}

USER QUERY:
{{.query}}

Provide table and column descriptions in the following JSON format:
{
  "tables": {
    "table_name": {
      "description": "Table description",
      "columns": {
        "column_name": {
          "description": "Column description",
          "importance": "high|medium|low"
        },
        ...
      }
    },
    ...
  }
}

Focus on tables and columns that appear most relevant to the user's query.
`

	promptTemplate := prompts.NewPromptTemplate(template, []string{"schema", "query"})

	prompt, err := promptTemplate.Format(map[string]interface{}{
		"schema": formattedSchema,
		"query":  query,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to format prompt: %v", err)
	}

	// Call LLM
	response, err := sa.LLM.Call(ctx, prompt, llms.WithTemperature(0.2))
	if err != nil {
		return nil, fmt.Errorf("LLM call failed: %v", err)
	}

	// Extract JSON from response
	jsonStr := extractJSON(response)
	if jsonStr == "" {
		return nil, fmt.Errorf("failed to extract JSON from LLM response")
	}

	// Parse LLM response
	enrichment, err := parseLLMSchemaEnrichment(jsonStr, schema)
	if err != nil {
		return nil, fmt.Errorf("failed to parse LLM enrichment: %v", err)
	}

	return enrichment, nil
}

// extractJSON extracts JSON content from LLM response
func extractJSON(text string) string {
	// Find JSON content between curly braces
	startIdx := strings.Index(text, "{")
	if startIdx == -1 {
		return ""
	}
	
	// Find matching closing brace (accounting for nested braces)
	depth := 1
	for i := startIdx + 1; i < len(text); i++ {
		if text[i] == '{' {
			depth++
		} else if text[i] == '}' {
			depth--
			if depth == 0 {
				return text[startIdx : i+1]
			}
		}
	}
	
	return ""
}

// parseLLMSchemaEnrichment parses the LLM response into TableEnrichment structures
func parseLLMSchemaEnrichment(jsonStr string, schema *dbmodel.DatabaseSchema) (map[string]TableEnrichment, error) {
	// Define JSON structure for parsing
	var llmResponse struct {
		Tables map[string]struct {
			Description string `json:"description"`
			Columns     map[string]struct {
				Description string `json:"description"`
				Importance  string `json:"importance"`
			} `json:"columns"`
		} `json:"tables"`
	}

	// Parse JSON
	if err := json.Unmarshal([]byte(jsonStr), &llmResponse); err != nil {
		return nil, fmt.Errorf("JSON parsing error: %v", err)
	}

	// Convert to TableEnrichment
	result := make(map[string]TableEnrichment)
	
	for tableName, tableData := range llmResponse.Tables {
		// 查找表格
		tableFound := false
		var foundTable dbmodel.Table
		
		for _, table := range schema.Tables {
			if table.Name == tableName {
				tableFound = true
				foundTable = table
				break
			}
		}
		
		if !tableFound {
			continue // 跳过不在原始架构中的表
		}
		
		tableEnrich := TableEnrichment{
			Name:        tableName,
			Description: tableData.Description,
			Columns:     make(map[string]ColumnEnrichment),
		}
		
		// 处理列
		for _, col := range foundTable.Columns {
			columnEnrich := ColumnEnrichment{
				Name:         col.Name,
				DataType:     col.Type,
				IsPrimaryKey: col.IsPrimary,
				IsForeignKey: col.IsForeign,
			}
			
			// 我们没有详细的外键信息，所以简化处理
			if col.IsForeign {
				columnEnrich.ReferencedCol = "referenced_table.column"
			}
			
			// Add LLM-generated description if available
			if llmColData, exists := tableData.Columns[col.Name]; exists {
				columnEnrich.Description = llmColData.Description
			}
			
			tableEnrich.Columns[col.Name] = columnEnrich
		}
		
		result[tableName] = tableEnrich
	}

	return result, nil
}

// getSortedTableNames returns a sorted list of table names
func getSortedTableNames(tables []dbmodel.Table) []string {
	tableNames := make([]string, 0, len(tables))
	for _, table := range tables {
		tableNames = append(tableNames, table.Name)
	}
	// Simple alphabetical sort
	// In a real implementation, you might sort based on relationships
	// to put referenced tables first
	// sort.Strings(tableNames)
	return tableNames
}

// CanHandle implements the Agent interface
func (sa *SchemaAnalyzer) CanHandle(input interface{}) bool {
	switch input.(type) {
	case *dbmodel.DatabaseSchema, base.AgentContext, *base.AgentContext:
		return true
	case map[string]interface{}:
		v := input.(map[string]interface{})
		_, hasSchema := v["schema"]
		return hasSchema
	default:
		return false
	}
}
