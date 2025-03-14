package main

import (
	"fmt"
	"os"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/llm"
)

func main() {
	// 加载测试配置
	configPath := "./configs/config.test.yaml"
	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		fmt.Printf("加载配置失败: %v\n", err)
		os.Exit(1)
	}

	// 创建LLM工厂
	factory := llm.NewLLMFactory(cfg)

	// 创建LLM客户端
	client, err := factory.Create()
	if err != nil {
		fmt.Printf("创建LLM客户端失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("LLM客户端: 提供商=%s, 模型=%s\n", 
		client.Provider(), client.ModelName())

	// 测试1: 生成文本
	fmt.Println("\n----- 标准请求测试 -----")
	
	// 设置选项
	options := llm.DefaultOptions()
	options.SystemPrompt = "你是人工智能助手"
	
	// 生成文本
	response, err := client.GenerateText("常见的十字花科植物有哪些？", options)
	if err != nil {
		fmt.Printf("生成文本失败: %v\n", err)
		os.Exit(1)
	}
	
	fmt.Println(response)

	// 测试2: 生成SQL
	fmt.Println("\n----- SQL生成测试 -----")
	
	// 设置SQL生成选项
	sqlOptions := llm.DefaultOptions()
	sqlOptions.SystemPrompt = "你是一个SQL专家，请根据问题生成SQL查询语句。"
	
	// 生成SQL
	sqlPrompt := "有一个名为'students'的表，包含字段id, name, age, grade。请写一个SQL查询，找出年龄大于18岁且成绩大于90分的学生姓名。"
	sqlResponse, err := client.GenerateSQL(sqlPrompt, sqlOptions)
	if err != nil {
		fmt.Printf("生成SQL失败: %v\n", err)
		os.Exit(1)
	}
	
	// 输出思考过程
	if sqlResponse.Thinking != "" {
		fmt.Println("\n思考过程:")
		fmt.Println(sqlResponse.Thinking)
	}
	
	// 输出SQL
	fmt.Println("\n生成的SQL:")
	fmt.Println(sqlResponse.Response)
	
	// 输出Token使用情况
	fmt.Printf("\nToken使用情况: 提示 %d, 响应 %d, 总计 %d\n", 
		sqlResponse.PromptTokens, sqlResponse.ResponseTokens, sqlResponse.TotalTokens)

	// 测试3: 对话
	fmt.Println("\n----- 对话测试 -----")
	
	// 设置对话选项
	chatOptions := llm.DefaultOptions()
	
	// 构建消息
	messages := []llm.Message{
		{Role: "system", Content: "你是人工智能助手"},
		{Role: "user", Content: "常见的十字花科植物有哪些？"},
	}
	
	// 进行对话
	chatResponse, err := client.Chat(messages, chatOptions)
	if err != nil {
		fmt.Printf("对话失败: %v\n", err)
		os.Exit(1)
	}
	
	fmt.Println(chatResponse)
}
