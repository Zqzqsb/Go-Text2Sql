package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
)

func main() {
	// 加载配置
	configPath := "./configs/config.example.yaml"
	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		fmt.Printf("加载配置失败: %v\n", err)
		os.Exit(1)
	}

	// 创建LLM工厂
	factory := llm.NewLLMFactory(cfg)

	// 示例1：使用默认提供商创建LLM客户端
	defaultClient, err := factory.Create()
	if err != nil {
		fmt.Printf("创建默认LLM客户端失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("默认LLM客户端: 提供商=%s, 模型=%s\n", 
		defaultClient.Provider(), defaultClient.ModelName())

	// 示例2：指定提供商创建LLM客户端
	openaiClient, err := factory.CreateWithProvider(llm.ProviderOpenAI, "gpt-4")
	if err != nil {
		fmt.Printf("创建OpenAI LLM客户端失败: %v\n", err)
	} else {
		fmt.Printf("OpenAI LLM客户端: 提供商=%s, 模型=%s\n", 
			openaiClient.Provider(), openaiClient.ModelName())
	}

	// 示例3：加载数据集配置
	datasetPath := "./configs/datasets/spider.json"
	ds, err := dataset.LoadFromFile(datasetPath)
	if err != nil {
		fmt.Printf("加载数据集配置失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("数据集: 类型=%s, 名称=%s\n", ds.Type, ds.Name)

	// 示例4：加载数据库Schema
	dbName := "concert_singer"
	dbPath := filepath.Join(ds.DBDir, dbName)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		fmt.Printf("加载数据库Schema失败: %v\n", err)
		os.Exit(1)
	}

	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)
	fmt.Printf("数据库Schema加载成功，表数量: %d\n", len(dbSchema.Tables))

	// 示例5：使用LLM生成SQL
	question := "找出所有歌手的名字和他们的歌曲数量"
	prompt := fmt.Sprintf("数据库Schema:\n%s\n\n问题: %s", schemaPrompt, question)

	// 设置选项
	options := factory.GetDefaultOptions()
	options.DisableThinking = false

	// 生成SQL
	fmt.Printf("\n正在使用 %s (%s) 生成SQL...\n", 
		defaultClient.Provider(), defaultClient.ModelName())
	
	response, err := defaultClient.GenerateSQL(prompt, options)
	if err != nil {
		fmt.Printf("生成SQL失败: %v\n", err)
		os.Exit(1)
	}

	// 输出思考过程
	if response.Thinking != "" {
		fmt.Println("\n思考过程:")
		fmt.Println(response.Thinking)
	}

	// 输出SQL
	fmt.Println("\n生成的SQL:")
	fmt.Println(response.Response)

	// 输出Token使用情况
	fmt.Printf("\nToken使用情况: 提示 %d, 响应 %d, 总计 %d\n", 
		response.PromptTokens, response.ResponseTokens, response.TotalTokens)

	// 示例6：使用LLM生成文本
	textPrompt := "解释SQL语言中JOIN操作的不同类型"
	fmt.Println("\n正在生成文本解释...")
	
	text, err := defaultClient.GenerateText(textPrompt, options)
	if err != nil {
		fmt.Printf("生成文本失败: %v\n", err)
	} else {
		fmt.Println("\n生成的文本:")
		fmt.Println(text)
	}

	// 示例7：使用LLM进行对话
	fmt.Println("\n正在进行对话...")
	
	messages := []llm.Message{
		{Role: "system", Content: "你是一个SQL专家，请简洁地回答用户的SQL相关问题。"},
		{Role: "user", Content: "什么是子查询？"},
	}
	
	chatResponse, err := defaultClient.Chat(messages, options)
	if err != nil {
		fmt.Printf("对话失败: %v\n", err)
	} else {
		fmt.Println("\n对话响应:")
		fmt.Println(chatResponse)
	}
}
