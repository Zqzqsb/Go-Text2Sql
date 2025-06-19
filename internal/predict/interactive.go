package predict

import (
	"encoding/json"
	"fmt"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/zqzqsb/gosql/internal/database"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
	"github.com/zqzqsb/gosql/pkg/utils"
)

const (
	MaxInteractiveSteps = 5 // 最大交互步骤数
)

// InteractiveGenerator 交互式 SQL 生成器
type InteractiveGenerator struct {
	client       llm.LLM
	executor     *database.DBExecutor
	maxQueryRows int  // 最大返回行数，遵循最小必要原则
	expandSchema bool // 是否在日志中展开显示schema
}

// NewInteractiveGenerator 创建新的交互式生成器
func NewInteractiveGenerator(client llm.LLM, maxQueryRows int) *InteractiveGenerator {
	if maxQueryRows <= 0 {
		maxQueryRows = 10 // 默认值
	}
	return &InteractiveGenerator{
		client:       client,
		executor:     database.NewDBExecutor(),
		maxQueryRows: maxQueryRows,
		expandSchema: false, // 默认不展开
	}
}

// SetExpandSchema 设置是否展开显示schema
func (g *InteractiveGenerator) SetExpandSchema(expand bool) {
	g.expandSchema = expand
}

// GenerateInteractiveSQL 交互式生成 SQL
func (g *InteractiveGenerator) GenerateInteractiveSQL(
	ds *dataset.Dataset,
	example map[string]interface{},
	options llm.Options,
	dbType string,
) InteractiveResult {

	// 提取基本信息
	id := GetExampleID(example)
	dbID, _ := example["db_id"].(string)
	question, _ := example["question"].(string)
	gtSQL, _ := example["query"].(string)

	fmt.Printf("\n" + strings.Repeat("=", 80) + "\n")
	fmt.Printf("🔄 开始处理问题 ID: %d (数据库: %s)\n", id, dbID)
	fmt.Printf("❓ 问题: %s\n", question)
	fmt.Printf("📄 标准SQL: %s\n", gtSQL)
	fmt.Printf(strings.Repeat("=", 80) + "\n")

	result := InteractiveResult{
		SQLResult: SQLResult{
			ID:        id,
			DBName:    dbID,
			Question:  question,
			GTSQL:     gtSQL,
			Ambiguous: "False", // 已经在main.go中检测过，确认不是模糊查询
		},
		Steps:         make([]InteractiveStep, 0),
		IsInteractive: false,
	}

	// 加载数据库 Schema
	dbPath := filepath.Join(ds.BaseDir, ds.DBDir, dbID)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		fmt.Printf("❌ 错误: 加载数据库Schema失败: %v\n", err)
		result.PredSQL = "ERROR: 加载数据库Schema失败"
		return result
	}

	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)

	// 提取字段信息
	fieldsInfo := utils.ExtractFieldsInfo(example, options.FieldsInfoType)

	// 输出字段信息使用情况
	if fieldsInfo.HasInfo {
		fmt.Printf("🏷️  使用字段%s: %s\n",
			map[bool]string{true: "描述", false: "列表"}[fieldsInfo.UseDescription],
			fieldsInfo.Info)
	}

	// 第一步：询问 LLM 是否需要查询数据库
	initialPrompt := g.buildInitialPrompt(question, schemaPrompt, fieldsInfo, dbType)

	fmt.Printf("🚀 开始交互式 SQL 生成...\n")
	fmt.Printf("📋 数据库Schema已加载，包含 %d 个表\n", len(dbSchema.Tables))

	queryHistory := ""
	stepCount := 0

	for stepCount < MaxInteractiveSteps {
		stepCount++
		fmt.Printf("\n" + strings.Repeat("-", 60) + "\n")
		fmt.Printf("🔄 第 %d 步 (最多 %d 步)\n", stepCount, MaxInteractiveSteps)

		// 构建当前步骤的提示
		currentPrompt := initialPrompt
		if queryHistory != "" {
			currentPrompt += "\n\n之前的查询历史:\n" + queryHistory
		}

		fmt.Printf("📝 即将发送给LLM的Prompt:\n")
		fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 58) + strings.Repeat("┐", 1) + "\n")
		// 为了避免过长的输出，只显示prompt的关键部分
		promptLines := strings.Split(currentPrompt, "\n")
		if !g.expandSchema && len(promptLines) > 20 {
			for i := 0; i < 10; i++ {
				fmt.Printf("│ %s\n", promptLines[i])
			}
			fmt.Printf("│ ... (省略 %d 行) ...\n", len(promptLines)-20)
			for i := len(promptLines) - 10; i < len(promptLines); i++ {
				fmt.Printf("│ %s\n", promptLines[i])
			}
		} else {
			for _, line := range promptLines {
				fmt.Printf("│ %s\n", line)
			}
		}
		fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 58) + strings.Repeat("┘", 1) + "\n")

		// 询问 LLM 下一步动作
		fmt.Printf("🤖 正在请求LLM响应...\n")
		response, err := g.client.GenerateText(currentPrompt, options)
		if err != nil {
			fmt.Printf("❌ LLM 请求失败: %v\n", err)
			result.PredSQL = "ERROR: LLM 请求失败"
			return result
		}

		fmt.Printf("✅ LLM响应已收到:\n")
		fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 58) + strings.Repeat("┐", 1) + "\n")
		responseLines := strings.Split(response, "\n")
		for _, line := range responseLines {
			fmt.Printf("│ %s\n", line)
		}
		fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 58) + strings.Repeat("┘", 1) + "\n")

		// 解析 LLM 响应
		queryReq, isFinal := g.parseLLMResponse(response)

		if isFinal {
			// LLM 认为可以直接生成最终 SQL
			finalSQL := g.extractFinalSQL(response)
			result.PredSQL = finalSQL
			result.Thinking = response

			fmt.Printf("🎯 LLM认为可以直接生成最终SQL:\n")
			fmt.Printf("📄 最终SQL: %s\n", finalSQL)

			// 记录最终步骤
			result.Steps = append(result.Steps, InteractiveStep{
				StepType:  "final",
				Reasoning: response,
			})

			break
		}

		if queryReq.SQL == "" {
			// 无法解析出有效的查询，尝试直接生成最终 SQL
			fmt.Printf("⚠️  无法解析查询请求，直接生成最终 SQL\n")
			finalPrompt := g.buildFinalPrompt(question, schemaPrompt, queryHistory, fieldsInfo, dbType)

			fmt.Printf("📝 最终SQL生成Prompt:\n")
			fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 58) + strings.Repeat("┐", 1) + "\n")
			finalPromptLines := strings.Split(finalPrompt, "\n")
			if !g.expandSchema && len(finalPromptLines) > 20 {
				for i := 0; i < 10; i++ {
					fmt.Printf("│ %s\n", finalPromptLines[i])
				}
				fmt.Printf("│ ... (省略 %d 行) ...\n", len(finalPromptLines)-20)
				for i := len(finalPromptLines) - 10; i < len(finalPromptLines); i++ {
					fmt.Printf("│ %s\n", finalPromptLines[i])
				}
			} else {
				for _, line := range finalPromptLines {
					fmt.Printf("│ %s\n", line)
				}
			}
			fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 58) + strings.Repeat("┘", 1) + "\n")

			finalResponse, err := g.client.GenerateSQL(finalPrompt, options)
			if err != nil {
				fmt.Printf("❌ 生成最终 SQL 失败: %v\n", err)
				result.PredSQL = "ERROR: 生成最终 SQL 失败"
			} else {
				fmt.Printf("🎯 最终SQL已生成: %s\n", finalResponse.Response)
				result.PredSQL = finalResponse.Response
				result.Thinking = finalResponse.Thinking
			}
			break
		}

		// 执行查询
		fmt.Printf("🔍 需要执行SQL查询:\n")
		fmt.Printf("📄 SQL: %s\n", queryReq.SQL)
		fmt.Printf("🤔 推理: %s\n", queryReq.Reasoning)
		fmt.Printf("🔄 是否可能需要更多查询: %t\n", queryReq.NeedMore)
		fmt.Printf("⚡ 正在执行查询...\n")

		queryResp := g.executeQuery(dbPath, queryReq.SQL)

		if queryResp.Success {
			fmt.Printf("✅ 查询执行成功!\n")
			fmt.Printf("📊 返回结果: %s\n", queryResp.Summary)
		} else {
			fmt.Printf("❌ 查询执行失败: %s\n", queryResp.Error)
		}

		// 记录查询步骤
		queryResultJSON, _ := json.Marshal(queryResp)
		result.Steps = append(result.Steps, InteractiveStep{
			StepType:    "query",
			Query:       queryReq.SQL,
			QueryResult: string(queryResultJSON),
			Reasoning:   queryReq.Reasoning,
		})

		result.IsInteractive = true
		result.QueryCount++

		// 更新查询历史
		queryHistory += fmt.Sprintf("\n查询 %d:\nSQL: %s\n推理: %s\n结果: %s\n",
			stepCount, queryReq.SQL, queryReq.Reasoning, queryResp.Summary)

		// 如果查询失败或 LLM 表示不需要更多查询，生成最终 SQL
		if !queryResp.Success || !queryReq.NeedMore {
			fmt.Printf("📋 完成查询阶段，准备生成最终 SQL\n")
			if !queryResp.Success {
				fmt.Printf("   原因: 查询执行失败\n")
			} else {
				fmt.Printf("   原因: LLM表示不需要更多查询\n")
			}

			finalPrompt := g.buildFinalPrompt(question, schemaPrompt, queryHistory, fieldsInfo, dbType)
			fmt.Printf("📝 最终SQL生成Prompt:\n")
			fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 58) + strings.Repeat("┐", 1) + "\n")
			finalPromptLines := strings.Split(finalPrompt, "\n")
			if !g.expandSchema && len(finalPromptLines) > 20 {
				for i := 0; i < 10; i++ {
					fmt.Printf("│ %s\n", finalPromptLines[i])
				}
				fmt.Printf("│ ... (省略 %d 行) ...\n", len(finalPromptLines)-20)
				for i := len(finalPromptLines) - 10; i < len(finalPromptLines); i++ {
					fmt.Printf("│ %s\n", finalPromptLines[i])
				}
			} else {
				for _, line := range finalPromptLines {
					fmt.Printf("│ %s\n", line)
				}
			}
			fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 58) + strings.Repeat("┘", 1) + "\n")

			finalResponse, err := g.client.GenerateSQL(finalPrompt, options)
			if err != nil {
				fmt.Printf("❌ 生成最终 SQL 失败: %v\n", err)
				result.PredSQL = "ERROR: 生成最终 SQL 失败"
			} else {
				fmt.Printf("🎯 最终SQL已生成: %s\n", finalResponse.Response)
				result.PredSQL = finalResponse.Response
				result.Thinking = finalResponse.Thinking
			}
			break
		}
	}

	result.TotalSteps = stepCount
	fmt.Printf("\n🏁 交互式生成完成!\n")
	fmt.Printf("📊 统计信息: 共 %d 步，%d 次查询\n", stepCount, result.QueryCount)
	fmt.Printf("📄 最终预测SQL: %s\n", result.PredSQL)
	fmt.Printf(strings.Repeat("=", 80) + "\n")

	return result
}

