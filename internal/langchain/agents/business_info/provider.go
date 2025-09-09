package business_info

import (
	"context"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/prompts"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/base"
)

// BusinessContext represents business context information
type BusinessContext struct {
	// General information about the database domain
	DomainDescription string
	// Table-specific business rules and context
	TableRules map[string]string
	// Important business metrics and KPIs
	KeyMetrics map[string]string
	// Common query patterns for this database
	CommonPatterns []string
	// Any data quality issues or constraints
	DataConstraints []string
}

// BusinessInfoProvider agent provides business context to enhance SQL generation
type BusinessInfoProvider struct {
	base.BaseAgent
	// Built-in knowledge base for common business domains
	DomainKnowledge map[string]BusinessContext
}

// NewBusinessInfoProvider creates a new business info provider agent
func NewBusinessInfoProvider(llmModel llms.Model) *BusinessInfoProvider {
	provider := &BusinessInfoProvider{
		BaseAgent: base.BaseAgent{
			Name:        "BusinessInfoProvider",
			Description: "Provides business context to enhance SQL generation",
			LLM:         llmModel,
		},
		DomainKnowledge: make(map[string]BusinessContext),
	}
	
	// Initialize with some built-in domain knowledge
	provider.initializeKnowledge()
	
	return provider
}

// Execute implements the Agent interface
func (bp *BusinessInfoProvider) Execute(ctx context.Context, input interface{}) (base.AgentResult, error) {
	var query string
	var dbSchema *dbmodel.DatabaseSchema
	var dbName string
	
	// Extract input parameters
	switch v := input.(type) {
	case base.AgentContext:
		query = v.OriginalQuery
		dbSchema = v.DBSchema
		dbName = v.DBName
	case *base.AgentContext:
		query = v.OriginalQuery
		dbSchema = v.DBSchema
		dbName = v.DBName
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
		
		// Try to extract db name
		if nameVal, exists := v["db_name"]; exists {
			if name, ok := nameVal.(string); ok {
				dbName = name
			}
		}
	default:
		return base.AgentResult{
			Success: false,
			Error:   "input type not supported by BusinessInfoProvider",
		}, nil
	}
	
	// Need at least one of these for meaningful operation
	if query == "" && dbSchema == nil && dbName == "" {
		return base.AgentResult{
			Success: false,
			Error:   "insufficient context information provided",
		}, nil
	}
	
	// Generate business context
	businessContext, err := bp.GenerateBusinessContext(ctx, query, dbSchema, dbName)
	if err != nil {
		return base.AgentResult{
			Success: false,
			Error:   fmt.Sprintf("business context generation error: %v", err),
		}, err
	}
	
	return base.AgentResult{
		Success: true,
		Data:    businessContext,
		NextActions: []string{}, // Final agent in chain
		Metadata: map[string]interface{}{
			"has_domain_info":  businessContext.DomainDescription != "",
			"table_rules":      len(businessContext.TableRules),
			"metrics":          len(businessContext.KeyMetrics),
			"query_patterns":   len(businessContext.CommonPatterns),
			"data_constraints": len(businessContext.DataConstraints),
		},
	}, nil
}

