package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/graph"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/predict"
	"github.com/zqzqsb/gosql/internal/schema"
)

// Command line options
var (
	llmConfigPath          string
	datasetPath            string
	split                  string
	outputDir              string
	startID                int
	endID                  int
	targetID               int
	useIndex               bool
	disableThinking        bool
	dbType                 string
	fieldsInfoType         string
	interactiveMode        bool
	maxQueryRows           int
	expandSchema           bool
	verboseDebug           bool
	requireUserClarification bool
)

func init() {
	// Command line parameters
	flag.StringVar(&llmConfigPath, "config", "", "LLM configuration file")
	flag.StringVar(&datasetPath, "dataset", "", "Dataset configuration file path")
	flag.StringVar(&split, "split", "test", "Dataset split (train, dev, test)")
	flag.StringVar(&outputDir, "output-dir", "results", "Output directory")
	flag.IntVar(&startID, "start", 0, "Start example ID or index")
	flag.IntVar(&endID, "end", -1, "End example ID or index")
	flag.IntVar(&targetID, "id", -1, "Target example ID")
	flag.BoolVar(&useIndex, "use-index", true, "Use example index instead of ID")
	flag.BoolVar(&disableThinking, "disable-thinking", false, "Disable thinking process")
	flag.StringVar(&dbType, "db-type", "sqlite", "Database type (sqlite, postgres)")
	flag.StringVar(&fieldsInfoType, "fields-info-type", "", "Field information type (empty, fields, description)")
	flag.BoolVar(&interactiveMode, "interactive", true, "Enable interactive SQL generation")
	flag.IntVar(&maxQueryRows, "max-query-rows", 100, "Maximum rows to return per query in interactive mode")
	flag.BoolVar(&expandSchema, "expand-schema", false, "Show full schema in logs")
	flag.BoolVar(&verboseDebug, "verbose-debug", false, "Enable detailed debug output")
	flag.BoolVar(&requireUserClarification, "require-clarification", true, "Require user input for ambiguous queries")
}