// buildInitialPrompt 构建初始提示
func (g *InteractiveGenerator) buildInitialPrompt(question, schema string, fieldsInfo utils.FieldsInfo, dbType string) string {
	// 确定数据库类型描述
	var dbTypeDesc string
	switch strings.ToLower(dbType) {
	case "postgres", "postgresql":
		dbTypeDesc = "PostgreSQL"
	case "sqlite":
		dbTypeDesc = "SQLite"
	default:
		dbTypeDesc = "SQL"
	}

	prompt := fmt.Sprintf(`你需要将以下问题转换为%s查询。

数据库结构:
%s

问题:
%s`, dbTypeDesc, schema, question)

	// 如果提供了字段信息，添加到提示中
	if fieldsInfo.HasInfo {
		if fieldsInfo.UseDescription {
			prompt += `

字段要求:
` + fieldsInfo.Info
		} else {
			prompt += `

返回字段:
` + fieldsInfo.Info
		}
		prompt += `

请确保返回的字段严格符合上述要求。`
	}

	prompt += fmt.Sprintf(`

选择一种响应方式：

方式1-查询数据库:
<query>
SQL: [你的查询SQL]
REASONING: [查询原因]
NEED_MORE: [true/false]
</query>

方式2-直接生成:
<final>
[最终SQL查询]
</final>

注意：每个查询最多返回%d行，最多%d次查询。`, g.maxQueryRows, MaxInteractiveSteps)

	return prompt
}

