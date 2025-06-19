package main

// SQLResult 定义了SQL生成结果的结构
type SQLResult struct {
	ID        int    `json:"idx"`
	DBName    string `json:"db_id"`
	Question  string `json:"question"`
	GTSQL     string `json:"ground_truth"`
	PredSQL   string `json:"pred"`
	Thinking  string `json:"thinking"`  // 修复标签格式
	Ambiguous string `json:"ambiguous"` // 修复拼写错误
}

// InteractiveStep 表示交互式生成过程中的一个步骤
type InteractiveStep struct {
	StepType    string `json:"step_type"`    // "query" 或 "final"
	Query       string `json:"query"`        // 查询 SQL
	QueryResult string `json:"query_result"` // 查询结果（JSON 格式）
	Reasoning   string `json:"reasoning"`    // 推理过程
}

// InteractiveResult 表示交互式生成的完整结果
type InteractiveResult struct {
	SQLResult
	Steps         []InteractiveStep `json:"steps"`          // 交互步骤
	TotalSteps    int               `json:"total_steps"`    // 总步骤数
	QueryCount    int               `json:"query_count"`    // 查询次数
	IsInteractive bool              `json:"is_interactive"` // 是否使用了交互模式
}

// QueryRequest 表示 LLM 请求执行的查询
type QueryRequest struct {
	SQL       string `json:"sql"`
	Reasoning string `json:"reasoning"`
	NeedMore  bool   `json:"need_more"` // 是否还需要更多查询
}

// QueryResponse 表示查询执行的响应
type QueryResponse struct {
	Success bool                     `json:"success"`
	Error   string                   `json:"error,omitempty"`
	Rows    []map[string]interface{} `json:"rows,omitempty"`
	Summary string                   `json:"summary"` // 查询结果的摘要
}
