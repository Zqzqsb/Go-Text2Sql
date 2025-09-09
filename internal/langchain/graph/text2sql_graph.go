package graph

import (
	"context"
	"fmt"

	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/base"
	"github.com/zqzqsb/gosql/internal/langchain/agents/business_info"
	"github.com/zqzqsb/gosql/internal/langchain/agents/field_aligner"
	"github.com/zqzqsb/gosql/internal/langchain/agents/query_validator"
	"github.com/zqzqsb/gosql/internal/langchain/agents/schema_analyzer"
	"github.com/zqzqsb/gosql/internal/langchain/agents/sql_generator"
)

// StepResult represents the result of a graph step
type StepResult struct {
	Success   bool
	State     *GraphState
	AgentName string
	Output    interface{}
	Error     error
	NextStep  string
}

// Graph represents the Text2SQL task graph
type Graph struct {
	// Core components
	State     *GraphState
	LLMModel  llms.Model
	Agents    map[string]base.Agent
	Steps     map[string]func(context.Context) (StepResult, error)
	
	// Lifecycle hooks
	BeforeStepHooks []func(string, *GraphState)
	AfterStepHooks  []func(string, *GraphState, interface{})
	ErrorHooks      []func(string, *GraphState, error)
	
	// Execution settings
	MaxIterations      int
	RequireUserForClarification bool
	AutoRun            bool
}

// NewGraph creates a new Text2SQL task graph
func NewGraph(model llms.Model) *Graph {
	g := &Graph{
		LLMModel:         model,
		Agents:           make(map[string]base.Agent),
		Steps:            make(map[string]func(context.Context) (StepResult, error)),
		BeforeStepHooks:  make([]func(string, *GraphState), 0),
		AfterStepHooks:   make([]func(string, *GraphState, interface{}), 0),
		ErrorHooks:       make([]func(string, *GraphState, error), 0),
		MaxIterations:    10, // Default max iterations
		RequireUserForClarification: true,
		AutoRun:          false,
	}
	
	// Initialize agents
	g.initializeAgents()
	
	// Define graph steps
	g.defineSteps()
	
	return g
}

// initializeAgents creates and registers all agents
func (g *Graph) initializeAgents() {
	// Create agents
	queryValidator := query_validator.NewQueryValidator(g.LLMModel)
	schemaAnalyzer := schema_analyzer.NewSchemaAnalyzer(g.LLMModel)
	sqlGenerator := sql_generator.NewSQLGenerator(g.LLMModel)
	fieldAligner := field_aligner.NewFieldAligner(g.LLMModel)
	businessInfo := business_info.NewBusinessInfoProvider(g.LLMModel)
	
	// Register agents
	g.Agents["QueryValidator"] = queryValidator
	g.Agents["SchemaAnalyzer"] = schemaAnalyzer
	g.Agents["SQLGenerator"] = sqlGenerator
	g.Agents["FieldAligner"] = fieldAligner
	g.Agents["BusinessInfo"] = businessInfo
}

