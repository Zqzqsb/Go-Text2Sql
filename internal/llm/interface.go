package llm

// Provider 表示LLM提供商类型
type Provider string

const (
	// ProviderOpenAI 表示OpenAI提供商
	ProviderOpenAI Provider = "openai"
	// ProviderAzure 表示Azure OpenAI提供商
	ProviderAzure Provider = "azure"
	// ProviderGemini 表示Google Gemini提供商
	ProviderGemini Provider = "gemini"
	// ProviderLocal 表示本地模型提供商
	ProviderLocal Provider = "local"
)

// ModelConfig 表示模型配置
type ModelConfig struct {
	// CanThink 表示模型是否具有思考能力
	CanThink bool
}

// GetModelConfig 获取模型配置
func GetModelConfig(modelName string) ModelConfig {
	// 默认配置
	config := ModelConfig{
		CanThink: true,
	}
	
	// 根据模型名称设置特定配置
	switch modelName {
	case "gpt-3.5-turbo", "gpt-3.5-turbo-0125":
		config.CanThink = false
	case "deepseek-r1", "deepseek-r1-250120", "gpt-4", "gpt-4-turbo":
		config.CanThink = true
	}
	
	return config
}

// Message 表示聊天消息
type Message struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

// SQLResponse 表示SQL响应
type SQLResponse struct {
	Response      string
	PromptTokens  int
	ResponseTokens int
	TotalTokens   int
	Thinking      string
}

// Options 表示LLM请求选项
type Options struct {
	Temperature    float64
	MaxTokens      int
	DisableThinking bool
	SystemPrompt   string
}

// DefaultOptions 返回默认选项
func DefaultOptions() Options {
	return Options{
		Temperature:    0.3,
		MaxTokens:      2048,
		DisableThinking: false,
		SystemPrompt:   "请详细解释你的思考过程，然后给出最终的SQL查询。确保最终的SQL查询是单独一行，以分号结尾。",
	}
}

// LLM 表示大语言模型接口
type LLM interface {
	// GenerateSQL 生成SQL查询
	GenerateSQL(prompt string, options Options) (*SQLResponse, error)
	
	// GenerateText 生成文本
	GenerateText(prompt string, options Options) (string, error)
	
	// Chat 进行对话
	Chat(messages []Message, options Options) (string, error)
	
	// Provider 返回提供商类型
	Provider() Provider
	
	// ModelName 返回模型名称
	ModelName() string
}

// Factory 表示LLM工厂接口
type Factory interface {
	// Create 创建LLM实例
	Create(modelName string) (LLM, error)
}