// GenerateBusinessContext creates business context for a query and schema
func (bp *BusinessInfoProvider) GenerateBusinessContext(
	ctx context.Context,
	query string,
	schema *dbmodel.DatabaseSchema,
	dbName string,
) (BusinessContext, error) {
	// Initialize result
	result := BusinessContext{
		TableRules:     make(map[string]string),
		KeyMetrics:     make(map[string]string),
		CommonPatterns: make([]string, 0),
		DataConstraints: make([]string, 0),
	}
	
	// First, check if we have built-in knowledge for this database domain
	domainType := detectDomainType(schema, dbName)
	if existingContext, exists := bp.DomainKnowledge[domainType]; exists {
		// Start with existing knowledge and enhance it
		result = existingContext
	}
	
	// If LLM is not available, return what we have from built-in knowledge
	if bp.LLM == nil {
		return result, nil
	}
	
	// Format schema for prompt if available
	var schemaStr string
	if schema != nil {
		schemaStr = formatSchemaForPrompt(schema)
	}
	
	// Use LLM to generate context
	enhancedContext, err := bp.generateContextWithLLM(ctx, query, schemaStr, domainType)
	if err != nil {
		// Return what we have even if LLM generation fails
		return result, fmt.Errorf("LLM context generation failed: %v", err)
	}
	
	// Merge LLM-generated context with existing
	if enhancedContext.DomainDescription != "" {
		result.DomainDescription = enhancedContext.DomainDescription
	}
	
	// Merge table rules
	for table, rule := range enhancedContext.TableRules {
		result.TableRules[table] = rule
	}
	
	// Merge metrics
	for metric, desc := range enhancedContext.KeyMetrics {
		result.KeyMetrics[metric] = desc
	}
	
	// Add patterns and constraints
	if len(enhancedContext.CommonPatterns) > 0 {
		result.CommonPatterns = append(result.CommonPatterns, enhancedContext.CommonPatterns...)
	}
	
	if len(enhancedContext.DataConstraints) > 0 {
		result.DataConstraints = append(result.DataConstraints, enhancedContext.DataConstraints...)
	}
	
	return result, nil
}

// generateContextWithLLM uses LLM to generate business context
func (bp *BusinessInfoProvider) generateContextWithLLM(
	ctx context.Context,
	query string,
	schemaStr string,
	domainType string,
) (BusinessContext, error) {
	result := BusinessContext{
		TableRules:      make(map[string]string),
		KeyMetrics:      make(map[string]string),
		CommonPatterns:  make([]string, 0),
		DataConstraints: make([]string, 0),
	}
	
	// Define prompt template
	template := `
You are a business domain expert who provides context to help with database queries.

{{if .schema}}
DATABASE SCHEMA:
{{.schema}}
{{end}}

{{if .query}}
USER QUERY:
{{.query}}
{{end}}

DETECTED DOMAIN: {{.domain}}

Based on the {{if .schema}}database schema{{else}}database name{{end}}{{if and .schema .query}} and the user's query{{else if .query}} in the user's query{{end}}, provide relevant business context that would help generate better SQL.

Please include:

1. A brief description of this business domain
2. Important business rules for relevant tables
3. Key business metrics or KPIs commonly used in this domain
4. Common query patterns for this type of database
5. Any data quality issues, constraints, or special handling required

Your response should be concise and directly useful for improving SQL generation. Focus on concrete domain-specific knowledge rather than generic database information.
`

	// Create prompt template with variables
	promptTemplate := prompts.NewPromptTemplate(template, []string{"schema", "query", "domain"})

	prompt, err := promptTemplate.Format(map[string]interface{}{
		"schema": schemaStr,
		"query":  query,
		"domain": domainType,
	})
	if err != nil {
		return result, fmt.Errorf("failed to format prompt: %v", err)
	}

	// Call LLM
	response, err := bp.LLM.Call(ctx, prompt, llms.WithTemperature(0.3))
	if err != nil {
		return result, fmt.Errorf("LLM call failed: %v", err)
	}

	// Parse response
	return parseBusinessContext(response, domainType)
}