// defineSteps defines the execution steps in the graph
func (g *Graph) defineSteps() {
	// Query validation step
	g.Steps["ValidateQuery"] = func(ctx context.Context) (StepResult, error) {
		validator, ok := g.Agents["QueryValidator"].(*query_validator.QueryValidator)
		if !ok {
			return StepResult{Success: false, State: g.State, Error: fmt.Errorf("agent type error")}, nil
		}
		
		result, err := validator.Execute(ctx, g.State.Query)
		if err != nil {
			g.State.AddError("ValidateQuery", err.Error())
			return StepResult{Success: false, State: g.State, Error: err}, nil
		}
		
		if validationResult, ok := result.Data.(*query_validator.QueryValidationResult); ok {
			g.State.SetValidationResult(validationResult)
			
			// Determine next step based on ambiguity
			nextStep := "AnalyzeSchema"
			if validationResult.IsAmbiguous {
				nextStep = "Clarify"
			}
			
			return StepResult{
				Success:   result.Success,
				State:     g.State,
				AgentName: "QueryValidator",
				Output:    validationResult,
				NextStep:  nextStep,
			}, nil
		}
		
		return StepResult{Success: false, State: g.State, Error: fmt.Errorf("invalid result type")}, nil
	}
	
	// Clarification step (interactive)
	g.Steps["Clarify"] = func(ctx context.Context) (StepResult, error) {
		// This is a placeholder for user interaction
		// In a real implementation, this would wait for user input
		
		if !g.RequireUserForClarification {
			// If user clarification is not required, proceed to schema analysis
			// with original query
			return StepResult{
				Success:   true,
				State:     g.State,
				AgentName: "Clarification",
				NextStep:  "AnalyzeSchema",
			}, nil
		}
		
		// Otherwise, this step requires external input
		// and would be handled by the caller
		return StepResult{
			Success:   false,
			State:     g.State,
			AgentName: "Clarification",
			Error:     fmt.Errorf("user clarification required"),
		}, nil
	}
	
	// Schema analysis step
	g.Steps["AnalyzeSchema"] = func(ctx context.Context) (StepResult, error) {
		analyzer, ok := g.Agents["SchemaAnalyzer"].(*schema_analyzer.SchemaAnalyzer)
		if !ok {
			return StepResult{Success: false, State: g.State, Error: fmt.Errorf("agent type error")}, nil
		}
		
		// Create input for schema analyzer
		input := map[string]interface{}{
			"schema": g.State.DBSchema,
			"query":  g.State.GetEffectiveQuery(), // Use clarified query if available
		}
		
		result, err := analyzer.Execute(ctx, input)
		if err != nil {
			g.State.AddError("AnalyzeSchema", err.Error())
			return StepResult{Success: false, State: g.State, Error: err}, nil
		}
		
		if analysisResult, ok := result.Data.(schema_analyzer.SchemaEnrichmentResult); ok {
			g.State.SetSchemaAnalysis(&analysisResult)
			
			return StepResult{
				Success:   result.Success,
				State:     g.State,
				AgentName: "SchemaAnalyzer",
				Output:    analysisResult,
				NextStep:  "GenerateSQL",
			}, nil
		}
		
		return StepResult{Success: false, State: g.State, Error: fmt.Errorf("invalid result type")}, nil
	}
	
	// SQL generation step
	g.Steps["GenerateSQL"] = func(ctx context.Context) (StepResult, error) {
		generator, ok := g.Agents["SQLGenerator"].(*sql_generator.SQLGenerator)
		if !ok {
			return StepResult{Success: false, State: g.State, Error: fmt.Errorf("agent type error")}, nil
		}
		
		// Create input for SQL generator
		input := map[string]interface{}{
			"query":             g.State.GetEffectiveQuery(),
			"schema":            g.State.DBSchema,
			"schema_enrichment": g.State.SchemaAnalysis,
			"db_type":           g.State.DBType,
		}
		
		result, err := generator.Execute(ctx, input)
		if err != nil {
			g.State.AddError("GenerateSQL", err.Error())
			return StepResult{Success: false, State: g.State, Error: err}, nil
		}
		
		if sqlResult, ok := result.Data.(sql_generator.SQLGenerationResult); ok {
			g.State.SetSQLGenerationResult(&sqlResult)
			
			return StepResult{
				Success:   result.Success,
				State:     g.State,
				AgentName: "SQLGenerator",
				Output:    sqlResult,
				NextStep:  "AlignFields",
			}, nil
		}
		
		return StepResult{Success: false, State: g.State, Error: fmt.Errorf("invalid result type")}, nil
	}
	
	// Field alignment step
	g.Steps["AlignFields"] = func(ctx context.Context) (StepResult, error) {
		aligner, ok := g.Agents["FieldAligner"].(*field_aligner.FieldAligner)
		if !ok {
			return StepResult{Success: false, State: g.State, Error: fmt.Errorf("agent type error")}, nil
		}
		
		// Create input for field aligner
		input := map[string]interface{}{
			"query":      g.State.GetEffectiveQuery(),
			"sql":        g.State.GeneratedSQL,
			"schema":     g.State.DBSchema,
			"sql_result": g.State.SQLGenResult,
		}
		
		result, err := aligner.Execute(ctx, input)
		if err != nil {
			g.State.AddError("AlignFields", err.Error())
			return StepResult{Success: false, State: g.State, Error: err}, nil
		}
		
		// 处理返回的对齐结果
		if alignResultPtr, ok := result.Data.(*field_aligner.AlignmentResult); ok {
			g.State.SetAlignmentResult(alignResultPtr)
		} else if alignResult, ok := result.Data.(field_aligner.AlignmentResult); ok {
			// 如果是值类型也能处理
			g.State.SetAlignmentResult(&alignResult)
			
			return StepResult{
				Success:   result.Success,
				State:     g.State,
				AgentName: "FieldAligner",
				Output:    alignResult,
				NextStep:  "EnrichBusinessContext",
			}, nil
		}
		
		return StepResult{Success: false, State: g.State, Error: fmt.Errorf("invalid result type")}, nil
	}
	
	// Business context enrichment step
	g.Steps["EnrichBusinessContext"] = func(ctx context.Context) (StepResult, error) {
		provider, ok := g.Agents["BusinessInfo"].(*business_info.BusinessInfoProvider)
		if !ok {
			return StepResult{Success: false, State: g.State, Error: fmt.Errorf("agent type error")}, nil
		}
		
		// Create input for business info provider
		input := map[string]interface{}{
			"query":   g.State.GetEffectiveQuery(),
			"schema":  g.State.DBSchema,
			"db_name": g.State.DBName,
		}
		
		result, err := provider.Execute(ctx, input)
		if err != nil {
			g.State.AddError("EnrichBusinessContext", err.Error())
			return StepResult{Success: false, State: g.State, Error: err}, nil
		}
		
		if businessContext, ok := result.Data.(business_info.BusinessContext); ok {
			g.State.SetBusinessContext(&businessContext)
			
			return StepResult{
				Success:   result.Success,
				State:     g.State,
				AgentName: "BusinessInfo",
				Output:    businessContext,
				NextStep:  "", // End of graph
			}, nil
		}
		
		return StepResult{Success: false, State: g.State, Error: fmt.Errorf("invalid result type")}, nil
	}
}

