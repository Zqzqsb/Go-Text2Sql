package tools

import (
	"context"
	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// ToolRegistry 工具注册表
type ToolRegistry struct {
	tools map[string]Tool
}

// NewToolRegistry 创建工具注册表
func NewToolRegistry() *ToolRegistry {
	return &ToolRegistry{
		tools: make(map[string]Tool),
	}
}

// Register 注册工具
func (r *ToolRegistry) Register(tool Tool) {
	r.tools[tool.Name()] = tool
}

// Get 获取工具
func (r *ToolRegistry) Get(name string) (Tool, bool) {
	tool, exists := r.tools[name]
	return tool, exists
}

// GetAll 获取所有工具
func (r *ToolRegistry) GetAll() []Tool {
	tools := make([]Tool, 0, len(r.tools))
	for _, tool := range r.tools {
		tools = append(tools, tool)
	}
	return tools
}

// Tool 表示Agent可以使用的工具
type Tool interface {
	// Name 返回工具名称
	Name() string
	
	// Description 返回工具描述
	Description() string
	
	// ParameterSchema 返回参数schema
	ParameterSchema() map[string]string
	
	// Execute 执行工具
	Execute(ctx context.Context, params map[string]interface{}) (string, error)
}

// RegisterStandardTools 注册标准工具集
func RegisterStandardTools(registry *ToolRegistry, llm llms.Model) {
	// 注册查询验证工具
	registry.Register(NewQueryValidatorTool(llm))
	
	// 注册Schema分析工具
	registry.Register(NewSchemaAnalyzerTool(llm))
	
	// 注册SQL生成工具
	registry.Register(NewSQLGeneratorTool(llm))
	
	// 注册字段对齐工具
	registry.Register(NewFieldAlignerTool(llm))
}

// RegisterBusinessInfoTool 注册业务信息工具
func RegisterBusinessInfoTool(registry *ToolRegistry, llm llms.Model) {
	// TODO: 实现业务信息提供工具
}

// EnsureSchemaInParams 确保工具参数中包含Schema
func EnsureSchemaInParams(params map[string]interface{}, schema *dbmodel.DatabaseSchema) map[string]interface{} {
	if params == nil {
		params = make(map[string]interface{})
	}
	
	// 注入schema
	if _, exists := params["schema"]; !exists {
		params["schema"] = schema
	}
	
	return params
}
