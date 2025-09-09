package graph

import (
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/business_info"
	"github.com/zqzqsb/gosql/internal/langchain/agents/field_aligner"
	"github.com/zqzqsb/gosql/internal/langchain/agents/query_validator"
	"github.com/zqzqsb/gosql/internal/langchain/agents/schema_analyzer"
	"github.com/zqzqsb/gosql/internal/langchain/agents/sql_generator"
)

// GraphState represents the shared state for the Text2SQL task graph
type GraphState struct {
	// Input
	Query       string               // Original natural language query
	DBSchema    *dbmodel.DatabaseSchema // Database schema
	DBName      string               // Database name
	DBType      string               // Database type (sqlite, postgres, etc.)
	FieldsInfo  map[string]string    // Field information/descriptions

	// Validation stage
	IsAmbiguous      bool                               // Whether the query is ambiguous
	ValidationResult *query_validator.QueryValidationResult // Result from query validation
	ClarifiedQuery   string                             // Clarified query after user interaction

	// Schema analysis stage
	SchemaAnalysis *schema_analyzer.SchemaEnrichmentResult // Result from schema analysis

	// SQL generation stage
	GeneratedSQL    string                          // Generated SQL statement
	SQLGenResult    *sql_generator.SQLGenerationResult // Full result from SQL generation
	Explanation     string                          // SQL explanation

	// Field alignment stage
	FieldMappings   []field_aligner.FieldMapping   // Field mappings
	AlignmentResult *field_aligner.AlignmentResult // Result from field alignment
	ImprovedSQL     string                         // Improved SQL after alignment

	// Business context stage
	BusinessContext *business_info.BusinessContext // Business context information

	// Execution
	ExecutionResults interface{} // Results from SQL execution

	// Error tracking
	Errors map[string]string // Errors from each stage
}

// NewGraphState creates a new graph state with initial values
func NewGraphState(query, dbName, dbType string, dbSchema *dbmodel.DatabaseSchema) *GraphState {
	return &GraphState{
		Query:      query,
		DBName:     dbName,
		DBType:     dbType,
		DBSchema:   dbSchema,
		FieldsInfo: make(map[string]string),
		Errors:     make(map[string]string),
	}
}

// WithFieldsInfo adds field information to the graph state
func (s *GraphState) WithFieldsInfo(fieldsInfo map[string]string) *GraphState {
	s.FieldsInfo = fieldsInfo
	return s
}

// SetValidationResult sets the result from query validation
func (s *GraphState) SetValidationResult(result *query_validator.QueryValidationResult) {
	s.ValidationResult = result
	if result != nil {
		s.IsAmbiguous = result.IsAmbiguous
	}
}

// SetClarifiedQuery sets the clarified query after user interaction
func (s *GraphState) SetClarifiedQuery(clarified string) {
	s.ClarifiedQuery = clarified
}

// GetEffectiveQuery returns the clarified query if available, otherwise the original
func (s *GraphState) GetEffectiveQuery() string {
	if s.ClarifiedQuery != "" {
		return s.ClarifiedQuery
	}
	return s.Query
}

// SetSchemaAnalysis sets the result from schema analysis
func (s *GraphState) SetSchemaAnalysis(analysis *schema_analyzer.SchemaEnrichmentResult) {
	s.SchemaAnalysis = analysis
}

// SetSQLGenerationResult sets the result from SQL generation
func (s *GraphState) SetSQLGenerationResult(result *sql_generator.SQLGenerationResult) {
	s.SQLGenResult = result
	if result != nil {
		s.GeneratedSQL = result.GeneratedSQL
		s.Explanation = result.Explanation
	}
}

// SetAlignmentResult sets the result from field alignment
func (s *GraphState) SetAlignmentResult(result *field_aligner.AlignmentResult) {
	s.AlignmentResult = result
	if result != nil {
		s.FieldMappings = result.Mappings
		if result.ImprovedSQL != "" {
			s.ImprovedSQL = result.ImprovedSQL
		}
	}
}

// GetFinalSQL returns the final SQL to use (improved if available, otherwise generated)
func (s *GraphState) GetFinalSQL() string {
	if s.ImprovedSQL != "" {
		return s.ImprovedSQL
	}
	return s.GeneratedSQL
}

// SetBusinessContext sets the business context information
func (s *GraphState) SetBusinessContext(context *business_info.BusinessContext) {
	s.BusinessContext = context
}

// SetExecutionResults sets the SQL execution results
func (s *GraphState) SetExecutionResults(results interface{}) {
	s.ExecutionResults = results
}

// AddError records an error for a specific stage
func (s *GraphState) AddError(stage, errorMsg string) {
	s.Errors[stage] = errorMsg
}

// HasError checks if any errors have been recorded
func (s *GraphState) HasError() bool {
	return len(s.Errors) > 0
}

// GetErrors returns all recorded errors
func (s *GraphState) GetErrors() map[string]string {
	return s.Errors
}

// NeedsUserClarification determines if the query needs user clarification
func (s *GraphState) NeedsUserClarification() bool {
	return s.IsAmbiguous
}

// HasSufficientContext checks if we have sufficient context to proceed
func (s *GraphState) HasSufficientContext() bool {
	return s.Query != "" && s.DBSchema != nil
}