// buildFinalPrompt 构建最终 SQL 生成提示
func (g *InteractiveGenerator) buildFinalPrompt(question, schema, queryHistory string, fieldsInfo utils.FieldsInfo, dbType string) string {
	// 确定数据库类型描述
	var dbTypeDesc string
	switch strings.ToLower(dbType) {
	case "postgres", "postgresql":
		dbTypeDesc = "PostgreSQL"
	case "sqlite":
		dbTypeDesc = "SQLite"
	default:
		dbTypeDesc = "SQL"
	}

	prompt := fmt.Sprintf(`基于以下信息生成%s查询：

数据库结构:
%s

问题:
%s`, dbTypeDesc, schema, question)

	// 如果提供了字段信息，添加到提示中
	if fieldsInfo.HasInfo {
		if fieldsInfo.UseDescription {
			prompt += `

字段要求:
` + fieldsInfo.Info
		} else {
			prompt += `

返回字段:
` + fieldsInfo.Info
		}
		prompt += `

请确保返回的字段严格符合上述要求。`
	}

	if queryHistory != "" {
		prompt += "\n\n查询历史:\n" + queryHistory
	}

	prompt += `

要求：生成正确的SQL，语法正确，逻辑符合问题要求，以分号结尾。`

	return prompt
}

// parseLLMResponse 解析 LLM 响应
func (g *InteractiveGenerator) parseLLMResponse(response string) (QueryRequest, bool) {
	// 先检查是否包含最终 SQL 标签 ((?s) 使 . 匹配换行符)
	finalPattern := regexp.MustCompile(`(?s)<final>\s*(.*?)\s*</final>`)
	finalMatches := finalPattern.FindStringSubmatch(response)

	// 再检查是否包含查询标签
	queryPattern := regexp.MustCompile(`(?s)<query>\s*(.*?)\s*</query>`)
	queryMatches := queryPattern.FindStringSubmatch(response)

	// 如果同时包含两种标签，优先处理查询标签（因为这意味着LLM想先查询再生成最终SQL）
	if len(queryMatches) >= 2 {
		queryContent := queryMatches[1]

		// 提取 SQL
		sqlPattern := regexp.MustCompile(`SQL:\s*(.*?)(?:\n|REASONING:|$)`)
		sqlMatches := sqlPattern.FindStringSubmatch(queryContent)
		if len(sqlMatches) < 2 {
			return QueryRequest{}, false
		}

		// 提取推理
		reasoningPattern := regexp.MustCompile(`REASONING:\s*(.*?)(?:\n|NEED_MORE:|$)`)
		reasoningMatches := reasoningPattern.FindStringSubmatch(queryContent)
		reasoning := ""
		if len(reasoningMatches) >= 2 {
			reasoning = strings.TrimSpace(reasoningMatches[1])
		}

		// 提取是否需要更多查询
		needMorePattern := regexp.MustCompile(`NEED_MORE:\s*(true|false)`)
		needMoreMatches := needMorePattern.FindStringSubmatch(queryContent)
		needMore := true // 默认可能需要更多查询
		if len(needMoreMatches) >= 2 {
			needMore = strings.ToLower(needMoreMatches[1]) == "true"
		}

		return QueryRequest{
			SQL:       strings.TrimSpace(sqlMatches[1]),
			Reasoning: reasoning,
			NeedMore:  needMore,
		}, false
	}

	// 如果只有最终SQL标签
	if len(finalMatches) >= 2 {
		return QueryRequest{}, true
	}

	// 都没有找到有效标签
	return QueryRequest{}, false
}

