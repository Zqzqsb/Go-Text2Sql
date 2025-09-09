package tools

import (
	"context"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// SQLGeneratorTool 提供SQL生成能力
type SQLGeneratorTool struct {
	llm         llms.Model
	maxResults  int
}

// NewSQLGeneratorTool 创建SQL生成工具
func NewSQLGeneratorTool(llm llms.Model) *SQLGeneratorTool {
	return &SQLGeneratorTool{
		llm:        llm,
		maxResults: 100, // 默认限制
	}
}

// Name 返回工具名称
func (t *SQLGeneratorTool) Name() string {
	return "generate_sql"
}

// Description 返回工具描述
func (t *SQLGeneratorTool) Description() string {
	return "根据用户查询和数据库结构生成SQL查询语句"
}

// ParameterSchema 返回参数schema
func (t *SQLGeneratorTool) ParameterSchema() map[string]string {
	return map[string]string{
		"query": "用户自然语言查询",
		"db_type": "数据库类型(如postgres, sqlite)",
		"relevant_tables": "可选，与查询相关的表名列表，JSON格式",
		"result_limit": "可选，限制结果数量",
	}
}

// Execute 执行工具
func (t *SQLGeneratorTool) Execute(ctx context.Context, params map[string]interface{}) (string, error) {
	// 获取参数
	queryParam, ok := params["query"]
	if !ok {
		return "", fmt.Errorf("缺少查询参数")
	}
	
	query, ok := queryParam.(string)
	if !ok {
		return "", fmt.Errorf("查询参数必须是字符串")
	}
	
	// 获取数据库类型
	dbType := "postgres" // 默认
	if dbTypeParam, ok := params["db_type"]; ok {
		if dbTypeStr, ok := dbTypeParam.(string); ok {
			dbType = dbTypeStr
		}
	}
	
	// 获取结果限制
	resultLimit := t.maxResults
	if limitParam, ok := params["result_limit"]; ok {
		if limit, ok := limitParam.(int); ok {
			resultLimit = limit
		} else if limitStr, ok := limitParam.(string); ok {
			// 尝试将字符串转换为整数
			if _, err := fmt.Sscanf(limitStr, "%d", &resultLimit); err != nil {
				// 转换失败，使用默认值
				resultLimit = t.maxResults
			}
		}
	}
	
	// 获取数据库Schema
	dbSchema, err := t.getSchemaFromState(params)
	if err != nil {
		return "", err
	}
	
	// 相关表信息（可选）
	relevantTables := ""
	if tablesParam, ok := params["relevant_tables"]; ok {
		if tablesStr, ok := tablesParam.(string); ok {
			relevantTables = tablesStr
		}
	}
	
	// 生成SQL
	sql, explanation, err := t.generateSQL(ctx, query, dbSchema, dbType, relevantTables, resultLimit)
	if err != nil {
		return "", err
	}
	
	// 构建响应
	response := fmt.Sprintf("生成的SQL:\n```sql\n%s\n```\n\n解释:\n%s", sql, explanation)
	return response, nil
}

// getSchemaFromState 从状态中获取Schema
func (t *SQLGeneratorTool) getSchemaFromState(params map[string]interface{}) (*dbmodel.DatabaseSchema, error) {
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

// generateSQL 使用LLM生成SQL
func (t *SQLGeneratorTool) generateSQL(ctx context.Context, query string, schema *dbmodel.DatabaseSchema, dbType, relevantTables string, limit int) (string, string, error) {
	// 将Schema格式化为字符串
	schemaStr := formatSchema(schema)
	
	template := `
您是一位专业的SQL开发者，请根据用户的自然语言查询和数据库结构，生成一个正确且高效的SQL查询语句。

数据库类型: %s
数据库结构:
%s

相关表信息(如果有):
%s

查询限制: %d

用户查询:
%s

<think>
请按照以下步骤思考:
1. 理解用户查询的意图和需求
2. 确定需要查询的表和字段
3. 确定WHERE子句的过滤条件
4. 确定是否需要JOIN操作
5. 确定是否需要GROUP BY, HAVING, ORDER BY等操作
6. 考虑性能和可读性
</think>

请提供符合以下要求的SQL:
- 符合%s语法
- 字段和表名使用正确的引用方式
- 使用清晰的别名和格式
- 处理可能的NULL值
- 限制结果数量不超过%d行

SQL应以标准SQL格式输出，不要包含其他内容。查询后需提供简要解释说明SQL的工作原理。
`
	
	// 填充模板
	prompt := fmt.Sprintf(
		template, 
		dbType, 
		schemaStr, 
		relevantTables,
		limit,
		query,
		dbType,
		limit,
	)
	
	// 调用LLM
	response, err := t.llm.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return "", "", fmt.Errorf("LLM调用失败: %v", err)
	}
	
	// 解析SQL和解释
	sql, explanation := extractSQLAndExplanation(response)
	return sql, explanation, nil
}

// extractSQLAndExplanation 从LLM响应中提取SQL和解释
func extractSQLAndExplanation(response string) (string, string) {
	parts := strings.Split(response, "```")
	
	// 尝试找到SQL代码块
	var sql string
	if len(parts) >= 3 {
		// 常见格式是 文本 ```sql 代码 ``` 解释
		for i := 1; i < len(parts); i += 2 {
			code := strings.TrimSpace(parts[i])
			if strings.HasPrefix(code, "sql") {
				sql = strings.TrimSpace(strings.TrimPrefix(code, "sql"))
				break
			} else if !strings.ContainsAny(code, "\n\r") {
				// 跳过只有语言标记的部分
				continue
			} else {
				// 可能没有指定语言
				sql = code
				break
			}
		}
	}
	
	// 提取解释（通常在SQL代码块之后）
	var explanation string
	if sql != "" {
		// 找到SQL后的文本
		for i, part := range parts {
			if strings.Contains(part, sql) && i+1 < len(parts) {
				explanation = strings.TrimSpace(parts[i+1])
				break
			}
		}
	}
	
	// 如果没有找到解释，可能SQL和解释没有用代码块分隔
	if explanation == "" && sql == "" {
		// 尝试基于常见分隔符分离
		lines := strings.Split(response, "\n")
		
		sqlStart := -1
		explanationStart := -1
		
		for i, line := range lines {
			line = strings.TrimSpace(line)
			
			if sqlStart < 0 && (strings.HasPrefix(line, "SELECT") || 
				strings.HasPrefix(line, "WITH") || 
				strings.HasPrefix(line, "INSERT") || 
				strings.HasPrefix(line, "UPDATE") || 
				strings.HasPrefix(line, "DELETE")) {
				sqlStart = i
			}
			
			if sqlStart >= 0 && explanationStart < 0 && 
				(strings.HasPrefix(line, "解释:") || 
				strings.HasPrefix(line, "说明:") || 
				strings.HasPrefix(line, "这个SQL") || 
				strings.HasPrefix(line, "这条SQL") ||
				strings.HasPrefix(line, "解释：") ||
				strings.HasPrefix(line, "说明：")) {
				explanationStart = i
				break
			}
		}
		
		if sqlStart >= 0 {
			if explanationStart > sqlStart {
				sql = strings.Join(lines[sqlStart:explanationStart], "\n")
				explanation = strings.Join(lines[explanationStart:], "\n")
			} else {
				sql = strings.Join(lines[sqlStart:], "\n")
			}
		}
	}
	
	return sql, explanation
}
