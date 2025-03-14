package llm

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"

	"github.com/yourusername/gosql/internal/config"
)

// Client 表示OpenAI API客户端
type Client struct {
	apiKey  string
	baseURL string
	client  *http.Client
}

// NewClient 创建一个新的OpenAI API客户端
func NewClient(cfg *config.OpenAIConfig) *Client {
	return &Client{
		apiKey:  cfg.APIKey,
		baseURL: cfg.BaseURL,
		client:  &http.Client{},
	}
}

// Message 表示聊天消息
type Message struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

// ChatCompletionRequest 表示聊天完成请求
type ChatCompletionRequest struct {
	Model       string    `json:"model"`
	Messages    []Message `json:"messages"`
	Temperature float64   `json:"temperature"`
	MaxTokens   int       `json:"max_tokens"`
	N           int       `json:"n,omitempty"`
}

// ChatCompletionChoice 表示聊天完成的选择
type ChatCompletionChoice struct {
	Message struct {
		Content string `json:"content"`
	} `json:"message"`
}

// ChatCompletionUsage 表示聊天完成的使用情况
type ChatCompletionUsage struct {
	PromptTokens     int `json:"prompt_tokens"`
	CompletionTokens int `json:"completion_tokens"`
	TotalTokens      int `json:"total_tokens"`
}

// ChatCompletionResponse 表示聊天完成响应
type ChatCompletionResponse struct {
	Choices []ChatCompletionChoice `json:"choices"`
	Usage   ChatCompletionUsage    `json:"usage"`
}

// SQLResponse 表示SQL响应
type SQLResponse struct {
	Response     string
	PromptTokens int
	ResponseTokens int
	TotalTokens  int
	Thinking     string
}

// AskLLM 向LLM发送问题并获取SQL响应
func (c *Client) AskLLM(modelName string, prompt string, temperature float64, maxTokens int, disableThinking bool) (*SQLResponse, error) {
	// 构建系统消息
	systemMessage := "请回答问题，不要给出思考过程或解释。所有SQL内容都应以;结尾"
	if !disableThinking {
		systemMessage = "请详细解释你的思考过程，然后给出最终的SQL查询。确保最终的SQL查询是单独一行，以分号结尾。"
	}

	// 构建请求
	messages := []Message{
		{Role: "system", Content: systemMessage},
		{Role: "user", Content: prompt},
	}

	reqBody := ChatCompletionRequest{
		Model:       modelName,
		Messages:    messages,
		Temperature: temperature,
		MaxTokens:   maxTokens,
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
	var completionResp ChatCompletionResponse
	if err := json.Unmarshal(body, &completionResp); err != nil {
		return nil, fmt.Errorf("解析响应失败: %w", err)
	}

	if len(completionResp.Choices) == 0 {
		return nil, fmt.Errorf("API返回的选择为空")
	}

	// 提取响应内容
	content := completionResp.Choices[0].Message.Content
	
	// 处理思考过程和SQL
	var sqlResponse SQLResponse
	
	if !disableThinking {
		// 如果启用了思考过程，尝试分离思考过程和SQL
		parts := extractSQLFromThinking(content)
		if len(parts) > 0 {
			sqlResponse.Response = parts[len(parts)-1]
			sqlResponse.Thinking = strings.Join(parts[:len(parts)-1], "\n")
		} else {
			sqlResponse.Response = content
		}
	} else {
		// 如果禁用了思考过程，直接使用内容
		sqlResponse.Response = content
	}

	// 处理SQL格式
	sqlResponse.Response = processSQLFormat(sqlResponse.Response)
	
	// 设置token使用情况
	sqlResponse.PromptTokens = completionResp.Usage.PromptTokens
	sqlResponse.ResponseTokens = completionResp.Usage.CompletionTokens
	sqlResponse.TotalTokens = completionResp.Usage.TotalTokens

	return &sqlResponse, nil
}

// extractSQLFromThinking 从思考过程中提取SQL
func extractSQLFromThinking(content string) []string {
	// 按行分割
	lines := strings.Split(content, "\n")
	var result []string
	var currentBlock string
	
	for _, line := range lines {
		trimmedLine := strings.TrimSpace(line)
		
		// 检查是否是SQL语句
		if strings.HasPrefix(strings.ToUpper(trimmedLine), "SELECT") {
			// 如果当前块不为空，添加到结果
			if currentBlock != "" {
				result = append(result, currentBlock)
				currentBlock = ""
			}
			// 添加SQL语句
			result = append(result, trimmedLine)
		} else if trimmedLine != "" {
			// 如果不是SQL语句且不为空，添加到当前块
			if currentBlock != "" {
				currentBlock += "\n"
			}
			currentBlock += line
		}
	}
	
	// 如果最后还有未添加的块，添加到结果
	if currentBlock != "" {
		result = append(result, currentBlock)
	}
	
	return result
}

// processSQLFormat 处理SQL格式
func processSQLFormat(sql string) string {
	// 移除换行符和多余的空格
	sql = strings.Join(strings.Fields(sql), " ")
	
	// 确保SQL以SELECT开头
	if !strings.HasPrefix(strings.ToUpper(sql), "SELECT") {
		if strings.HasPrefix(sql, " ") {
			sql = "SELECT" + sql
		} else {
			sql = "SELECT " + sql
		}
	}
	
	// 确保SQL以分号结尾
	if !strings.HasSuffix(sql, ";") {
		sql += ";"
	}
	
	return sql
}
