package react

import (
	"time"

	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// State 表示Agent状态机的当前状态
type State struct {
	Query        string                 // 用户原始查询
	History      []Step                 // 交互历史步骤
	Context      map[string]interface{} // 上下文信息
	DBSchema     *dbmodel.DatabaseSchema // 数据库schema
	DBName       string                 // 数据库名
	DBType       string                 // 数据库类型
	FieldsInfo   map[string]string      // 字段信息
	Errors       []string               // 错误记录
	FinalSQL     string                 // 最终生成的SQL
	FinalOutput  string                 // 最终输出结果
}

// NewState 创建一个新的状态实例
func NewState(query string, dbName string, dbType string, dbSchema *dbmodel.DatabaseSchema) *State {
	return &State{
		Query:       query,
		History:     []Step{},
		Context:     make(map[string]interface{}),
		DBSchema:    dbSchema,
		DBName:      dbName,
		DBType:      dbType,
		FieldsInfo:  make(map[string]string),
		Errors:      []string{},
	}
}

// WithFieldsInfo 添加字段信息
func (s *State) WithFieldsInfo(fieldsInfo map[string]string) *State {
	s.FieldsInfo = fieldsInfo
	return s
}

// AddError 添加错误
func (s *State) AddError(errorMsg string) {
	s.Errors = append(s.Errors, errorMsg)
}

// Step 表示ReAct循环中的一个完整步骤
type Step struct {
	Thought     string      // Agent的思考过程
	Action      *Action     // 选择的动作(可为nil表示直接回答)
	Observation string      // 动作执行后的观察结果
	Timestamp   time.Time   // 步骤执行时间戳
}

// Action 表示Agent选择执行的工具调用
type Action struct {
	Tool        string                 // 工具名称
	Parameters  map[string]interface{} // 参数
	Result      string                 // 执行结果
}
