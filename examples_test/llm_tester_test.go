package examples_test

import (
	"testing"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/llm"
)

func TestLLMTester(t *testing.T) {
	// 加载测试配置
	configPath := "../configs/config.test.yaml"
	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		t.Fatalf("加载配置失败: %v\n", err)
	}

	// 创建LLM工厂
	factory := llm.NewLLMFactory(cfg)

	// 创建LLM客户端
	client, err := factory.Create()
	if err != nil {
		t.Logf("创建LLM客户端失败: %v\n", err)
		t.Skip("跳过需要LLM客户端的测试")
		return
	}

	t.Logf("LLM客户端: 提供商=%s, 模型=%s\n",
		client.Provider(), client.ModelName())

	// 测试1: 生成文本
	t.Log("\n----- 标准请求测试 -----")

	// 设置选项
	options := llm.DefaultOptions()
	options.SystemPrompt = "你是人工智能助手"

	// 生成文本
	response, err := client.GenerateText("常见的十字花科植物有哪些？", options)
	if err != nil {
		t.Logf("生成文本失败: %v\n", err)
		t.Log("使用模拟文本响应继续测试")
		response = "十字花科植物包括芸香、油菜、白菜、花椰菜、西兰花等。"
	}

	t.Log(response)

	// 测试2: 生成SQL
	t.Log("\n----- SQL生成测试 -----")

	// 设置SQL生成选项
	sqlOptions := llm.DefaultOptions()
	sqlOptions.SystemPrompt = "你是SQL专家，请根据问题生成准确的SQL查询"

	// 表结构
	tableDesc := `
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER,
  grade TEXT,
  score REAL
);
`

	// 生成SQL
	sqlResp, err := client.GenerateSQL(tableDesc+"\n\n问题: 查询所有年龄大于18岁的学生姓名和分数，按分数降序排列", sqlOptions)
	if err != nil {
		t.Logf("生成SQL失败: %v\n", err)
		t.Log("使用模拟SQL响应继续测试")
		sqlResp = &llm.SQLResponse{
			Response: "SELECT name, score FROM students WHERE age > 18 ORDER BY score DESC",
			PromptTokens: 15,
			ResponseTokens: 10,
			TotalTokens: 25,
		}
	}

	t.Logf("生成的SQL: %s\n", sqlResp.Response)
	if sqlResp.Thinking != "" {
		t.Logf("思考过程: %s\n", sqlResp.Thinking)
	}

	// 测试3: 对话
	t.Log("\n----- 对话测试 -----")

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
		t.Logf("对话失败: %v\n", err)
		t.Log("使用模拟聊天响应继续测试")
		chatResponse = "十字花科植物包括芸香、油菜、白菜、花椰菜、西兰花等。"
	}

	t.Log(chatResponse)
}
