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

// GeminiClient 表示Google Gemini API客户端
type GeminiClient struct {
	apiKey    string
	baseURL   string
	client    *http.Client
	modelName string
}

// NewGeminiClient 创建一个新的Gemini API客户端
func NewGeminiClient(cfg *config.GeminiConfig, modelName string) *GeminiClient {
	if modelName == "" {
		modelName = "gemini-pro"
	}
	
	baseURL := "https://generativelanguage.googleapis.com/v1beta"
	if cfg.BaseURL != "" {
		baseURL = cfg.BaseURL
	}
	
	return &GeminiClient{
		apiKey:    cfg.APIKey,
		baseURL:   baseURL,
		client:    &http.Client{},
		modelName: modelName,
	}
}

// geminiPart 表示Gemini消息的一部分
type geminiPart struct {
	Text string `json:"text"`
}

// geminiContent 表示Gemini内容
type geminiContent struct {
	Parts []geminiPart `json:"parts"`
	Role  string       `json:"role,omitempty"`
}

// geminiGenerateContentRequest 表示Gemini生成内容请求
type geminiGenerateContentRequest struct {
	Contents   []geminiContent `json:"contents"`
	Generation geminiGeneration `json:"generationConfig"`
}

// geminiGeneration 表示Gemini生成配置
type geminiGeneration struct {
	Temperature float64 `json:"temperature"`
	MaxTokens   int     `json:"maxOutputTokens,omitempty"`
}

// geminiGenerateContentResponse 表示Gemini生成内容响应
type geminiGenerateContentResponse struct {
	Candidates []struct {
		Content struct {
			Parts []geminiPart `json:"parts"`
		} `json:"content"`
	} `json:"candidates"`
	Usage struct {
		PromptTokenCount     int `json:"promptTokenCount"`
		CandidatesTokenCount int `json:"candidatesTokenCount"`
		TotalTokenCount      int `json:"totalTokenCount"`
	} `json:"usageMetadata"`
}

// Provider 返回提供商类型
func (c *GeminiClient) Provider() Provider {
	return ProviderGemini
}

// ModelName 返回模型名称
func (c *GeminiClient) ModelName() string {
	return c.modelName
}

// GenerateSQL 生成SQL查询
func (c *GeminiClient) GenerateSQL(prompt string, options Options) (*SQLResponse, error) {
	// 构建系统消息
	systemMessage := options.SystemPrompt
	if systemMessage == "" {
		if options.DisableThinking {
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
	
	// 构建完整提示
	fullPrompt := fmt.Sprintf("%s\n\n%s", systemMessage, prompt)
	
	// 调用生成方法获取响应
	content, err := c.generateContent(fullPrompt, options)
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
func (c *GeminiClient) GenerateText(prompt string, options Options) (string, error) {
	// 如果有系统提示，添加到提示前面
	fullPrompt := prompt
	if options.SystemPrompt != "" {
		fullPrompt = fmt.Sprintf("%s\n\n%s", options.SystemPrompt, prompt)
	}
	
	content, err := c.generateContent(fullPrompt, options)
	if err != nil {
		return "", err
	}
	
	return content.Content, nil
}

// Chat 进行对话
func (c *GeminiClient) Chat(messages []Message, options Options) (string, error) {
	// 将标准消息格式转换为Gemini格式
	var geminiMessages []geminiContent
	
	for _, msg := range messages {
		role := msg.Role
		// Gemini只支持user和model角色，将system角色转换为user
		if role == "system" {
			role = "user"
		} else if role == "assistant" {
			role = "model"
		}
		
		geminiMessages = append(geminiMessages, geminiContent{
			Role: role,
			Parts: []geminiPart{
				{Text: msg.Content},
			},
		})
	}
	
	// 发送请求
	response, err := c.sendChatRequest(geminiMessages, options)
	if err != nil {
		return "", err
	}
	
	return response.Content, nil
}

// geminiResponse 表示Gemini响应
type geminiResponse struct {
	Content       string
	PromptTokens  int
	ResponseTokens int
	TotalTokens   int
}

// generateContent 生成内容
func (c *GeminiClient) generateContent(prompt string, options Options) (*geminiResponse, error) {
	contents := []geminiContent{
		{
			Parts: []geminiPart{
				{Text: prompt},
			},
		},
	}
	
	return c.sendChatRequest(contents, options)
}

// sendChatRequest 发送聊天请求
func (c *GeminiClient) sendChatRequest(contents []geminiContent, options Options) (*geminiResponse, error) {
	reqBody := geminiGenerateContentRequest{
		Contents: contents,
		Generation: geminiGeneration{
			Temperature: options.Temperature,
			MaxTokens:   options.MaxTokens,
		},
	}

	reqJSON, err := json.Marshal(reqBody)
	if err != nil {
		return nil, fmt.Errorf("序列化请求失败: %w", err)
	}

	// 构建Gemini API URL
	url := fmt.Sprintf("%s/models/%s:generateContent?key=%s", 
		c.baseURL, c.modelName, c.apiKey)

	// 创建HTTP请求
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(reqJSON))
	if err != nil {
		return nil, fmt.Errorf("创建HTTP请求失败: %w", err)
	}

	// 设置请求头
	req.Header.Set("Content-Type", "application/json")

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
	var genResp geminiGenerateContentResponse
	if err := json.Unmarshal(body, &genResp); err != nil {
		return nil, fmt.Errorf("解析响应失败: %w", err)
	}

	if len(genResp.Candidates) == 0 || len(genResp.Candidates[0].Content.Parts) == 0 {
		return nil, fmt.Errorf("API返回的内容为空")
	}

	// 返回响应内容
	return &geminiResponse{
		Content:       genResp.Candidates[0].Content.Parts[0].Text,
		PromptTokens:  genResp.Usage.PromptTokenCount,
		ResponseTokens: genResp.Usage.CandidatesTokenCount,
		TotalTokens:   genResp.Usage.TotalTokenCount,
	}, nil
}
