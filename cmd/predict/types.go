package main

// SQLResult 定义了SQL生成结果的结构
type SQLResult struct {
	ID       int    `json:"id"`
	DBName   string `json:"db_id"`
	Question string `json:"question"`
	GTSQL    string `json:"gt_sql"`
	PredSQL  string `json:"pred_sql"`
	Thinking string `json:"thinking[optional],omitempty"`
	Ambiguous string `json:"ambigous[optional],omitempty"`
}