func main() {
	flag.Parse()

	// Check if PostgreSQL is being used
	usePostgreSQL := strings.ToLower(dbType) == "postgres" || strings.ToLower(dbType) == "postgresql"
	if usePostgreSQL {
		fmt.Println("Using PostgreSQL database")
	} else {
		fmt.Println("Using SQLite database")
	}

	// Check required parameters
	if datasetPath == "" {
		fmt.Println("Error: Dataset configuration file path is required (--dataset)")
		flag.Usage()
		os.Exit(1)
	}

	// Load configuration
	cfg, err := config.LoadConfig(llmConfigPath)
	if err != nil {
		fmt.Printf("Failed to load configuration: %v\n", err)
		os.Exit(1)
	}

	// Load dataset
	currentDataset, err := dataset.LoadFromFile(datasetPath)
	if err != nil {
		fmt.Printf("Failed to load dataset configuration: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Dataset: type=%s, name=%s\n", currentDataset.Type, currentDataset.Name)

	// Load examples
	var examples []map[string]interface{}
	switch split {
	case "train":
		examples, err = currentDataset.LoadTrainExamples()
	case "dev":
		examples, err = currentDataset.LoadDevExamples()
	case "test":
		examples, err = currentDataset.LoadTestExamples()
	default:
		fmt.Printf("Unsupported dataset split: %s\n", split)
		os.Exit(1)
	}

	if err != nil {
		fmt.Printf("Failed to load %s examples: %v\n", split, err)
		os.Exit(1)
	}

	fmt.Printf("Number of %s examples: %d\n", split, len(examples))

	// Create LLM factory and client
	factory := llm.NewLLMFactory(cfg)
	client, err := factory.Create()
	if err != nil {
		fmt.Printf("Failed to create LLM client: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("LLM client: provider=%s, model=%s\n\n", client.Provider(), client.ModelName())

	// Set options
	options := factory.GetDefaultOptions()
	options.DisableThinking = disableThinking
	options.FieldsInfoType = fieldsInfoType
	options.VerboseDebug = verboseDebug

	// Create output directory
	runID := fmt.Sprintf("%s_%s", currentDataset.Name, split)
	if usePostgreSQL {
		runID += "_pg"
	}
	runID += "_langchain" // Add langchain tag to distinguish from original runs
	if interactiveMode {
		runID += "_interactive"
	}
	if fieldsInfoType != "" {
		runID += "_with_" + fieldsInfoType + "_info"
	} else {
		runID += "_with_no_field_info"
	}

	runDir := filepath.Join(outputDir, runID)
	if _, err := os.Stat(runDir); os.IsNotExist(err) {
		if err := os.MkdirAll(runDir, 0755); err != nil {
			fmt.Printf("Failed to create run directory: %v\n", err)
			os.Exit(1)
		}
	}

	// Result file paths
	outputFile := filepath.Join(runDir, "info.jsonl")
	predFile := filepath.Join(runDir, "pred.sql")

	// Open result file
	outputFp, err := os.Create(outputFile)
	if err != nil {
		fmt.Printf("Failed to create result file: %v\n", err)
		os.Exit(1)
	}
	defer outputFp.Close()

	// Filter examples to process
	var processedExamples []map[string]interface{}
	if targetID >= 0 {
		// Process single example by ID
		for _, example := range examples {
			id := predict.GetExampleID(example)
			if id == targetID {
				processedExamples = append(processedExamples, example)
				break
			}
		}
		if len(processedExamples) == 0 {
			fmt.Printf("Target example ID=%d not found\n", targetID)
			os.Exit(1)
		}
	} else {
		// Process range of examples
		for i, example := range examples {
			if useIndex {
				if i < startID {
					continue
				}
				if endID >= 0 && i > endID {
					continue
				}
			} else {
				id := predict.GetExampleID(example)
				if id < startID {
					continue
				}
				if endID >= 0 && id > endID {
					continue
				}
			}
			processedExamples = append(processedExamples, example)
		}
	}

	fmt.Printf("Will process %d examples\n", len(processedExamples))

	// Process examples
	ambiguousQueriesCount := 0
	
	for i, example := range processedExamples {
		fmt.Printf("Processing example %d/%d...\n", i+1, len(processedExamples))

		// Extract example information
		id := predict.GetExampleID(example)
		dbID, _ := example["db_id"].(string)
		question, _ := example["question"].(string)
		gtSQL, _ := example["query"].(string)

		// Load database schema
		dbPath := filepath.Join(currentDataset.BaseDir, currentDataset.DBDir, dbID)
		origSchema, err := schema.LoadSchema(dbPath)
		if err != nil {
			fmt.Printf("Failed to load database schema: %v\n", err)
			continue
		}
		
		// Convert schema.DatabaseSchema to dbmodel.DatabaseSchema
		dbSchema := convertSchemaToDbModel(origSchema)
		
		// Extract field information
		fieldsInfo := extractFieldsInfo(example, fieldsInfoType)
		
		// Process using langchain graph
		result := processWithLangchainGraph(client, question, dbID, dbType, dbSchema, fieldsInfo, interactiveMode, requireUserClarification)

		// Create SQLResult
		sqlResult := predict.SQLResult{
			ID:        id,
			DBName:    dbID,
			Question:  question,
			GTSQL:     gtSQL,
			PredSQL:   result.FinalSQL,
			Thinking:  result.Thinking,
			Ambiguous: boolToString(result.IsAmbiguous),
		}

		// Create interactive result if needed
		if interactiveMode {
			steps := make([]predict.InteractiveStep, 0)
			if len(result.Steps) > 0 {
				for _, step := range result.Steps {
					// Convert our step to predict.InteractiveStep format
					steps = append(steps, predict.InteractiveStep{
						StepType:    step.Agent,
						Query:       fmt.Sprintf("%v", step.Input),
						QueryResult: fmt.Sprintf("%v", step.Output),
						Reasoning:   "",
					})
				}
			}

			interactiveResult := predict.InteractiveResult{
				SQLResult:     sqlResult,
				Steps:         steps,
				IsInteractive: len(steps) > 0,
			}

			// Save and print interactive result
			predict.SaveInteractiveResult(outputFp, interactiveResult)
			predict.PrintInteractiveResult(interactiveResult)
		} else {
			// Save and print simple result
			predict.SaveResult(outputFp, sqlResult)
			predict.PrintResult(sqlResult)
		}
	}

	fmt.Printf("\nResults saved to: %s\n", outputFile)

	// Generate prediction file
	predict.GeneratePredictionFile(outputFile, predFile)

	fmt.Printf("\nProcessed %d examples, %d were ambiguous queries\n",
		len(processedExamples), ambiguousQueriesCount)
}

// GraphResult holds the result of langchain graph execution
type GraphResult struct {
	FinalSQL    string
	Thinking    string
	IsAmbiguous bool
	Steps       []ProcessStep
}

// ProcessStep represents a step in the processing workflow
type ProcessStep struct {
	Agent     string
	Input     string
	Output    interface{}
	Timestamp int64
}

// processWithLangchainGraph runs the langchain graph for a query
// convertSchemaToDbModel converts schema.DatabaseSchema to dbmodel.DatabaseSchema
func convertSchemaToDbModel(schemaDB *schema.DatabaseSchema) *dbmodel.DatabaseSchema {
	result := &dbmodel.DatabaseSchema{
		Tables: make([]dbmodel.Table, 0, len(schemaDB.Tables)),
		ForeignKeys: make([]dbmodel.ForeignKey, 0, len(schemaDB.ForeignKeys)),
	}

	// Convert tables
	for _, table := range schemaDB.Tables {
		dbTable := dbmodel.Table{
			Name:    table.Name,
			Columns: make([]dbmodel.Column, 0, len(table.Columns)),
		}

		// Convert columns
		for _, col := range table.Columns {
			dbCol := dbmodel.Column{
				Name:      col.Name,
				Type:      col.Type,
				IsPrimary: col.IsPrimary,
				IsForeign: col.IsForeign,
			}

			dbTable.Columns = append(dbTable.Columns, dbCol)
		}

		result.Tables = append(result.Tables, dbTable)
	}

	// Convert foreign keys
	for _, fk := range schemaDB.ForeignKeys {
		dbFk := dbmodel.ForeignKey{
			SourceTable:  fk.SourceTable,
			SourceColumn: fk.SourceColumn,
			TargetTable:  fk.TargetTable,
			TargetColumn: fk.TargetColumn,
		}
		result.ForeignKeys = append(result.ForeignKeys, dbFk)
	}

	return result
}

func processWithLangchainGraph(
	client llm.LLM,
	query, dbID, dbType string,
	dbSchema *dbmodel.DatabaseSchema,
	fieldsInfo map[string]string,
	interactive, requireClarification bool,
) GraphResult {
	result := GraphResult{
		FinalSQL:    "",
		Thinking:    "",
		IsAmbiguous: false,
		Steps:       make([]ProcessStep, 0),
	}

	// Create langchain graph
	// Use client's model directly as we don't have a GetUnderlyingModel method
	g := graph.NewGraph(nil) // We'll set up the LLM differently
	g.RequireUserForClarification = requireClarification

	// Initialize graph with query and schema
	g.Initialize(query, dbID, dbType, dbSchema, fieldsInfo)

	// Add hooks to capture steps
	g.AddBeforeStepHook(func(step string, state *graph.GraphState) {
		if verboseDebug {
			fmt.Printf("Starting step: %s\n", step)
		}
	})

	g.AddAfterStepHook(func(step string, state *graph.GraphState, output interface{}) {
		if verboseDebug {
			fmt.Printf("Completed step: %s\n", step)
		}

		// Record step for interactive mode
		if interactive {
			result.Steps = append(result.Steps, ProcessStep{
				Agent:     step,
				Input:     query,
				Output:    output,
				Timestamp: 0, // Could add real timestamp if needed
			})
		}
	})

	// Run graph
	ctx := context.Background()
	finalState, err := g.RunToCompletion(ctx)
	
	if err != nil {
		if verboseDebug {
			fmt.Printf("Graph execution error: %v\n", err)
		}
		
		// Check if this is due to ambiguity
		if finalState != nil && finalState.ValidationResult != nil && finalState.ValidationResult.IsAmbiguous {
			result.IsAmbiguous = true
			result.FinalSQL = "AMBIGUOUS_QUERY"
			
			// If interactive and not requiring clarification, simulate clarification
			if interactive && !requireClarification {
				// Use original query as "clarified"
				g.ProvideUserClarification(query)
				
				// Continue execution
				finalState, err = g.RunToCompletion(ctx)
				if err != nil {
					if verboseDebug {
						fmt.Printf("Post-clarification error: %v\n", err)
					}
				} else {
					// Use result from continued execution
					result.FinalSQL = finalState.GetFinalSQL()
					if finalState.SQLGenResult != nil {
						result.Thinking = finalState.SQLGenResult.Thinking
					}
				}
			}
		} else {
			// Other error
			result.FinalSQL = "ERROR: " + err.Error()
		}
	} else {
		// Successful execution
		result.FinalSQL = finalState.GetFinalSQL()
		if finalState.SQLGenResult != nil {
			result.Thinking = finalState.SQLGenResult.Thinking
		}
	}

	return result
}

// extractFieldsInfo extracts field information from example
func extractFieldsInfo(example map[string]interface{}, infoType string) map[string]string {
	fieldsInfo := make(map[string]string)
	
	// Skip if no info type specified
	if infoType == "" {
		return fieldsInfo
	}
	
	// Extract fields
	if infoType == "fields" {
		if fields, ok := example["fields"].(map[string]interface{}); ok {
			for field, value := range fields {
				fieldsInfo[field] = fmt.Sprintf("%v", value)
			}
		}
	}
	
	// Extract field descriptions
	if infoType == "description" {
		if descriptions, ok := example["field_descriptions"].(map[string]interface{}); ok {
			for field, desc := range descriptions {
				fieldsInfo[field] = fmt.Sprintf("%v", desc)
			}
		}
	}
	
	return fieldsInfo
}

// boolToString converts boolean to string representation
func boolToString(b bool) string {
	if b {
		return "True"
	}
	return "False"
}
