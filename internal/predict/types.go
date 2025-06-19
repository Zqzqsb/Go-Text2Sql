package predict

// SQLResult 表示SQL生成结果
type SQLResult struct {
	ID        int    `json:"id"`
	DBName    string `json:"db_name"`
	Question  string `json:"question"`
	GTSQL     string `json:"gt_sql"`
	PredSQL   string `json:"pred_sql"`
	Thinking  string `json:"thinking"`
	Ambiguous string `json:"ambiguous"`
}

// InteractiveStep 表示交互式生成的一个步骤
type InteractiveStep struct {
	StepType    string `json:"step_type"`    // "query" 或 "final"
	Query       string `json:"query"`        // 执行的SQL查询
	QueryResult string `json:"query_result"` // 查询结果（JSON格式）
	Reasoning   string `json:"reasoning"`    // 这一步的推理过程
}

// InteractiveResult 表示交互式SQL生成结果
type InteractiveResult struct {
	SQLResult
	Steps         []InteractiveStep `json:"steps"`
	IsInteractive bool              `json:"is_interactive"` // 是否真正进行了交互
	QueryCount    int               `json:"query_count"`    // 查询次数
	TotalSteps    int               `json:"total_steps"`    // 总步数
}

// QueryRequest 表示查询请求
type QueryRequest struct {
	SQL       string
	Reasoning string
	NeedMore  bool
}

// QueryResponse 表示查询响应
type QueryResponse struct {
	Success bool                     `json:"success"`
	Rows    []map[string]interface{} `json:"rows,omitempty"`
	Error   string                   `json:"error,omitempty"`
	Summary string                   `json:"summary"`
}
