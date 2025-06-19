package predict

import (
	"encoding/json"
	"fmt"
	"path/filepath"
	"regexp"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/database"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
	"github.com/zqzqsb/gosql/pkg/utils"
)

const (
	MaxInteractiveSteps = 5                // 最大交互步骤数
	MaxRetryAttempts    = 3                // 最大重试次数
	InitialRetryDelay   = 2 * time.Second  // 初始重试延迟
	MaxRetryDelay       = 30 * time.Second // 最大重试延迟
)

// InteractiveGenerator 交互式 SQL 生成器
type InteractiveGenerator struct {
	client       llm.LLM
	executor     *database.DBExecutor
	maxQueryRows int  // 最大返回行数，遵循最小必要原则
	expandSchema bool // 是否在日志中展开显示schema

	// 重试配置
	maxRetryAttempts int           // 最大重试次数
	initialDelay     time.Duration // 初始重试延迟
	maxDelay         time.Duration // 最大重试延迟
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

		// 默认重试配置
		maxRetryAttempts: MaxRetryAttempts,
		initialDelay:     InitialRetryDelay,
		maxDelay:         MaxRetryDelay,
	}
}

// SetExpandSchema 设置是否展开显示schema
func (g *InteractiveGenerator) SetExpandSchema(expand bool) {
	g.expandSchema = expand
}

// SetRetryConfig 设置重试配置
func (g *InteractiveGenerator) SetRetryConfig(maxAttempts int, initialDelay, maxDelay time.Duration) {
	if maxAttempts > 0 {
		g.maxRetryAttempts = maxAttempts
	}
	if initialDelay > 0 {
		g.initialDelay = initialDelay
	}
	if maxDelay > 0 {
		g.maxDelay = maxDelay
	}
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

	// 统一使用 buildPrompt 函数

	fmt.Printf("🚀 开始交互式 SQL 生成...\n")
	fmt.Printf("📋 数据库Schema已加载，包含 %d 个表\n", len(dbSchema.Tables))

	queryHistory := ""
	stepCount := 0

	for stepCount < MaxInteractiveSteps {
		stepCount++
		fmt.Printf("\n" + strings.Repeat("-", 60) + "\n")
		fmt.Printf("🔄 第 %d 步 (最多 %d 步)\n", stepCount, MaxInteractiveSteps)

		// 构建当前步骤的提示
		currentPrompt := g.buildPrompt(question, schemaPrompt, queryHistory, fieldsInfo, dbType, stepCount, MaxInteractiveSteps)

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
		response, err := g.retryLLMGenerateText(currentPrompt, options)
		if err != nil {
			fmt.Printf("❌ LLM 请求最终失败: %v\n", err)
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
			finalPrompt := g.buildPrompt(question, schemaPrompt, queryHistory, fieldsInfo, dbType, MaxInteractiveSteps, MaxInteractiveSteps)

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

			finalResponse, err := g.retryLLMGenerateSQL(finalPrompt, options)
			if err != nil {
				fmt.Printf("❌ 生成最终 SQL 最终失败: %v\n", err)
				result.PredSQL = "ERROR: 生成最终 SQL 失败"
			} else {
				fmt.Printf("🎯 最终SQL已生成:\n")
				fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 78) + strings.Repeat("┐", 1) + "\n")
				sqlLines := strings.Split(finalResponse.Response, "\n")
				for _, line := range sqlLines {
					fmt.Printf("│ %s\n", line)
				}
				fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 78) + strings.Repeat("┘", 1) + "\n")
				result.PredSQL = finalResponse.Response
				result.Thinking = finalResponse.Thinking
			}
			break
		}

		// 执行查询
		fmt.Printf("🔍 需要执行SQL查询:\n")
		fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 78) + strings.Repeat("┐", 1) + "\n")
		fmt.Printf("│ 📄 SQL: %s\n", queryReq.SQL)
		fmt.Printf("│ 🤔 推理: %s\n", queryReq.Reasoning)
		fmt.Printf("│ 🔄 是否可能需要更多查询: %t\n", queryReq.NeedMore)
		fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 78) + strings.Repeat("┘", 1) + "\n")
		fmt.Printf("⚡ 正在执行查询...\n")

		queryResp := g.executeQuery(dbPath, queryReq.SQL)

		if queryResp.Success {
			fmt.Printf("✅ 查询执行成功!\n")
			fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 78) + strings.Repeat("┐", 1) + "\n")
			// 对于多行结果，每行单独显示
			summaryLines := strings.Split(queryResp.Summary, "\n")
			for _, line := range summaryLines {
				fmt.Printf("│ %s\n", line)
			}
			fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 78) + strings.Repeat("┘", 1) + "\n")
		} else {
			fmt.Printf("❌ 查询执行失败:\n")
			fmt.Printf(strings.Repeat("┌", 1) + strings.Repeat("─", 78) + strings.Repeat("┐", 1) + "\n")
			fmt.Printf("│ ❌ 错误: %s\n", queryResp.Error)
			fmt.Printf(strings.Repeat("└", 1) + strings.Repeat("─", 78) + strings.Repeat("┘", 1) + "\n")
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
		queryHistory += fmt.Sprintf("\n=== 查询 %d ===\nSQL: %s\n推理: %s\n执行结果: %s\n状态: %s\n",
			stepCount, queryReq.SQL, queryReq.Reasoning, queryResp.Summary,
			map[bool]string{true: "成功", false: "失败"}[queryResp.Success])

		// 如果查询失败或 LLM 表示不需要更多查询，退出循环让下次迭代处理
		if !queryResp.Success || !queryReq.NeedMore {
			fmt.Printf("📋 查询阶段结束\n")
			if !queryResp.Success {
				fmt.Printf("   原因: 查询执行失败\n")
			} else {
				fmt.Printf("   原因: LLM表示不需要更多查询\n")
			}
			// 不直接break，让下次迭代的buildPrompt自动处理为最终SQL生成
		}
	}

	result.TotalSteps = stepCount
	fmt.Printf("\n🏁 交互式生成完成!\n")
	fmt.Printf("📊 统计信息: 共 %d 步，%d 次查询\n", stepCount, result.QueryCount)
	fmt.Printf(strings.Repeat("=", 80) + "\n")

	return result
}

