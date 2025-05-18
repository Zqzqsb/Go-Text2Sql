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
