package adapters

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// ToolboxAdapter provides integration with genai-toolbox for database operations
type ToolboxAdapter struct {
	BaseURL     string        // Base URL of the genai-toolbox server
	Toolset     string        // Toolset name to use
	HTTPClient  *http.Client  // HTTP client for API calls
	DatabaseType string       // Actual database type behind toolbox
}

// ToolboxConfig contains configuration for genai-toolbox connection
type ToolboxConfig struct {
	BaseURL      string `json:"base_url"`      // genai-toolbox server URL
	Toolset      string `json:"toolset"`       // Toolset name
	DatabaseType string `json:"database_type"` // Actual database type
	Timeout      int    `json:"timeout"`       // Connection timeout in seconds
}

// NewToolboxAdapter creates a new adapter for genai-toolbox
func NewToolboxAdapter(config ToolboxConfig) *ToolboxAdapter {
	timeout := time.Duration(config.Timeout) * time.Second
	if timeout == 0 {
		timeout = 30 * time.Second // Default timeout
	}
	
	return &ToolboxAdapter{
		BaseURL:     config.BaseURL,
		Toolset:     config.Toolset,
		DatabaseType: config.DatabaseType,
		HTTPClient: &http.Client{
			Timeout: timeout,
		},
	}
}

// LoadSchema fetches schema information from genai-toolbox
func (t *ToolboxAdapter) LoadSchema(ctx context.Context) (*dbmodel.DatabaseSchema, error) {
	// Call list_tables tool to get table information
	response, err := t.invokeTool(ctx, "list_tables", map[string]interface{}{})
	if err != nil {
		return nil, fmt.Errorf("failed to load schema: %w", err)
	}
	
	// Parse schema from response
	schema := &dbmodel.DatabaseSchema{
		Tables:      []dbmodel.Table{},
		ForeignKeys: []dbmodel.ForeignKey{},
	}
	
	// Extract tables from response
	var responseObj map[string]interface{}
	if err := json.Unmarshal([]byte(response), &responseObj); err != nil {
		return nil, fmt.Errorf("failed to parse schema response: %w", err)
	}
	
	// Extract content array
	content, ok := responseObj["content"].([]interface{})
	if !ok {
		return nil, fmt.Errorf("invalid schema response format")
	}
	
	// Process each table
	for _, item := range content {
		tableInfo, ok := item.(map[string]interface{})
		if !ok {
			continue
		}
		
		tableName, _ := tableInfo["object_name"].(string)
		if tableName == "" {
			continue
		}
		
		// Create table
		table := dbmodel.Table{
			Name:    tableName,
			Columns: []dbmodel.Column{},
		}
		
		// Get detailed table info
		detailsResponse, err := t.invokeTool(ctx, "describe_table", map[string]interface{}{
			"table_name": tableName,
		})
		if err != nil {
			continue // Skip this table if describe fails
		}
		
		// Parse table details
		columns, err := t.parseTableColumns(detailsResponse)
		if err != nil {
			continue
		}
		
		table.Columns = columns
		schema.Tables = append(schema.Tables, table)
	}
	
	return schema, nil
}

// ExecuteSQL executes SQL through genai-toolbox
func (t *ToolboxAdapter) ExecuteSQL(ctx context.Context, query string) ([]map[string]interface{}, error) {
	// Call execute_sql tool
	response, err := t.invokeTool(ctx, "execute_sql", map[string]interface{}{
		"statement": query,
	})
	if err != nil {
		return nil, fmt.Errorf("SQL execution failed: %w", err)
	}
	
	// Parse results
	return t.parseQueryResults(response)
}

// invokeTool calls a specific tool in the genai-toolbox
func (t *ToolboxAdapter) invokeTool(ctx context.Context, toolName string, params map[string]interface{}) (string, error) {
	// Format URL
	url := fmt.Sprintf("%s/toolsets/%s/tools/%s/invoke", t.BaseURL, t.Toolset, toolName)
	
	// Marshal parameters
	paramsJSON, err := json.Marshal(params)
	if err != nil {
		return "", fmt.Errorf("failed to marshal parameters: %w", err)
	}
	
	// Create request with context
	req, err := http.NewRequestWithContext(ctx, "POST", url, bytes.NewBuffer(paramsJSON))
	if err != nil {
		return "", fmt.Errorf("failed to create request: %w", err)
	}
	
	// Set headers
	req.Header.Set("Content-Type", "application/json")
	
	// Execute request
	resp, err := t.HTTPClient.Do(req)
	if err != nil {
		return "", fmt.Errorf("HTTP request failed: %w", err)
	}
	defer resp.Body.Close()
	
	// Check status code
	if resp.StatusCode != http.StatusOK {
		// Read error message
		bodyBytes, _ := io.ReadAll(resp.Body)
		return "", fmt.Errorf("toolbox API error (status %d): %s", resp.StatusCode, string(bodyBytes))
	}
	
	// Read response
	bodyBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("failed to read response: %w", err)
	}
	
	return string(bodyBytes), nil
}

// parseTableColumns extracts column information from table details response
func (t *ToolboxAdapter) parseTableColumns(detailsResponse string) ([]dbmodel.Column, error) {
	columns := []dbmodel.Column{}
	
	// Parse response
	var responseObj map[string]interface{}
	if err := json.Unmarshal([]byte(detailsResponse), &responseObj); err != nil {
		return nil, fmt.Errorf("failed to parse table details: %w", err)
	}
	
	// Extract content
	content, ok := responseObj["content"].([]interface{})
	if !ok {
		return nil, fmt.Errorf("invalid table details format")
	}
	
	// Process column information
	for _, item := range content {
		colInfo, ok := item.(map[string]interface{})
		if !ok {
			continue
		}
		
		// Extract column details
		colName, _ := colInfo["column_name"].(string)
		dataType, _ := colInfo["data_type"].(string)
		_, _ = colInfo["is_not_nullable"].(bool) // Not used but keeping for clarity
		isPrimary, _ := colInfo["is_primary_key"].(bool)
		
		// Create column
		column := dbmodel.Column{
			Name:      colName,
			Type:      dataType,
			IsPrimary: isPrimary,
			IsForeign: false,
		}
		
		// Check for foreign key
		if isForeignKey, ok := colInfo["is_foreign_key"].(bool); ok && isForeignKey {
			refTable, _ := colInfo["referenced_table"].(string)
			refColumn, _ := colInfo["referenced_column"].(string)
			
			if refTable != "" && refColumn != "" {
				// Set foreign key flag
				column.IsForeign = true
				
				// We'll store this information to create foreign key later
				// since we don't have access to schema or tableName here
			}
		}
		
		columns = append(columns, column)
	}
	
	return columns, nil
}

// parseQueryResults converts toolbox query result to standard format
func (t *ToolboxAdapter) parseQueryResults(response string) ([]map[string]interface{}, error) {
	// Parse response
	var responseObj map[string]interface{}
	if err := json.Unmarshal([]byte(response), &responseObj); err != nil {
		return nil, fmt.Errorf("failed to parse query results: %w", err)
	}
	
	// Extract content array
	content, ok := responseObj["content"].([]interface{})
	if !ok {
		return nil, fmt.Errorf("invalid query results format")
	}
	
	// Convert to standard result format
	results := make([]map[string]interface{}, 0, len(content))
	
	for _, item := range content {
		row, ok := item.(map[string]interface{})
		if !ok {
			continue
		}
		
		results = append(results, row)
	}
	
	return results, nil
}

// GetDatabaseType returns the actual database type
func (t *ToolboxAdapter) GetDatabaseType() string {
	return t.DatabaseType
}
