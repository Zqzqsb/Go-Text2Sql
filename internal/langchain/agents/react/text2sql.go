package react

import (
	"context"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/langchain/agents/react/tools"
)

// Text2SQLAgent 是基于ReAct模式的Text2SQL代理
type Text2SQLAgent struct {
	llm         llms.Model
	tools       *tools.ToolRegistry
	maxSteps    int
	dbSchema    *dbmodel.DatabaseSchema
	dbName      string
	dbType      string
	interactive bool
}

// Text2SQLConfig 是Text2SQLAgent的配置选项
type Text2SQLConfig struct {
	LLM         llms.Model
	DBSchema    *dbmodel.DatabaseSchema
	DBName      string
	DBType      string
	MaxSteps    int
	Interactive bool
}

// NewText2SQLAgent 创建一个新的Text2SQLAgent
func NewText2SQLAgent(config Text2SQLConfig) *Text2SQLAgent {
	// 设置默认值
	maxSteps := config.MaxSteps
	if maxSteps <= 0 {
		maxSteps = 10
	}
	
	return &Text2SQLAgent{
		llm:         config.LLM,
		tools:       tools.NewToolRegistry(),
		maxSteps:    maxSteps,
		dbSchema:    config.DBSchema,
		dbName:      config.DBName,
		dbType:      config.DBType,
		interactive: config.Interactive,
	}
}

// RegisterTool 注册工具
func (a *Text2SQLAgent) RegisterTool(tool tools.Tool) {
	a.tools.Register(tool)
}

// SetTools 设置工具注册表
func (a *Text2SQLAgent) SetTools(toolRegistry *tools.ToolRegistry) {
	a.tools = toolRegistry
}

// Execute 执行Text2SQL转换
func (a *Text2SQLAgent) Execute(ctx context.Context, query string) (*Text2SQLResult, error) {
	// 创建初始状态
	state := NewState(query, a.dbName, a.dbType, a.dbSchema)
	
	// 创建ReActAgent
	agent := NewReActAgent(a.llm, a.tools, a.maxSteps)
	
	// 执行ReAct循环
	resultState, err := agent.Execute(ctx, state)
	if err != nil {
		return nil, fmt.Errorf("ReActAgent执行失败: %v", err)
	}
	
	// 处理结果
	result := &Text2SQLResult{
		Query:        query,
		SQL:          resultState.FinalSQL,
		Explanation:  resultState.FinalOutput,
		Steps:        resultState.History,
		IsAmbiguous:  a.checkIfAmbiguous(resultState),
		Errors:       resultState.Errors,
	}
	
	return result, nil
}

// checkIfAmbiguous 检查查询是否存在歧义
func (a *Text2SQLAgent) checkIfAmbiguous(state *State) bool {
	// 从历史中查找验证器工具的使用结果
	for _, step := range state.History {
		if step.Action != nil && step.Action.Tool == "validate_query" {
			// 简单检查观察结果是否包含歧义指示
			return (step.Observation != "" && 
				(contains(step.Observation, "ambiguous") || 
				 contains(step.Observation, "模糊") ||
				 contains(step.Observation, "不明确")))
		}
	}
	
	return false
}

// contains 检查字符串是否包含子串（不区分大小写）
func contains(s, substr string) bool {
	s, substr = strings.ToLower(s), strings.ToLower(substr)
	return strings.Contains(s, substr)
}

// Text2SQLResult 表示Text2SQL转换结果
type Text2SQLResult struct {
	Query       string  // 原始查询
	SQL         string  // 生成的SQL
	Explanation string  // 解释
	Steps       []Step  // 执行步骤
	IsAmbiguous bool    // 是否模糊
	Errors      []string // 错误信息
}

// GetSQL 获取SQL结果
func (r *Text2SQLResult) GetSQL() string {
	return r.SQL
}

// GetExplanation 获取解释
func (r *Text2SQLResult) GetExplanation() string {
	return r.Explanation
}

// GetSteps 获取执行步骤
func (r *Text2SQLResult) GetSteps() []Step {
	return r.Steps
}

// GetIsAmbiguous 获取是否模糊
func (r *Text2SQLResult) GetIsAmbiguous() bool {
	return r.IsAmbiguous
}
