package config

import (
	"fmt"
	"os"

	"gopkg.in/yaml.v3"
)

// Config 表示应用程序的配置
type Config struct {
	OpenAI  OpenAIConfig  `yaml:"openai"`
	Model   ModelConfig   `yaml:"model"`
	Eval    EvalConfig    `yaml:"eval"`
	Dataset DatasetConfig `yaml:"dataset"`
}

// OpenAIConfig 表示OpenAI API的配置
type OpenAIConfig struct {
	APIKey  string `yaml:"api_key"`
	BaseURL string `yaml:"base_url"`
}

// ModelConfig 表示模型的配置
type ModelConfig struct {
	Name        string  `yaml:"name"`
	Temperature float64 `yaml:"temperature"`
	MaxTokens   int     `yaml:"max_tokens"`
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
