package base

import (
	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// AgentContext 定义了agent执行上下文
type AgentContext struct {
	// 原始查询相关
	OriginalQuery string // 用户的原始自然语言查询
	IsQueryValid  bool   // 查询是否明确有效
	Clarification string // 需要澄清的问题

	// 数据库相关
	DBName     string                 // 数据库名称
	DBSchema   *dbmodel.DatabaseSchema // 数据库模式
	DBType     string                 // 数据库类型 (sqlite, postgres等)
	FieldsInfo map[string]string      // 字段信息描述

	// 生成结果相关
	GeneratedSQL     string      // 生成的SQL语句
	SQLResults       interface{} // SQL执行结果
	SQLExplanation   string      // SQL解释
	IsFieldsAligned  bool        // 字段是否对齐
	BusinessContext  string      // 业务上下文信息
	
	// 元数据
	Metadata map[string]interface{} // 附加信息
	
	// 调试信息
	Debug map[string]interface{} // 调试数据
}

// NewAgentContext 创建新的agent上下文
func NewAgentContext(query string, dbName string, dbType string) *AgentContext {
	return &AgentContext{
		OriginalQuery: query,
		DBName:        dbName,
		DBType:        dbType,
		IsQueryValid:  true, // 默认假设查询有效，直到验证器判定为模糊查询
		Metadata:      make(map[string]interface{}),
		Debug:         make(map[string]interface{}),
		FieldsInfo:    make(map[string]string),
	}
}

// WithSchema 设置数据库模式
func (c *AgentContext) WithSchema(schema *dbmodel.DatabaseSchema) *AgentContext {
	c.DBSchema = schema
	return c
}

// WithFieldsInfo 设置字段信息
func (c *AgentContext) WithFieldsInfo(fieldsInfo map[string]string) *AgentContext {
	c.FieldsInfo = fieldsInfo
	return c
}

// MarkAsAmbiguous 将查询标记为模糊查询
func (c *AgentContext) MarkAsAmbiguous(clarification string) {
	c.IsQueryValid = false
	c.Clarification = clarification
}

// SetGeneratedSQL 设置生成的SQL
func (c *AgentContext) SetGeneratedSQL(sql string, explanation string) {
	c.GeneratedSQL = sql
	c.SQLExplanation = explanation
}

// SetSQLResults 设置SQL执行结果
func (c *AgentContext) SetSQLResults(results interface{}) {
	c.SQLResults = results
}

// SetBusinessContext 设置业务上下文
func (c *AgentContext) SetBusinessContext(context string) {
	c.BusinessContext = context
}

// GetState 返回上下文的简单状态映射
func (c *AgentContext) GetState() map[string]interface{} {
	return map[string]interface{}{
		"original_query":   c.OriginalQuery,
		"is_query_valid":   c.IsQueryValid,
		"clarification":    c.Clarification,
		"db_name":          c.DBName,
		"db_type":          c.DBType,
		"generated_sql":    c.GeneratedSQL,
		"business_context": c.BusinessContext,
	}
}
