package tools

import (
	"context"
	"fmt"
	"regexp"
	"strings"

	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// FieldMapping 表示查询字段和数据库字段之间的映射
type FieldMapping struct {
	QueryField   string   // 用户查询中的字段
	DbTable      string   // 数据库表
	DbField      string   // 数据库字段
	Confidence   float64  // 置信度(0-1)
	IsAmbiguous  bool     // 是否模糊
	Alternatives []string // 替代映射
}

// FieldAlignerTool 提供字段对齐功能
type FieldAlignerTool struct {
	llm llms.Model
}

// NewFieldAlignerTool 创建字段对齐工具
func NewFieldAlignerTool(llm llms.Model) *FieldAlignerTool {
	return &FieldAlignerTool{
		llm: llm,
	}
}

// Name 返回工具名称
func (t *FieldAlignerTool) Name() string {
	return "align_fields"
}

// Description 返回工具描述
func (t *FieldAlignerTool) Description() string {
	return "将用户查询中的字段与数据库字段进行对齐和映射"
}

// ParameterSchema 返回参数schema
func (t *FieldAlignerTool) ParameterSchema() map[string]string {
	return map[string]string{
		"query": "用户的原始查询",
		"sql": "已生成的SQL语句",
	}
}

// Execute 执行工具
func (t *FieldAlignerTool) Execute(ctx context.Context, params map[string]interface{}) (string, error) {
	// 获取参数
	queryParam, ok := params["query"]
	if !ok {
		return "", fmt.Errorf("缺少查询参数")
	}
	
	query, ok := queryParam.(string)
	if !ok {
		return "", fmt.Errorf("查询参数必须是字符串")
	}
	
	sqlParam, ok := params["sql"]
	if !ok {
		return "", fmt.Errorf("缺少SQL参数")
	}
	
	sql, ok := sqlParam.(string)
	if !ok {
		return "", fmt.Errorf("SQL参数必须是字符串")
	}
	
	// 获取数据库Schema
	dbSchema, err := t.getSchemaFromState(params)
	if err != nil {
		return "", err
	}
	
	// 提取查询字段
	queryFields := extractQueryFields(query)
	
	// 提取SQL字段
	sqlFields := extractSQLFields(sql)
	
	// 对齐字段
	mappings, err := t.alignFields(ctx, query, sql, dbSchema, queryFields, sqlFields)
	if err != nil {
		return "", err
	}
	
	// 根据字段映射改进SQL
	improvedSQL, err := t.improveSQLWithLLM(ctx, sql, dbSchema, mappings)
	if err != nil {
		return "", fmt.Errorf("改进SQL失败: %v", err)
	}
	
	// 格式化响应
	response := formatFieldAlignmentResponse(mappings, improvedSQL)
	
	return response, nil
}

// getSchemaFromState 从状态中获取Schema
func (t *FieldAlignerTool) getSchemaFromState(params map[string]interface{}) (*dbmodel.DatabaseSchema, error) {
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

// extractQueryFields 从查询中提取潜在字段
func extractQueryFields(query string) []string {
	// 简化版实现，使用一些启发式规则提取可能的字段
	fields := make([]string, 0)
	
	// 分割查询为单词
	words := strings.Fields(strings.ToLower(query))
	
	// 过滤掉常见停用词
	stopwords := map[string]bool{
		"the": true, "a": true, "an": true, "in": true, "on": true, 
		"at": true, "by": true, "for": true, "with": true, 
		"about": true, "from": true, "to": true, "of": true, 
		"show": true, "find": true, "list": true, "get": true, 
		"select": true, "where": true, "how": true, "many": true,
		"much": true, "and": true, "or": true, "is": true, "are": true,
	}
	
	for _, word := range words {
		// 移除标点
		word = strings.Trim(word, ",.?!:;()")
		
		// 跳过停用词和短词
		if !stopwords[word] && len(word) > 2 {
			// 检查是否是多词短语（例如"first_name"）
			if strings.Contains(word, "_") {
				fields = append(fields, word)
			} else {
				// 检查是否可能是短语的一部分
				fields = append(fields, word)
			}
		}
	}
	
	return fields
}

// extractSQLFields 从SQL中提取字段
func extractSQLFields(sql string) map[string]string {
	fields := make(map[string]string) // 列 -> 表
	
	// 匹配表.列或表.*模式
	tableColRegex := regexp.MustCompile(`([a-zA-Z0-9_]+)\.([a-zA-Z0-9_*]+)`)
	matches := tableColRegex.FindAllStringSubmatch(sql, -1)
	
	for _, match := range matches {
		if len(match) > 2 {
			table := match[1]
			column := match[2]
			fields[column] = table
		}
	}
	
	// 匹配SELECT子句中的独立列名
	selectRegex := regexp.MustCompile(`(?i)SELECT\s+(.*?)\s+FROM`)
	selectMatches := selectRegex.FindStringSubmatch(sql)
	
	if len(selectMatches) > 1 {
		selectClause := selectMatches[1]
		
		if selectClause == "*" {
			fields["*"] = ""
		} else {
			// 按逗号分割
			parts := strings.Split(selectClause, ",")
			
			for _, part := range parts {
				part = strings.TrimSpace(part)
				
				// 跳过已经处理过的表.列格式
				if !strings.Contains(part, ".") {
					// 处理别名（例如"column AS alias"）
					aliasRegex := regexp.MustCompile(`([a-zA-Z0-9_]+)(\s+AS\s+|\s+)([a-zA-Z0-9_]+)`)
					aliasMatch := aliasRegex.FindStringSubmatch(part)
					
					if len(aliasMatch) > 3 {
						// 有别名
						fields[aliasMatch[1]] = ""
					} else {
						// 无别名
						fields[part] = ""
					}
				}
			}
		}
	}
	
	return fields
}

// alignFields 使用LLM对齐字段
func (t *FieldAlignerTool) alignFields(
	ctx context.Context,
	query string,
	sql string,
	schema *dbmodel.DatabaseSchema,
	queryFields []string,
	sqlFields map[string]string,
) ([]FieldMapping, error) {
	// 格式化schema为字符串
	schemaStr := formatSchema(schema)
	
	template := `
您是一个数据库专家，您的任务是将自然语言查询中的字段与数据库字段进行对齐。

数据库结构:
{{.schema}}

用户查询:
{{.query}}

生成的SQL:
{{.sql}}

用户查询中可能的字段:
{{range .query_fields}}
- {{.}}
{{end}}

SQL中使用的字段:
{{range $column, $table := .sql_fields}}
{{if eq $table ""}}
- {{$column}}
{{else}}
- {{$table}}.{{$column}}
{{end}}
{{end}}

对于查询中的每个潜在字段，确定最可能对应的数据库表和列。
如果某个字段无法确定映射，标记为未映射。
如果存在多个可能的映射，列出备选项。

请按以下格式返回分析结果:

字段: [查询字段]
表: [数据库表]
列: [数据库列]
置信度: [高/中/低]
模糊: [是/否]
备选项: [如有模糊，列出备选项，否则"无"]

为每个查询字段重复此格式。
`
	
	// 通过map传递参数
	promptParams := map[string]interface{}{
		"schema":       schemaStr,
		"query":        query,
		"sql":          sql,
		"query_fields": queryFields,
		"sql_fields":   sqlFields,
	}
	
	// 构建提示词
	prompt := renderTemplate(template, promptParams)
	
	// 调用LLM
	response, err := t.llm.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return nil, fmt.Errorf("LLM调用失败: %v", err)
	}
	
	// 解析响应
	mappings, err := parseMappingsFromResponse(response)
	if err != nil {
		return nil, fmt.Errorf("解析映射失败: %v", err)
	}
	
	return mappings, nil
}

// improveSQLWithLLM 基于字段映射改进SQL
func (t *FieldAlignerTool) improveSQLWithLLM(
	ctx context.Context,
	sql string,
	schema *dbmodel.DatabaseSchema,
	mappings []FieldMapping,
) (string, error) {
	// 只有在有映射时才尝试改进
	if len(mappings) == 0 {
		return sql, nil
	}
	
	// 格式化schema为字符串
	schemaStr := formatSchema(schema)
	
	template := `
您是一个数据库专家，您的任务是根据字段映射改进SQL查询。

数据库结构:
{{.schema}}

原始SQL:
{{.sql}}

字段映射:
{{range .mappings}}
字段: {{.QueryField}}
表: {{.DbTable}}
列: {{.DbField}}
模糊: {{if .IsAmbiguous}}是{{else}}否{{end}}
{{end}}

您的任务是改进SQL查询，基于这些字段映射。考虑:
1. 是否所有映射的字段都正确包含在SQL中？
2. 列引用是否清晰、无歧义？
3. 是否可以重写查询以提高效率或清晰度？

如果SQL已经是最佳的，请返回原始SQL。
如果可以改进，请只提供改进后的SQL。

改进的SQL:
{{.sql}}
	`
	
	// 通过map传递参数
	promptParams := map[string]interface{}{
		"schema":   schemaStr,
		"sql":      sql,
		"mappings": mappings,
	}
	
	// 构建提示词
	prompt := renderTemplate(template, promptParams)
	
	// 调用LLM
	response, err := t.llm.Call(ctx, prompt, llms.WithTemperature(0.1))
	if err != nil {
		return sql, fmt.Errorf("LLM调用失败: %v", err)
	}
	
	// 提取SQL
	improved := extractSQLFromResponse(response)
	if improved == "" {
		return sql, nil // 如果提取失败，返回原始SQL
	}
	
	return improved, nil
}

// renderTemplate 简单的模板渲染函数
func renderTemplate(tmpl string, data map[string]interface{}) string {
	result := tmpl
	
	// 替换简单变量
	for key, value := range data {
		if str, ok := value.(string); ok {
			placeholder := "{{." + key + "}}"
			result = strings.Replace(result, placeholder, str, -1)
		}
	}
	
	// 处理query_fields数组
	if queryFields, ok := data["query_fields"].([]string); ok {
		var fieldsStr string
		for _, field := range queryFields {
			fieldsStr += "- " + field + "\n"
		}
		result = strings.Replace(result, "{{range .query_fields}}\n- {{.}}\n{{end}}", fieldsStr, -1)
	}
	
	// 处理sql_fields映射
	if sqlFields, ok := data["sql_fields"].(map[string]string); ok {
		var fieldsStr string
		for column, table := range sqlFields {
			if table == "" {
				fieldsStr += "- " + column + "\n"
			} else {
				fieldsStr += "- " + table + "." + column + "\n"
			}
		}
		result = strings.Replace(result, "{{range $column, $table := .sql_fields}}\n{{if eq $table \"\"}}\n- {{$column}}\n{{else}}\n- {{$table}}.{{$column}}\n{{end}}\n{{end}}", fieldsStr, -1)
	}
	
	// 处理mappings数组
	if mappings, ok := data["mappings"].([]FieldMapping); ok {
		var mappingsStr string
		for _, mapping := range mappings {
			mappingsStr += "字段: " + mapping.QueryField + "\n"
			mappingsStr += "表: " + mapping.DbTable + "\n"
			mappingsStr += "列: " + mapping.DbField + "\n"
			if mapping.IsAmbiguous {
				mappingsStr += "模糊: 是\n"
			} else {
				mappingsStr += "模糊: 否\n"
			}
			mappingsStr += "\n"
		}
		result = strings.Replace(result, "{{range .mappings}}\n字段: {{.QueryField}}\n表: {{.DbTable}}\n列: {{.DbField}}\n模糊: {{if .IsAmbiguous}}是{{else}}否{{end}}\n{{end}}", mappingsStr, -1)
	}
	
	return result
}

// parseMappingsFromResponse 从LLM响应中解析字段映射
func parseMappingsFromResponse(response string) ([]FieldMapping, error) {
	mappings := make([]FieldMapping, 0)
	
	// 按字段部分分割响应
	fieldSections := strings.Split(response, "字段:")
	
	// 跳过第一部分（前言）
	for i := 1; i < len(fieldSections); i++ {
		section := strings.TrimSpace(fieldSections[i])
		if section == "" {
			continue
		}
		
		// 解析单个映射
		mapping := FieldMapping{
			Confidence:   0.5, // 默认中等置信度
			Alternatives: make([]string, 0),
		}
		
		// 提取查询字段
		lines := strings.Split(section, "\n")
		if len(lines) > 0 {
			mapping.QueryField = strings.TrimSpace(lines[0])
		}
		
		// 提取其他字段
		for _, line := range lines {
			line = strings.TrimSpace(line)
			
			if strings.HasPrefix(line, "表:") {
				mapping.DbTable = strings.TrimSpace(strings.TrimPrefix(line, "表:"))
			} else if strings.HasPrefix(line, "列:") {
				mapping.DbField = strings.TrimSpace(strings.TrimPrefix(line, "列:"))
			} else if strings.HasPrefix(line, "置信度:") {
				confidenceStr := strings.TrimSpace(strings.TrimPrefix(line, "置信度:"))
				switch strings.ToLower(confidenceStr) {
				case "高":
					mapping.Confidence = 0.9
				case "中":
					mapping.Confidence = 0.6
				case "低":
					mapping.Confidence = 0.3
				}
			} else if strings.HasPrefix(line, "模糊:") {
				ambiguousStr := strings.TrimSpace(strings.TrimPrefix(line, "模糊:"))
				mapping.IsAmbiguous = strings.ToLower(ambiguousStr) == "是"
			} else if strings.HasPrefix(line, "备选项:") {
				altsStr := strings.TrimSpace(strings.TrimPrefix(line, "备选项:"))
				if strings.ToLower(altsStr) != "无" {
					alts := strings.Split(altsStr, ",")
					for _, alt := range alts {
						if alt = strings.TrimSpace(alt); alt != "" {
							mapping.Alternatives = append(mapping.Alternatives, alt)
						}
					}
				}
			}
		}
		
		mappings = append(mappings, mapping)
	}
	
	return mappings, nil
}

// extractSQLFromResponse 从响应中提取SQL
func extractSQLFromResponse(response string) string {
	// 尝试提取SQL代码块之间的内容
	sqlRegex := regexp.MustCompile("(?s)```sql\\s*(.+?)\\s*```")
	matches := sqlRegex.FindStringSubmatch(response)
	
	if len(matches) > 1 {
		return strings.TrimSpace(matches[1])
	}
	
	// 尝试没有语言说明符的格式
	altRegex := regexp.MustCompile("(?s)```\\s*(.+?)\\s*```")
	altMatches := altRegex.FindStringSubmatch(response)
	
	if len(altMatches) > 1 {
		return strings.TrimSpace(altMatches[1])
	}
	
	return ""
}

// formatFieldAlignmentResponse 格式化字段对齐响应
func formatFieldAlignmentResponse(mappings []FieldMapping, improvedSQL string) string {
	var response strings.Builder
	
	// 添加字段映射部分
	response.WriteString("### 字段映射\n\n")
	
	for _, mapping := range mappings {
		response.WriteString(fmt.Sprintf("- 查询字段: %s\n", mapping.QueryField))
		
		if mapping.DbField != "" {
			response.WriteString(fmt.Sprintf("  - 映射到: %s.%s\n", mapping.DbTable, mapping.DbField))
			response.WriteString(fmt.Sprintf("  - 置信度: %.1f\n", mapping.Confidence))
			
			if mapping.IsAmbiguous {
				response.WriteString("  - 注意: 此映射有歧义\n")
				if len(mapping.Alternatives) > 0 {
					response.WriteString(fmt.Sprintf("  - 备选项: %s\n", strings.Join(mapping.Alternatives, ", ")))
				}
			}
		} else {
			response.WriteString("  - 未找到映射\n")
		}
		
		response.WriteString("\n")
	}
	
	// 添加改进SQL部分
	response.WriteString("### SQL改进\n\n")
	
	if improvedSQL != "" && improvedSQL != "" {
		response.WriteString("改进后的SQL:\n")
		response.WriteString("```sql\n")
		response.WriteString(improvedSQL)
		response.WriteString("\n```\n")
	} else {
		response.WriteString("SQL无需改进。\n")
	}
	
	return response.String()
}