// executeQuery 执行查询
func (g *InteractiveGenerator) executeQuery(dbPath, query string) QueryResponse {
	// 清理 SQL（移除可能的分号）
	query = strings.TrimSuffix(strings.TrimSpace(query), ";")

	// 执行查询
	rows, err := g.executor.ExecSQL(dbPath, query)
	if err != nil {
		return QueryResponse{
			Success: false,
			Error:   err.Error(),
			Summary: fmt.Sprintf("查询失败: %s", err.Error()),
		}
	}

	// 限制返回行数
	if len(rows) > g.maxQueryRows {
		rows = rows[:g.maxQueryRows]
	}

	// 生成摘要
	summary := g.generateQuerySummary(rows, len(rows) == g.maxQueryRows)

	return QueryResponse{
		Success: true,
		Rows:    rows,
		Summary: summary,
	}
}

// generateQuerySummary 生成查询结果摘要
func (g *InteractiveGenerator) generateQuerySummary(rows []map[string]interface{}, truncated bool) string {
	if len(rows) == 0 {
		return "查询无结果"
	}

	summary := fmt.Sprintf("查询返回 %d 行数据", len(rows))
	if truncated {
		summary += fmt.Sprintf(" (已截断到前%d行)", g.maxQueryRows)
	}

	// 添加样本数据
	if len(rows) > 0 {
		summary += "\n样本数据: "
		for i, row := range rows {
			if i >= 3 { // 最多显示3行样本
				summary += "\n..."
				break
			}
			rowStr := ""
			for key, value := range row {
				if rowStr != "" {
					rowStr += ", "
				}
				rowStr += fmt.Sprintf("%s: %v", key, value)
			}
			summary += fmt.Sprintf("\n行%d: {%s}", i+1, rowStr)
		}
	}

	return summary
}

// extractFinalSQL 从最终响应中提取 SQL
func (g *InteractiveGenerator) extractFinalSQL(response string) string {
	finalPattern := regexp.MustCompile(`(?s)<final>\s*(.*?)\s*</final>`)
	matches := finalPattern.FindStringSubmatch(response)
	if len(matches) >= 2 {
		sql := strings.TrimSpace(matches[1])
		if !strings.HasSuffix(sql, ";") {
			sql += ";"
		}
		return sql
	}

	// 如果没有找到标签，尝试提取 SELECT 语句
	lines := strings.Split(response, "\n")
	for i := len(lines) - 1; i >= 0; i-- {
		line := strings.TrimSpace(lines[i])
		if strings.HasPrefix(strings.ToUpper(line), "SELECT") {
			if !strings.HasSuffix(line, ";") {
				line += ";"
			}
			return line
		}
	}

	return "ERROR: 无法提取最终 SQL"
}