// parseBusinessContext extracts structured business context from LLM response
func parseBusinessContext(response string, domainType string) (BusinessContext, error) {
	result := BusinessContext{
		TableRules:      make(map[string]string),
		KeyMetrics:      make(map[string]string),
		CommonPatterns:  make([]string, 0),
		DataConstraints: make([]string, 0),
	}
	
	// Set domain type
	if domainType != "" {
		result.DomainDescription = fmt.Sprintf("Domain: %s", domainType)
	}
	
	// Split response by sections
	sections := strings.Split(response, "\n")
	
	currentSection := ""
	var currentContent []string
	
	// Process the response line by line
	for _, line := range sections {
		trimmedLine := strings.TrimSpace(line)
		
		// Skip empty lines
		if trimmedLine == "" {
			continue
		}
		
		// Detect section headers
		if strings.HasSuffix(trimmedLine, ":") || 
		   strings.HasPrefix(trimmedLine, "#") ||
		   (len(trimmedLine) <= 50 && (strings.Contains(trimmedLine, "business domain") || 
									  strings.Contains(trimmedLine, "business rule") ||
									  strings.Contains(trimmedLine, "metrics") ||
									  strings.Contains(trimmedLine, "KPI") ||
									  strings.Contains(trimmedLine, "query pattern") ||
									  strings.Contains(trimmedLine, "constraint"))) {
			
			// Save previous section content if any
			if currentSection != "" && len(currentContent) > 0 {
				content := strings.Join(currentContent, " ")
				
				switch currentSection {
				case "domain":
					result.DomainDescription = content
				case "rules":
					// Try to extract table-specific rules
					parts := strings.Split(content, ":")
					if len(parts) > 1 {
						table := strings.TrimSpace(parts[0])
						rule := strings.TrimSpace(strings.Join(parts[1:], ":"))
						result.TableRules[table] = rule
					}
				case "metrics":
					// Try to extract named metrics
					parts := strings.Split(content, ":")
					if len(parts) > 1 {
						metric := strings.TrimSpace(parts[0])
						desc := strings.TrimSpace(strings.Join(parts[1:], ":"))
						result.KeyMetrics[metric] = desc
					} else {
						// Add as unnamed metric
						result.CommonPatterns = append(result.CommonPatterns, content)
					}
				case "patterns":
					result.CommonPatterns = append(result.CommonPatterns, content)
				case "constraints":
					result.DataConstraints = append(result.DataConstraints, content)
				}
				
				currentContent = nil
			}
			
			// Determine new section
			lower := strings.ToLower(trimmedLine)
			switch {
			case strings.Contains(lower, "business domain") || strings.Contains(lower, "description"):
				currentSection = "domain"
			case strings.Contains(lower, "business rule"):
				currentSection = "rules"
			case strings.Contains(lower, "metric") || strings.Contains(lower, "kpi"):
				currentSection = "metrics"
			case strings.Contains(lower, "query pattern"):
				currentSection = "patterns"
			case strings.Contains(lower, "constraint") || strings.Contains(lower, "quality"):
				currentSection = "constraints"
			default:
				// If unclear, continue with previous section
			}
			
			// Skip the header line itself
			continue
		}
		
		// Add content line
		currentContent = append(currentContent, trimmedLine)
	}
	
	// Process the last section
	if currentSection != "" && len(currentContent) > 0 {
		content := strings.Join(currentContent, " ")
		
		switch currentSection {
		case "domain":
			result.DomainDescription = content
		case "rules":
			// Try to extract table-specific rules
			parts := strings.Split(content, ":")
			if len(parts) > 1 {
				table := strings.TrimSpace(parts[0])
				rule := strings.TrimSpace(strings.Join(parts[1:], ":"))
				result.TableRules[table] = rule
			}
		case "metrics":
			// Try to extract named metrics
			parts := strings.Split(content, ":")
			if len(parts) > 1 {
				metric := strings.TrimSpace(parts[0])
				desc := strings.TrimSpace(strings.Join(parts[1:], ":"))
				result.KeyMetrics[metric] = desc
			}
		case "patterns":
			result.CommonPatterns = append(result.CommonPatterns, content)
		case "constraints":
			result.DataConstraints = append(result.DataConstraints, content)
		}
	}
	
	// If we couldn't parse a domain description, use the first few sentences of the response
	if result.DomainDescription == "" {
		firstParagraph := extractFirstParagraph(response)
		if firstParagraph != "" {
			result.DomainDescription = firstParagraph
		}
	}
	
	return result, nil
}

