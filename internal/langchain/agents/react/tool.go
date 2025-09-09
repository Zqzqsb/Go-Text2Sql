package react

import (
	"context"
)

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

// ToolDescription 工具描述
type ToolDescription struct {
	Name        string
	Description string
	Parameters  map[string]string
}
