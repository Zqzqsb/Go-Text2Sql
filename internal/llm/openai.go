package llm

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"regexp"
	"strings"

	"github.com/zqzqsb/gosql/internal/config"
)

// OpenAIClient 表示OpenAI API客户端
type OpenAIClient struct {
	apiKey    string
	baseURL   string
	client    *http.Client
	modelName string
	modelConfig ModelConfig
}

// NewOpenAIClient 创建一个新的OpenAI API客户端
func NewOpenAIClient(cfg *config.OpenAIConfig, modelName string) *OpenAIClient {
	if modelName == "" {
		modelName = "gpt-3.5-turbo"
	}
	
	return &OpenAIClient{
		apiKey:    cfg.APIKey,
		baseURL:   cfg.BaseURL,
		client:    &http.Client{},
		modelName: modelName,
		modelConfig: GetModelConfig(modelName),
	}
}

// chatCompletionRequest 表示聊天完成请求
type chatCompletionRequest struct {
	Model       string    `json:"model"`
	Messages    []Message `json:"messages"`
	Temperature float64   `json:"temperature"`
	MaxTokens   int       `json:"max_tokens"`
	N           int       `json:"n,omitempty"`
}

// chatCompletionChoice 表示聊天完成的选择
type chatCompletionChoice struct {
	Message struct {
		Content string `json:"content"`
	} `json:"message"`
}

// chatCompletionUsage 表示聊天完成的使用情况
type chatCompletionUsage struct {
	PromptTokens     int `json:"prompt_tokens"`
	CompletionTokens int `json:"completion_tokens"`
	TotalTokens      int `json:"total_tokens"`
}

// chatCompletionResponse 表示聊天完成响应
type chatCompletionResponse struct {
	Choices []chatCompletionChoice `json:"choices"`
	Usage   chatCompletionUsage    `json:"usage"`
}

// Provider 返回提供商类型
func (c *OpenAIClient) Provider() Provider {
	return ProviderOpenAI
}

// ModelName 返回模型名称
func (c *OpenAIClient) ModelName() string {
	return c.modelName
}

// GenerateSQL 生成SQL查询
func (c *OpenAIClient) GenerateSQL(prompt string, options Options) (*SQLResponse, error) {
	// 根据模型配置决定是否启用思考过程
	disableThinking := options.DisableThinking
	if !c.modelConfig.CanThink {
		disableThinking = true
	}
	
	// 构建系统消息
	systemMessage := options.SystemPrompt
	if systemMessage == "" {
		if disableThinking {
			systemMessage = "请直接回答问题，只输出SQL语句，不要给出任何思考过程或解释。SQL语句应以分号结尾，并且不要包含任何其他文本或代码块标记。"
		} else {
			systemMessage = "请详细解释你的思考过程，然后给出最终的SQL查询。确保最终的SQL查询是单独一行，以分号结尾。"
		}
	}
	
	// 添加保留中文词汇的指令
	if options.PreserveChineseTerms {
		systemMessage += " 重要：不要翻译或转换任何中文词汇（如地名、国家名等）为英文，保持原始中文词汇不变。特别是在WHERE条件中的值，必须保持原始中文。例如，WHERE Country = '法国' 不应转换为 WHERE Country = 'France'。"
	} else {
		systemMessage += " 重要：将所有中文地名、国家名和人名翻译为英文，并确保它们以大写字母开头。例如，WHERE Country = '法国' 应转换为 WHERE Country = 'France'。"
	}
	
	// 构建请求
	messages := []Message{
		{Role: "system", Content: systemMessage},
		{Role: "user", Content: prompt},
	}

	// 调用Chat方法获取响应
	content, err := c.sendChatRequest(messages, options)
	if err != nil {
		return nil, err
	}
	
	// 处理思考过程和SQL
	var sqlResponse SQLResponse
	
	if !disableThinking {
		// 提取思考过程和SQL
		parts := extractSQLFromThinking(content.Content)
		if len(parts) > 1 {
			// 最后一部分是SQL，其他部分是思考过程
			sqlResponse.Thinking = parts[0]
			sqlResponse.Response = processSQLFormat(parts[len(parts)-1])
		} else if len(parts) == 1 {
			// 只有一部分，可能是SQL或思考过程
			sql := processSQLFormat(parts[0])
			if strings.HasPrefix(strings.ToUpper(strings.TrimSpace(sql)), "SELECT") ||
			   strings.HasPrefix(strings.ToUpper(strings.TrimSpace(sql)), "INSERT") ||
			   strings.HasPrefix(strings.ToUpper(strings.TrimSpace(sql)), "UPDATE") ||
			   strings.HasPrefix(strings.ToUpper(strings.TrimSpace(sql)), "DELETE") {
				sqlResponse.Response = sql
			} else {
				sqlResponse.Thinking = parts[0]
				sqlResponse.Response = ""
			}
		}
	} else {
		// 不需要思考过程，直接提取SQL
		// 尝试从响应中提取SQL语句
		sql := extractSQLDirectly(content.Content)
		sqlResponse.Response = processSQLFormat(sql)
	}
	
	sqlResponse.PromptTokens = content.PromptTokens
	sqlResponse.ResponseTokens = content.ResponseTokens
	sqlResponse.TotalTokens = content.TotalTokens
	
	return &sqlResponse, nil
}