// extractFirstParagraph gets the first paragraph from text
func extractFirstParagraph(text string) string {
	// Split by double newline (paragraph separator)
	paragraphs := strings.Split(text, "\n\n")
	
	for _, p := range paragraphs {
		trimmed := strings.TrimSpace(p)
		if trimmed != "" {
			// Limit to a reasonable length
			if len(trimmed) > 200 {
				return trimmed[:200] + "..."
			}
			return trimmed
		}
	}
	
	return ""
}

// formatSchemaForPrompt creates a simplified schema representation for prompts
func formatSchemaForPrompt(schema *dbmodel.DatabaseSchema) string {
	var sb strings.Builder
	
	// Show tables and columns, simplified
	for _, table := range schema.Tables {
		sb.WriteString(fmt.Sprintf("Table: %s\n", table.Name))
		sb.WriteString("Columns: ")
		
		columnNames := make([]string, 0, len(table.Columns))
		for _, col := range table.Columns {
			columnNames = append(columnNames, col.Name)
		}
		
		sb.WriteString(strings.Join(columnNames, ", "))
		sb.WriteString("\n\n")
	}
	
	return sb.String()
}

// detectDomainType tries to identify the database domain based on schema/name
func detectDomainType(schema *dbmodel.DatabaseSchema, dbName string) string {
	// Default domain
	domain := "general"
	
	if schema == nil && dbName == "" {
		return domain
	}
	
	// Check database name for clues
	lowerName := strings.ToLower(dbName)
	switch {
	case strings.Contains(lowerName, "hr") || strings.Contains(lowerName, "employee"):
		return "hr"
	case strings.Contains(lowerName, "sales") || strings.Contains(lowerName, "retail"):
		return "sales"
	case strings.Contains(lowerName, "inventory") || strings.Contains(lowerName, "product"):
		return "inventory"
	case strings.Contains(lowerName, "finance") || strings.Contains(lowerName, "account"):
		return "finance"
	case strings.Contains(lowerName, "customer") || strings.Contains(lowerName, "crm"):
		return "crm"
	}
	
	// If schema is available, look for characteristic tables
	if schema != nil {
		// Count occurrences of domain-specific tables
		domainCounts := map[string]int{
			"hr":        0,
			"sales":     0,
			"inventory": 0,
			"finance":   0,
			"crm":       0,
		}
		
		for _, table := range schema.Tables {
			tableName := table.Name
			lowerTable := strings.ToLower(tableName)
			
			// Check for HR tables
			if contains(lowerTable, []string{"employee", "staff", "personnel", "department", "position", "salary", "benefit"}) {
				domainCounts["hr"]++
			}
			
			// Check for sales tables
			if contains(lowerTable, []string{"sale", "order", "transaction", "revenue", "customer", "invoice"}) {
				domainCounts["sales"]++
			}
			
			// Check for inventory tables
			if contains(lowerTable, []string{"product", "inventory", "stock", "item", "warehouse", "supplier"}) {
				domainCounts["inventory"]++
			}
			
			// Check for finance tables
			if contains(lowerTable, []string{"account", "payment", "invoice", "transaction", "budget", "expense"}) {
				domainCounts["finance"]++
			}
			
			// Check for CRM tables
			if contains(lowerTable, []string{"customer", "contact", "lead", "prospect", "interaction"}) {
				domainCounts["crm"]++
			}
		}
		
		// Find domain with highest count
		maxCount := 0
		for d, count := range domainCounts {
			if count > maxCount {
				maxCount = count
				domain = d
			}
		}
	}
	
	return domain
}

// contains checks if a string contains any substring from a list
func contains(s string, substrings []string) bool {
	for _, sub := range substrings {
		if strings.Contains(s, sub) {
			return true
		}
	}
	return false
}

