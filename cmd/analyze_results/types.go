package main

import (
	"strings"
)

// DBType 表示支持的数据库类型
type DBType int

// 数据库类型枚举
const (
	DBTypeUnknown DBType = iota
	DBTypeSQLite
	DBTypePostgreSQL
	DBTypeMySQL
)

// String 返回数据库类型的字符串表示
func (t DBType) String() string {
	switch t {
	case DBTypeSQLite:
		return "sqlite"
	case DBTypePostgreSQL:
		return "postgresql"
	case DBTypeMySQL:
		return "mysql"
	default:
		return "unknown"
	}
}

// ParseDBType 将字符串转换为DBType
func ParseDBType(dbType string) DBType {
	switch strings.ToLower(dbType) {
	case "sqlite":
		return DBTypeSQLite
	case "postgresql", "postgres":
		return DBTypePostgreSQL
	case "mysql":
		return DBTypeMySQL
	default:
		return DBTypeUnknown
	}
}

// InputResult 表示输入的SQL结果结构
type InputResult struct {
	ID        int    `json:"id"`
	DBName    string `json:"db_name"`
	Question  string `json:"question"`
	GTSQL     string `json:"gt_sql"`
	PredSQL   string `json:"pred_sql"`
	Thinking  string `json:"thinking,omitempty"`
	Ambiguous string `json:"ambiguous,omitempty"`
}

// AnalysisResult 表示分析后的SQL结果结构
type AnalysisResult struct {
	ID           int    `json:"id"`
	DBName       string `json:"db_id"`
	Question     string `json:"question"`
	GTSQL        string `json:"gt_sql"`
	PredSQL      string `json:"pred_sql"`
	IsCorrect    bool   `json:"is_correct"`
	IsEquivalent bool   `json:"is_equivalent"`
	ErrorReason  string `json:"error_reason,omitempty"`
	ErrorType    string `json:"error_type,omitempty"`
	Thinking     string `json:"thinking[optional],omitempty"`
	Ambiguous    string `json:"ambigous[optional],omitempty"`

	// 执行结果
	GTResult   *ExecResult `json:"gt_result,omitempty"`
	PredResult *ExecResult `json:"pred_result,omitempty"`
}

// ExecResult 表示SQL执行结果
type ExecResult struct {
	Success bool       `json:"Success"`
	Error   string     `json:"Error"`
	Rows    [][]string `json:"Rows"`
}

// ErrorCount 用于错误统计排序
type ErrorCount struct {
	Reason string
	Count  int
	Type   string
}

// ErrorStatistics 保存错误统计信息
type ErrorStatistics struct {
	TotalCount           int
	CorrectCount         int
	AmbiguousCount       int
	EquivalentCount      int
	DBNotExistCount      int
	SyntaxErrorCount     int
	ProjectionErrorCount int
	DataErrorCount       int
	RowErrorCount        int // 专门用于行数错误统计
	ReferenceErrorCount  int // 参考答案有语法错误
	ExecutionErrorCount  int // 执行错误（预测SQL语法错误）
	// 下面三个字段已不再使用，保留是为了向后兼容
	OrderErrorCount     int
	JoinErrorCount      int
	ConditionErrorCount int
	OtherErrorCount     int
	ErrorCounts         []ErrorCount
}