// Initialize sets up the graph with an initial state
func (g *Graph) Initialize(query, dbName, dbType string, dbSchema *dbmodel.DatabaseSchema, fieldsInfo map[string]string) {
	g.State = NewGraphState(query, dbName, dbType, dbSchema).WithFieldsInfo(fieldsInfo)
}

// AddBeforeStepHook adds a hook that runs before executing a step
func (g *Graph) AddBeforeStepHook(hook func(string, *GraphState)) {
	g.BeforeStepHooks = append(g.BeforeStepHooks, hook)
}

// AddAfterStepHook adds a hook that runs after executing a step
func (g *Graph) AddAfterStepHook(hook func(string, *GraphState, interface{})) {
	g.AfterStepHooks = append(g.AfterStepHooks, hook)
}

// AddErrorHook adds a hook that runs when a step encounters an error
func (g *Graph) AddErrorHook(hook func(string, *GraphState, error)) {
	g.ErrorHooks = append(g.ErrorHooks, hook)
}

// ExecuteStep runs a specific step in the graph
func (g *Graph) ExecuteStep(ctx context.Context, stepName string) (StepResult, error) {
	step, exists := g.Steps[stepName]
	if !exists {
		return StepResult{}, fmt.Errorf("step %s not found", stepName)
	}
	
	// Run before hooks
	for _, hook := range g.BeforeStepHooks {
		hook(stepName, g.State)
	}
	
	// Execute step
	result, err := step(ctx)
	
	if err != nil {
		// Run error hooks
		for _, hook := range g.ErrorHooks {
			hook(stepName, g.State, err)
		}
		return result, err
	}
	
	// Run after hooks
	for _, hook := range g.AfterStepHooks {
		hook(stepName, g.State, result.Output)
	}
	
	return result, nil
}

// RunToCompletion runs the entire graph from start to finish
func (g *Graph) RunToCompletion(ctx context.Context) (*GraphState, error) {
	step := "ValidateQuery" // Start with query validation
	iterations := 0
	
	for step != "" && iterations < g.MaxIterations {
		iterations++
		
		// Execute current step
		result, err := g.ExecuteStep(ctx, step)
		if err != nil {
			return g.State, err
		}
		
		if !result.Success {
			return g.State, fmt.Errorf("step %s failed", step)
		}
		
		// Check if we need user clarification
		if step == "Clarify" && g.RequireUserForClarification {
			return g.State, fmt.Errorf("user clarification required")
		}
		
		// Move to next step
		step = result.NextStep
	}
	
	if iterations >= g.MaxIterations {
		return g.State, fmt.Errorf("exceeded maximum iterations")
	}
	
	return g.State, nil
}

// ProvideUserClarification handles user clarification for ambiguous queries
func (g *Graph) ProvideUserClarification(clarifiedQuery string) {
	g.State.SetClarifiedQuery(clarifiedQuery)
}

// GetFinalSQL returns the final SQL from the graph state
func (g *Graph) GetFinalSQL() string {
	return g.State.GetFinalSQL()
}

// GetState returns the current graph state
func (g *Graph) GetState() *GraphState {
	return g.State
}