// GenerateText 生成文本
func (c *OpenAIClient) GenerateText(prompt string, options Options) (string, error) {
	messages := []Message{
		{Role: "user", Content: prompt},
	}
	
	if options.SystemPrompt != "" {
		messages = append([]Message{{Role: "system", Content: options.SystemPrompt}}, messages...)
	}
	
	content, err := c.sendChatRequest(messages, options)
	if err != nil {
		return "", err
	}
	
	return content.Content, nil
}

// Chat 进行对话
func (c *OpenAIClient) Chat(messages []Message, options Options) (string, error) {
	content, err := c.sendChatRequest(messages, options)
	if err != nil {
		return "", err
	}
	
	return content.Content, nil
}

// chatResponse 表示聊天响应
type chatResponse struct {
	Content       string
	PromptTokens  int
	ResponseTokens int
	TotalTokens   int
}

// sendChatRequest 发送聊天请求
func (c *OpenAIClient) sendChatRequest(messages []Message, options Options) (*chatResponse, error) {
	reqBody := chatCompletionRequest{
		Model:       c.modelName,
		Messages:    messages,
		Temperature: options.Temperature,
		MaxTokens:   options.MaxTokens,
	}

	reqJSON, err := json.Marshal(reqBody)
	if err != nil {
		return nil, fmt.Errorf("序列化请求失败: %w", err)
	}

	// 创建HTTP请求
	req, err := http.NewRequest("POST", c.baseURL+"/chat/completions", bytes.NewBuffer(reqJSON))
	if err != nil {
		return nil, fmt.Errorf("创建HTTP请求失败: %w", err)
	}

	// 设置请求头
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+c.apiKey)

	// 发送请求
	resp, err := c.client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("发送请求失败: %w", err)
	}
	defer resp.Body.Close()

	// 读取响应
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("读取响应失败: %w", err)
	}

	// 检查响应状态码
	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("API请求失败，状态码: %d，响应: %s", resp.StatusCode, string(body))
	}

	// 解析响应
	var completionResp chatCompletionResponse
	if err := json.Unmarshal(body, &completionResp); err != nil {
		return nil, fmt.Errorf("解析响应失败: %w", err)
	}

	if len(completionResp.Choices) == 0 {
		return nil, fmt.Errorf("API返回的选择为空")
	}

	// 返回响应内容
	return &chatResponse{
		Content:       completionResp.Choices[0].Message.Content,
		PromptTokens:  completionResp.Usage.PromptTokens,
		ResponseTokens: completionResp.Usage.CompletionTokens,
		TotalTokens:   completionResp.Usage.TotalTokens,
	}, nil
}

// processSQLFormat 处理SQL格式
func processSQLFormat(sql string) string {
	// 清理SQL字符串
	sql = strings.TrimSpace(sql)
	
	// 确保SQL以分号结尾
	if !strings.HasSuffix(sql, ";") {
		sql = sql + ";"
	}
	
	return sql
}