// initializeKnowledge sets up built-in domain knowledge
func (bp *BusinessInfoProvider) initializeKnowledge() {
	// HR domain knowledge
	bp.DomainKnowledge["hr"] = BusinessContext{
		DomainDescription: "Human Resources (HR) database for managing employee information, departments, positions, and related HR activities.",
		TableRules: map[string]string{
			"employees": "Primary employee records - one record per employee with unique employee_id.",
			"departments": "Department structure with unique department_id, may have hierarchical relationship.",
			"positions": "Job positions/titles with salary ranges and requirements.",
		},
		KeyMetrics: map[string]string{
			"Headcount": "Total number of active employees, often grouped by department or location.",
			"Turnover Rate": "Percentage of employees who leave during a period, calculated as departures/average headcount.",
			"Average Tenure": "Average duration of employment across all employees.",
		},
		CommonPatterns: []string{
			"Employee lookup by ID, name, or department",
			"Department headcount and structure reports",
			"Salary distribution and budget analysis",
			"Employee attendance and leave tracking",
		},
		DataConstraints: []string{
			"Employee IDs are unique across the entire system",
			"Dates should be handled in a consistent format, paying attention to timezone issues",
			"Salary and compensation data may require special access permissions",
		},
	}

	// Sales domain knowledge
	bp.DomainKnowledge["sales"] = BusinessContext{
		DomainDescription: "Sales database tracking customer orders, products, transactions, and sales performance.",
		TableRules: map[string]string{
			"orders": "Customer orders with unique order_id, linked to customers and containing multiple order_items.",
			"products": "Product catalog with pricing and inventory information.",
			"customers": "Customer master data with contact and account information.",
		},
		KeyMetrics: map[string]string{
			"Revenue": "Total sales value over a period, often grouped by product, region, or customer segment.",
			"Conversion Rate": "Percentage of leads or prospects that become customers.",
			"Average Order Value": "Mean value of orders, calculated as total revenue/order count.",
		},
		CommonPatterns: []string{
			"Sales reports by time period, product, region, or salesperson",
			"Customer purchase history and preferences analysis",
			"Product performance and inventory status reports",
			"Commission and sales target tracking",
		},
		DataConstraints: []string{
			"Order timestamps should be preserved for accurate time-series analysis",
			"Currency values should specify the currency code for international sales",
			"Product IDs must be consistent across orders and inventory systems",
		},
	}

	// Inventory domain knowledge
	bp.DomainKnowledge["inventory"] = BusinessContext{
		DomainDescription: "Inventory management system tracking products, stock levels, suppliers, and warehouse operations.",
		TableRules: map[string]string{
			"products": "Product master data including SKUs, descriptions, and categories.",
			"inventory": "Current stock levels by product and location, with timestamps.",
			"suppliers": "Vendor information for product sourcing and purchasing.",
		},
		KeyMetrics: map[string]string{
			"Stock Turn": "Rate at which inventory is sold and replaced, calculated as COGS/average inventory value.",
			"Days of Supply": "Number of days inventory would last at current consumption rate.",
			"Stockout Rate": "Percentage of time items are unavailable when needed.",
		},
		CommonPatterns: []string{
			"Stock level monitoring and reorder point triggers",
			"Inventory valuation and accounting reports",
			"Supplier performance and lead time analysis",
			"Product movement and turnover analysis",
		},
		DataConstraints: []string{
			"Inventory levels must be non-negative in most cases",
			"Product identifiers must be consistent across all systems",
			"Location codes should match physical warehouse organization",
		},
	}
}

// CanHandle implements the Agent interface
func (bp *BusinessInfoProvider) CanHandle(input interface{}) bool {
	switch v := input.(type) {
	case base.AgentContext, *base.AgentContext:
		return true
	case map[string]interface{}:
		// Check for any of required fields
		_, hasQuery := v["query"]
		_, hasSchema := v["schema"]
		_, hasName := v["db_name"]
		return hasQuery || hasSchema || hasName
	default:
		return false
	}
}
