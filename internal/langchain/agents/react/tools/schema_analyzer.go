package tools

import (
	"context"
	"fmt"

	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// SchemaAnalyzerTool 提供数据库Schema分析能力
type SchemaAnalyzerTool struct {
	llm llms.Model
}

// NewSchemaAnalyzerTool 创建Schema分析工具
func NewSchemaAnalyzerTool(llm llms.Model) *SchemaAnalyzerTool {
	return &SchemaAnalyzerTool{
		llm: llm,
	}
}

// Name 返回工具名称
func (t *SchemaAnalyzerTool) Name() string {
	return "analyze_schema"
}

// Description 返回工具描述
func (t *SchemaAnalyzerTool) Description() string {
	return "分析数据库模式，确定查询相关表和字段"
}

// ParameterSchema 返回参数schema
func (t *SchemaAnalyzerTool) ParameterSchema() map[string]string {
	return map[string]string{
		"query": "需要分析的用户查询",
		"focus": "可选，分析重点，可以是'tables'或'fields'",
	}
}

// Execute 执行工具
func (t *SchemaAnalyzerTool) Execute(ctx context.Context, params map[string]interface{}) (string, error) {
	// 获取参数
	queryParam, ok := params["query"]
	if !ok {
		return "", fmt.Errorf("缺少查询参数")
	}
	
	query, ok := queryParam.(string)
	if !ok {
		return "", fmt.Errorf("查询参数必须是字符串")
	}
	
	// 获取可选的重点参数
	focus := "all"
	if focusParam, ok := params["focus"]; ok {
		if focusStr, ok := focusParam.(string); ok {
			focus = focusStr
		}
	}
	
	// 从状态中获取数据库Schema
	dbSchema, err := t.getSchemaFromState(params)
	if err != nil {
		return "", err
	}
	
	// 准备Schema分析请求
	result, err := t.analyzeSchema(ctx, query, dbSchema, focus)
	if err != nil {
		return "", err
	}
	
	return result, nil
}

// getSchemaFromState 从状态中获取Schema
func (t *SchemaAnalyzerTool) getSchemaFromState(params map[string]interface{}) (*dbmodel.DatabaseSchema, error) {
	// 在实际调用中，Schema已经通过State传入，这里简化处理
	schemaParam, ok := params["schema"]
	if !ok {
		return nil, fmt.Errorf("缺少Schema参数")
	}
	
	schema, ok := schemaParam.(*dbmodel.DatabaseSchema)
	if !ok {
		return nil, fmt.Errorf("Schema参数类型错误")
	}
	
	return schema, nil
}

// analyzeSchema 使用LLM分析Schema
func (t *SchemaAnalyzerTool) analyzeSchema(ctx context.Context, query string, schema *dbmodel.DatabaseSchema, focus string) (string, error) {
	// 将Schema格式化为字符串
	schemaStr := formatSchema(schema)
	
	template := `
您的任务是分析用户查询并确定可能相关的数据库表和字段。

数据库Schema:
%s

用户查询:
%s

分析重点: %s

请分析这个查询，确定:
1. 查询中提到的主题或实体
2. 与这些主题相关的数据库表
3. 查询可能需要的字段

请用JSON格式回答:
{
  "relevantTopics": ["主题1", "主题2"...],
  "relevantTables": [
    {
      "name": "表名",
      "reason": "相关原因",
      "relevantFields": ["字段1", "字段2"...]
    }
  ],
  "queryIntent": "查询意图描述",
  "suggestedJoins": ["表1 JOIN 表2 ON 条件"...]
}
`
	
	prompt := fmt.Sprintf(template, schemaStr, query, focus)
	
	response, err := t.llm.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return "", fmt.Errorf("LLM调用失败: %v", err)
	}
	
	return response, nil
}

// 格式化Schema
func formatSchema(schema *dbmodel.DatabaseSchema) string {
	var result string
	
	for _, table := range schema.Tables {
		result += fmt.Sprintf("表名: %s\n", table.Name)
		result += "列:\n"
		
		for _, column := range table.Columns {
			// 添加列信息
			pkStr := ""
			if column.IsPrimary {
				pkStr = "(主键)"
			}
			
			fkStr := ""
			if column.IsForeign {
				fkStr = "(外键)"
			}
			
			result += fmt.Sprintf("  - %s: %s %s %s\n", 
				column.Name, column.Type, pkStr, fkStr)
		}
		
		result += "\n"
	}
	
	return result
}