// extractSQLFromThinking 从思考过程中提取SQL
func extractSQLFromThinking(content string) []string {
	// 尝试从代码块中提取SQL
	sqlRegex := regexp.MustCompile("```sql\\s*([\\s\\S]*?)\\s*```")
	matches := sqlRegex.FindAllStringSubmatch(content, -1)
	
	if len(matches) > 0 {
		// 找到了SQL代码块
		var sqlStatements []string
		for _, match := range matches {
			if len(match) > 1 {
				sql := strings.TrimSpace(match[1])
				if sql != "" {
					sqlStatements = append(sqlStatements, sql)
				}
			}
		}
		
		if len(sqlStatements) > 0 {
			// 提取思考过程
			thinking := content
			for _, match := range matches {
				thinking = strings.Replace(thinking, match[0], "", 1)
			}
			thinking = strings.TrimSpace(thinking)
			
			if thinking != "" {
				return append([]string{thinking}, sqlStatements...)
			}
			return sqlStatements
		}
	}
	
	// 如果没有找到代码块，尝试按行提取
	lines := strings.Split(content, "\n")
	var result []string
	var sqlBlock strings.Builder
	var thinkingBlock strings.Builder
	inSQL := false
	
	for _, line := range lines {
		trimmedLine := strings.TrimSpace(line)
		upperLine := strings.ToUpper(trimmedLine)
		
		// 检查是否是SQL语句的开始
		if strings.HasPrefix(upperLine, "SELECT") ||
		   strings.HasPrefix(upperLine, "INSERT") ||
		   strings.HasPrefix(upperLine, "UPDATE") ||
		   strings.HasPrefix(upperLine, "DELETE") ||
		   strings.HasPrefix(upperLine, "CREATE") ||
		   strings.HasPrefix(upperLine, "DROP") ||
		   strings.HasPrefix(upperLine, "ALTER") ||
		   strings.HasPrefix(upperLine, "WITH") {
			inSQL = true
			if sqlBlock.Len() > 0 {
				sqlBlock.WriteString(" ")
			}
			sqlBlock.WriteString(trimmedLine)
		} else if inSQL {
			// 继续收集SQL语句
			if strings.HasSuffix(trimmedLine, ";") {
				// SQL语句结束
				if sqlBlock.Len() > 0 {
					sqlBlock.WriteString(" ")
				}
				sqlBlock.WriteString(trimmedLine)
				inSQL = false
				
				// 添加完整的SQL语句到结果
				if sqlBlock.Len() > 0 {
					result = append(result, sqlBlock.String())
					sqlBlock.Reset()
				}
			} else if trimmedLine == "" {
				// 空行可能表示SQL语句结束
				if sqlBlock.Len() > 0 {
					result = append(result, sqlBlock.String())
					sqlBlock.Reset()
				}
				inSQL = false
			} else {
				// 继续收集SQL语句
				if sqlBlock.Len() > 0 {
					sqlBlock.WriteString(" ")
				}
				sqlBlock.WriteString(trimmedLine)
			}
		} else {
			// 收集思考过程
			if thinkingBlock.Len() > 0 {
				thinkingBlock.WriteString("\n")
			}
			thinkingBlock.WriteString(line)
		}
	}
	
	// 处理最后可能剩余的SQL语句
	if sqlBlock.Len() > 0 {
		result = append(result, sqlBlock.String())
	}
	
	// 如果有思考过程，添加到结果的开头
	if thinkingBlock.Len() > 0 {
		return append([]string{thinkingBlock.String()}, result...)
	}
	
	// 如果以上方法都没有提取到SQL，尝试直接返回内容
	if len(result) == 0 && content != "" {
		return []string{content}
	}
	
	return result
}

// extractSQLDirectly 直接提取SQL
func extractSQLDirectly(content string) string {
	// 清理内容
	content = strings.TrimSpace(content)
	
	// 检查是否是SQL语句
	upperContent := strings.ToUpper(content)
	if strings.HasPrefix(upperContent, "SELECT") ||
	   strings.HasPrefix(upperContent, "INSERT") ||
	   strings.HasPrefix(upperContent, "UPDATE") ||
	   strings.HasPrefix(upperContent, "DELETE") ||
	   strings.HasPrefix(upperContent, "CREATE") ||
	   strings.HasPrefix(upperContent, "DROP") ||
	   strings.HasPrefix(upperContent, "ALTER") ||
	   strings.HasPrefix(upperContent, "WITH") {
		return content
	}
	
	// 如果不是SQL语句，尝试从内容中提取SQL
	lines := strings.Split(content, "\n")
	var sqlBlock strings.Builder
	
	for _, line := range lines {
		trimmedLine := strings.TrimSpace(line)
		upperLine := strings.ToUpper(trimmedLine)
		
		// 检查是否是SQL语句的开始
		if strings.HasPrefix(upperLine, "SELECT") ||
		   strings.HasPrefix(upperLine, "INSERT") ||
		   strings.HasPrefix(upperLine, "UPDATE") ||
		   strings.HasPrefix(upperLine, "DELETE") ||
		   strings.HasPrefix(upperLine, "CREATE") ||
		   strings.HasPrefix(upperLine, "DROP") ||
		   strings.HasPrefix(upperLine, "ALTER") ||
		   strings.HasPrefix(upperLine, "WITH") {
			if sqlBlock.Len() > 0 {
				sqlBlock.WriteString(" ")
			}
			sqlBlock.WriteString(trimmedLine)
		} else if sqlBlock.Len() > 0 {
			// 继续收集SQL语句
			if strings.HasSuffix(trimmedLine, ";") {
				// SQL语句结束
				if sqlBlock.Len() > 0 {
					sqlBlock.WriteString(" ")
				}
				sqlBlock.WriteString(trimmedLine)
				break
			} else if trimmedLine == "" {
				// 空行可能表示SQL语句结束
				break
			} else {
				// 继续收集SQL语句
				if sqlBlock.Len() > 0 {
					sqlBlock.WriteString(" ")
				}
				sqlBlock.WriteString(trimmedLine)
			}
		}
	}
	
	// 返回提取的SQL
	return sqlBlock.String()
}