// buildPrompt 构建统一的提示词
func (g *InteractiveGenerator) buildPrompt(question, schema, queryHistory string, fieldsInfo utils.FieldsInfo, dbType string, currentStep, totalSteps int) string {
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

	prompt := fmt.Sprintf(`你需要将以下问题转换为符合%s语法的查询。

数据库结构:
%s

问题:
%s`, dbTypeDesc, schema, question)
	// 添加查询历史（如果有）
	if queryHistory != "" {
		prompt += "\n\n查询历史:\n" + queryHistory
	}

	// 添加当前状态信息
	prompt += fmt.Sprintf(`

当前状态: 第%d步 / 最多%d步`, currentStep, totalSteps)

	isLastStep := currentStep >= totalSteps

	if isLastStep {
		// 最后一步，必须生成最终SQL
		prompt += `

⚠️ 这是最后一步，必须直接生成最终SQL，不能再进行查询！按照格式要求，在标签中给出最终 sql ，不需要其他信息

<final>
[最终SQL查询]
</final>`

		if queryHistory != "" {
			prompt += `

基于上述查询历史，综合所有查询结果生成最终SQL。`
		} else {
			prompt += `

基于数据库结构直接生成SQL。`
		}
	} else {
		// 还可以继续查询
		remainingSteps := totalSteps - currentStep
		prompt += fmt.Sprintf(`，还可以进行%d步。

选择一种响应方式,每次只能返回一对<query/>或者<final/>标签,不能在一次 query 中要求执行多个 sql：

方式1-查询数据库(推荐渐进式探索):
<query>
SQL: [你的查询SQL]
REASONING: [查询原因]
NEED_MORE: [true/false]
</query>

方式2-直接生成:
<final>
[最终SQL查询]
</final>

**强烈建议使用渐进式查询策略：**
1. 优先使用简单的探索性查询，例如：
   - 查看表的结构和样本数据: SELECT * FROM 表名 LIMIT 30
   - 了解字段的取值范围: SELECT DISTINCT 字段名 FROM 表名 LIMIT 50
   - 检查数据分布: SELECT COUNT(*) FROM 表名 WHERE 条件
2. 基于每次查询结果逐步构建更复杂的查询
3. 确认关键信息后再生成最终SQL

注意：每个<query/>查询最多返回%d行,<final/> sql 不受此限制(一定不要为最终 sql 添加 LIMIT 限制，除非问题里明确要求)。`, remainingSteps, g.maxQueryRows)
	}

	prompt += `

要求：生成正确的SQL，语法正确，逻辑符合问题要求，以分号结尾。`

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
		
请确保返回的字段严格符合上述要求,**不多字段也不少字段**。
对于你返回的每个字段，都需要一个贴合语义的别名，所有字段不能够有相同的别名`
	}
	return prompt
}

// retryLLMGenerateText 带重试的文本生成
func (g *InteractiveGenerator) retryLLMGenerateText(prompt string, options llm.Options) (string, error) {
	var lastErr error
	delay := g.initialDelay

	for attempt := 1; attempt <= g.maxRetryAttempts; attempt++ {
		if attempt > 1 {
			fmt.Printf("🔄 第 %d 次重试LLM请求，等待 %.1f 秒...\n", attempt-1, delay.Seconds())
			time.Sleep(delay)
		}

		fmt.Printf("🤖 正在请求LLM响应... (尝试 %d/%d)\n", attempt, g.maxRetryAttempts)
		response, err := g.client.GenerateText(prompt, options)

		if err == nil {
			if attempt > 1 {
				fmt.Printf("✅ LLM重试成功！\n")
			}
			return response, nil
		}

		lastErr = err
		fmt.Printf("❌ LLM请求失败 (尝试 %d/%d): %v\n", attempt, g.maxRetryAttempts, err)

		// 指数退避，但不超过最大延迟
		delay = time.Duration(float64(delay) * 1.5)
		if delay > g.maxDelay {
			delay = g.maxDelay
		}
	}

	return "", fmt.Errorf("LLM请求在 %d 次尝试后失败: %v", g.maxRetryAttempts, lastErr)
}

// retryLLMGenerateSQL 带重试的SQL生成
func (g *InteractiveGenerator) retryLLMGenerateSQL(prompt string, options llm.Options) (*llm.SQLResponse, error) {
	var lastErr error
	delay := g.initialDelay

	for attempt := 1; attempt <= g.maxRetryAttempts; attempt++ {
		if attempt > 1 {
			fmt.Printf("🔄 第 %d 次重试LLM SQL生成，等待 %.1f 秒...\n", attempt-1, delay.Seconds())
			time.Sleep(delay)
		}

		fmt.Printf("🤖 正在生成SQL... (尝试 %d/%d)\n", attempt, g.maxRetryAttempts)
		response, err := g.client.GenerateSQL(prompt, options)

		if err == nil {
			if attempt > 1 {
				fmt.Printf("✅ LLM SQL生成重试成功！\n")
			}
			return response, nil
		}

		lastErr = err
		fmt.Printf("❌ LLM SQL生成失败 (尝试 %d/%d): %v\n", attempt, g.maxRetryAttempts, err)

		// 指数退避，但不超过最大延迟
		delay = time.Duration(float64(delay) * 1.5)
		if delay > g.maxDelay {
			delay = g.maxDelay
		}
	}

	return nil, fmt.Errorf("LLM SQL生成在 %d 次尝试后失败: %v", g.maxRetryAttempts, lastErr)
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

		// 提取 SQL - 使用(?s)标志让.匹配换行符，并使用非贪婪匹配到REASONING:
		sqlPattern := regexp.MustCompile(`(?s)SQL:\s*(.*?)(?:REASONING:|$)`)
		sqlMatches := sqlPattern.FindStringSubmatch(queryContent)
		if len(sqlMatches) < 2 {
			return QueryRequest{}, false
		}

		// 提取推理 - 使用(?s)标志让.匹配换行符
		reasoningPattern := regexp.MustCompile(`(?s)REASONING:\s*(.*?)(?:NEED_MORE:|$)`)
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
