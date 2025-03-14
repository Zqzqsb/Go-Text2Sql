package config

import (
	"fmt"
	"os"

	"gopkg.in/yaml.v3"
)

// Config 表示应用程序的配置
type Config struct {
	LLM      LLMConfig     `yaml:"llm"`
	Eval     EvalConfig    `yaml:"eval"`
	Dataset  DatasetConfig `yaml:"dataset"`
}

// LLMConfig 表示大语言模型的配置
type LLMConfig struct {
	Provider    string        `yaml:"provider"`
	Model       string        `yaml:"model"`
	Temperature float64       `yaml:"temperature"`
	MaxTokens   int           `yaml:"max_tokens"`
	OpenAI      OpenAIConfig  `yaml:"openai"`
	Azure       AzureConfig   `yaml:"azure"`
	Gemini      GeminiConfig  `yaml:"gemini"`
	Local       LocalConfig   `yaml:"local"`
}

// OpenAIConfig 表示OpenAI API的配置
type OpenAIConfig struct {
	APIKey  string `yaml:"api_key"`
	BaseURL string `yaml:"base_url"`
}

// AzureConfig 表示Azure OpenAI API的配置
type AzureConfig struct {
	APIKey       string `yaml:"api_key"`
	Endpoint     string `yaml:"endpoint"`
	DeploymentID string `yaml:"deployment_id"`
	APIVersion   string `yaml:"api_version"`
}

// GeminiConfig 表示Google Gemini API的配置
type GeminiConfig struct {
	APIKey  string `yaml:"api_key"`
	BaseURL string `yaml:"base_url"`
}

// LocalConfig 表示本地模型的配置
type LocalConfig struct {
	Endpoint string `yaml:"endpoint"`
	ModelPath string `yaml:"model_path"`
}

// EvalConfig 表示评估的配置
type EvalConfig struct {
	Method string `yaml:"method"`
	DBDir  string `yaml:"db_dir"`
}

// DatasetConfig 表示数据集的配置
type DatasetConfig struct {
	SpiderDir  string `yaml:"spider_dir"`
	CSpiderDir string `yaml:"cspider_dir"`
}

// LoadConfig 从指定的文件路径加载配置
func LoadConfig(configPath string) (*Config, error) {
	// 读取配置文件
	data, err := os.ReadFile(configPath)
	if err != nil {
		return nil, fmt.Errorf("读取配置文件失败: %w", err)
	}

	// 解析YAML
	var config Config
	if err := yaml.Unmarshal(data, &config); err != nil {
		return nil, fmt.Errorf("解析配置文件失败: %w", err)
	}

	return &config, nil
}
