package llm

import (
	"fmt"

	"github.com/zqzqsb/gosql/internal/config"
)

// Factory 实现了LLM工厂接口
type LLMFactory struct {
	config *config.Config
}

// NewLLMFactory 创建一个新的LLM工厂
func NewLLMFactory(config *config.Config) *LLMFactory {
	return &LLMFactory{
		config: config,
	}
}

// Create 根据配置创建LLM实例
func (f *LLMFactory) Create() (LLM, error) {
	provider := f.config.LLM.Provider
	modelName := f.config.LLM.Model

	switch Provider(provider) {
	case ProviderOpenAI:
		return NewOpenAIClient(&f.config.LLM.OpenAI, modelName), nil
	case ProviderAzure:
		return NewAzureClient(&f.config.LLM.Azure, modelName), nil
	case ProviderGemini:
		return NewGeminiClient(&f.config.LLM.Gemini, modelName), nil
	case ProviderLocal:
		// 本地模型实现待添加
		return nil, fmt.Errorf("本地模型暂未实现")
	default:
		return nil, fmt.Errorf("不支持的LLM提供商: %s", provider)
	}
}

// CreateWithProvider 根据指定的提供商创建LLM实例
func (f *LLMFactory) CreateWithProvider(provider Provider, modelName string) (LLM, error) {
	switch provider {
	case ProviderOpenAI:
		return NewOpenAIClient(&f.config.LLM.OpenAI, modelName), nil
	case ProviderAzure:
		return NewAzureClient(&f.config.LLM.Azure, modelName), nil
	case ProviderGemini:
		return NewGeminiClient(&f.config.LLM.Gemini, modelName), nil
	case ProviderLocal:
		// 本地模型实现待添加
		return nil, fmt.Errorf("本地模型暂未实现")
	default:
		return nil, fmt.Errorf("不支持的LLM提供商: %s", provider)
	}
}

// GetDefaultOptions 获取默认选项
func (f *LLMFactory) GetDefaultOptions() Options {
	return Options{
		Temperature:     f.config.LLM.Temperature,
		MaxTokens:       f.config.LLM.MaxTokens,
		DisableThinking: false,
	}
}
