package llm

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"

	"github.com/zqzqsb/gosql/internal/config"
)

// AzureClient 表示Azure OpenAI API客户端
type AzureClient struct {
	apiKey       string
	endpoint     string
	deploymentID string
	apiVersion   string
	client       *http.Client
	modelName    string
}

// NewAzureClient 创建一个新的Azure OpenAI API客户端
func NewAzureClient(cfg *config.AzureConfig, modelName string) *AzureClient {
	if modelName == "" {
		modelName = cfg.DeploymentID
	}
	
	return &AzureClient{
		apiKey:       cfg.APIKey,
		endpoint:     cfg.Endpoint,
		deploymentID: cfg.DeploymentID,
		apiVersion:   cfg.APIVersion,
		client:       &http.Client{},
		modelName:    modelName,
	}
}

// azureChatCompletionRequest 表示Azure聊天完成请求
type azureChatCompletionRequest struct {
	Messages    []Message `json:"messages"`
	Temperature float64   `json:"temperature"`
	MaxTokens   int       `json:"max_tokens"`
	N           int       `json:"n,omitempty"`
}

// azureChatCompletionChoice 表示Azure聊天完成的选择
type azureChatCompletionChoice struct {
	Message struct {
		Content string `json:"content"`
	} `json:"message"`
}

// azureChatCompletionUsage 表示Azure聊天完成的使用情况
type azureChatCompletionUsage struct {
	PromptTokens     int `json:"prompt_tokens"`
	CompletionTokens int `json:"completion_tokens"`
	TotalTokens      int `json:"total_tokens"`
}

// azureChatCompletionResponse 表示Azure聊天完成响应
type azureChatCompletionResponse struct {
	Choices []azureChatCompletionChoice `json:"choices"`
	Usage   azureChatCompletionUsage    `json:"usage"`
}

// Provider 返回提供商类型
func (c *AzureClient) Provider() Provider {
	return ProviderAzure
}

// ModelName 返回模型名称
func (c *AzureClient) ModelName() string {
	return c.modelName
}

// GenerateSQL 生成SQL查询
func (c *AzureClient) GenerateSQL(prompt string, options Options) (*SQLResponse, error) {
	// 构建系统消息
	systemMessage := options.SystemPrompt
	if systemMessage == "" {
		if options.DisableThinking {
			systemMessage = "请直接回答问题，只输出SQL语句，不要给出任何思考过程或解释。SQL语句应以分号结尾，并且不要包含任何其他文本或代码块标记。重要：不要翻译或转换任何中文词汇（如地名、国家名等）为英文，保持原始中文词汇不变。例如，'法国'应保持为'法国'而不是'France'。"
		} else {
			systemMessage = "请详细解释你的思考过程，然后给出最终的SQL查询。确保最终的SQL查询是单独一行，以分号结尾。重要：不要翻译或转换任何中文词汇（如地名、国家名等）为英文，保持原始中文词汇不变。例如，'法国'应保持为'法国'而不是'France'。"
		}
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
	
	if !options.DisableThinking {
		// 如果启用了思考过程，尝试分离思考过程和SQL
		parts := extractSQLFromThinking(content.Content)
		if len(parts) > 0 {
			sqlResponse.Response = parts[len(parts)-1]
			sqlResponse.Thinking = strings.Join(parts[:len(parts)-1], "\n")
		} else {
			sqlResponse.Response = content.Content
		}
	} else {
		// 如果禁用了思考过程，直接使用内容
		sqlResponse.Response = content.Content
	}

	// 处理SQL格式
	sqlResponse.Response = processSQLFormat(sqlResponse.Response)
	
	// 设置token使用情况
	sqlResponse.PromptTokens = content.PromptTokens
	sqlResponse.ResponseTokens = content.ResponseTokens
	sqlResponse.TotalTokens = content.TotalTokens

	return &sqlResponse, nil
}

// GenerateText 生成文本
func (c *AzureClient) GenerateText(prompt string, options Options) (string, error) {
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
func (c *AzureClient) Chat(messages []Message, options Options) (string, error) {
	content, err := c.sendChatRequest(messages, options)
	if err != nil {
		return "", err
	}
	
	return content.Content, nil
}

// chatResponse 表示聊天响应
type azureChatResponse struct {
	Content       string
	PromptTokens  int
	ResponseTokens int
	TotalTokens   int
}

// sendChatRequest 发送聊天请求
func (c *AzureClient) sendChatRequest(messages []Message, options Options) (*azureChatResponse, error) {
	reqBody := azureChatCompletionRequest{
		Messages:    messages,
		Temperature: options.Temperature,
		MaxTokens:   options.MaxTokens,
	}

	reqJSON, err := json.Marshal(reqBody)
	if err != nil {
		return nil, fmt.Errorf("序列化请求失败: %w", err)
	}

	// 构建Azure OpenAI API URL
	url := fmt.Sprintf("%s/openai/deployments/%s/chat/completions?api-version=%s", 
		c.endpoint, c.deploymentID, c.apiVersion)

	// 创建HTTP请求
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(reqJSON))
	if err != nil {
		return nil, fmt.Errorf("创建HTTP请求失败: %w", err)
	}

	// 设置请求头
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("api-key", c.apiKey)

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
	var completionResp azureChatCompletionResponse
	if err := json.Unmarshal(body, &completionResp); err != nil {
		return nil, fmt.Errorf("解析响应失败: %w", err)
	}

	if len(completionResp.Choices) == 0 {
		return nil, fmt.Errorf("API返回的选择为空")
	}

	// 返回响应内容
	return &azureChatResponse{
		Content:       completionResp.Choices[0].Message.Content,
		PromptTokens:  completionResp.Usage.PromptTokens,
		ResponseTokens: completionResp.Usage.CompletionTokens,
		TotalTokens:   completionResp.Usage.TotalTokens,
	}, nil
}
