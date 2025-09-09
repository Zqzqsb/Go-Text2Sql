package examples_test

import (
"context"
"testing"
"time"

"github.com/tmc/langchaingo/llms/openai"
"github.com/zqzqsb/gosql/internal/dbmodel"
"github.com/zqzqsb/gosql/internal/langchain/agents/react"
"github.com/zqzqsb/gosql/internal/langchain/agents/react/tools"
)

// TestReActAgent 测试ReAct Agent的基本功能
func TestReActAgent(t *testing.T) {
	// 创建LLM实例
	llm, err := openai.New(openai.WithModel("gpt-3.5-turbo"))
	if err != nil {
		t.Fatalf("创建LLM失败: %v", err)
	}
	
	// 创建简单的测试数据库Schema
	schema := createTestSchema()
	
	// 创建工具注册表
	toolRegistry := tools.NewToolRegistry()
	
	// 注册标准工具
	tools.RegisterStandardTools(toolRegistry, llm)
	
	// 创建Text2SQL Agent
	agent := react.NewText2SQLAgent(react.Text2SQLConfig{
LLM:         llm,
DBSchema:    schema,
DBName:      "hr",
DBType:      "postgres",
MaxSteps:    10,
Interactive: false,
})
	
	// 设置工具
	agent.SetTools(toolRegistry)
	
	// 设置查询
	query := "获取所有员工的姓名和部门"
	
	// 创建上下文
	ctx, cancel := context.WithTimeout(context.Background(), 60*time.Second)
	defer cancel()
	
	// 执行转换
	result, err := agent.Execute(ctx, query)
	if err != nil {
		t.Fatalf("执行失败: %v", err)
	}
	
	// 打印结果
	t.Logf("Query: %s\n", query)
	t.Logf("SQL: %s\n", result.GetSQL())
	t.Logf("Explanation: %s\n", result.GetExplanation())
	t.Logf("Steps: %d\n", len(result.GetSteps()))
	t.Logf("Is Ambiguous: %v\n", result.GetIsAmbiguous())
	
	// 检查是否生成了SQL
	if result.GetSQL() == "" {
		t.Errorf("未生成SQL")
	}
}

// 创建测试数据库Schema
func createTestSchema() *dbmodel.DatabaseSchema {
	schema := &dbmodel.DatabaseSchema{
		Tables: []dbmodel.Table{
			{
				Name: "employees",
				Columns: []dbmodel.Column{
					{Name: "id", Type: "INTEGER", IsPrimary: true},
					{Name: "name", Type: "VARCHAR(100)"},
					{Name: "department_id", Type: "INTEGER", IsForeign: true},
					{Name: "salary", Type: "NUMERIC(10, 2)"},
					{Name: "hire_date", Type: "DATE"},
				},
			},
			{
				Name: "departments",
				Columns: []dbmodel.Column{
					{Name: "id", Type: "INTEGER", IsPrimary: true},
					{Name: "name", Type: "VARCHAR(100)"},
					{Name: "location", Type: "VARCHAR(100)"},
				},
			},
		},
	}
	
	return schema
}

// TestAmbiguousQueryDetection 测试模糊查询检测功能
func TestAmbiguousQueryDetection(t *testing.T) {
	// 跳过测试，除非显式启用
	t.Skip("跳过长时间运行测试，除非显式启用")
	
	// 创建LLM实例
	llm, err := openai.New(openai.WithModel("gpt-3.5-turbo"))
	if err != nil {
		t.Fatalf("创建LLM失败: %v", err)
	}
	
	// 创建简单的测试数据库Schema
	schema := createTestSchema()
	
	// 创建工具注册表
	toolRegistry := tools.NewToolRegistry()
	
	// 注册标准工具
	tools.RegisterStandardTools(toolRegistry, llm)
	
	// 创建Text2SQL Agent
	agent := react.NewText2SQLAgent(react.Text2SQLConfig{
LLM:         llm,
DBSchema:    schema,
DBName:      "hr",
DBType:      "postgres",
MaxSteps:    10,
Interactive: false,
})
	
	// 设置工具
	agent.SetTools(toolRegistry)
	
	// 设置模糊查询
	query := "获取特定员工的薪资"
	
	// 创建上下文
	ctx, cancel := context.WithTimeout(context.Background(), 60*time.Second)
	defer cancel()
	
	// 执行转换
	result, err := agent.Execute(ctx, query)
	if err != nil {
		t.Fatalf("执行失败: %v", err)
	}
	
	// 打印结果
	t.Logf("Query: %s\n", query)
	t.Logf("SQL: %s\n", result.GetSQL())
	t.Logf("Is Ambiguous: %v\n", result.GetIsAmbiguous())
	
	// 检查是否检测到模糊查询
	if !result.GetIsAmbiguous() {
		t.Errorf("未检测到模糊查询")
	}
	
	// 打印执行步骤
	for i, step := range result.GetSteps() {
		t.Logf("Step %d:\n", i+1)
		t.Logf("  Thought: %s\n", step.Thought)
		if step.Action != nil {
			t.Logf("  Action: %s\n", step.Action.Tool)
			t.Logf("  Observation: %s\n", step.Observation)
		}
	}
}
