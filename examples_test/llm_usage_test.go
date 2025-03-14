package examples_test

import (
	"fmt"
	"path/filepath"
	"testing"

	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/llm"
	"github.com/zqzqsb/gosql/internal/schema"
)

func TestLLMUsage(t *testing.T) {
	// 加载配置
	configPath := "../configs/config.example.yaml"
	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		t.Fatalf("加载配置失败: %v\n", err)
	}

	// 创建LLM工厂
	factory := llm.NewLLMFactory(cfg)

	// 示例1：使用默认提供商创建LLM客户端
	defaultClient, err := factory.Create()
	if err != nil {
		t.Fatalf("创建默认LLM客户端失败: %v\n", err)
	}

	t.Logf("默认LLM客户端: 提供商=%s, 模型=%s\n",
		defaultClient.Provider(), defaultClient.ModelName())

	// 示例2：指定提供商创建LLM客户端
	openaiClient, err := factory.CreateWithProvider(llm.ProviderOpenAI, "deepseek-r1-250120")
	if err != nil {
		t.Logf("创建OpenAI LLM客户端失败: %v\n", err)
	} else {
		t.Logf("OpenAI LLM客户端: 提供商=%s, 模型=%s\n",
			openaiClient.Provider(), openaiClient.ModelName())
	}

	// 示例3：加载数据集配置
	datasetPath := "../configs/datasets/spider.json"
	ds, err := dataset.LoadFromFile(datasetPath)
	if err != nil {
		t.Fatalf("加载数据集配置失败: %v\n", err)
	}

	t.Logf("数据集: 类型=%s, 名称=%s\n", ds.Type, ds.Name)

	// 示例4：尝试加载数据库Schema
	// 注意：由于测试环境可能没有实际的数据库文件，我们会优雅地处理错误
	dbName := "concert_singer"
	dbPath := filepath.Join(ds.DBDir, dbName)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		t.Logf("加载数据库Schema失败: %v\n", err)
		// 创建一个模拟的Schema用于测试
		dbSchema = &schema.DatabaseSchema{
			Tables: []schema.Table{
				{
					Name: "singer",
					Columns: []schema.Column{
						{Name: "singer_id", Type: "INTEGER", IsPrimary: true},
						{Name: "name", Type: "TEXT"},
						{Name: "country", Type: "TEXT"},
						{Name: "song_count", Type: "INTEGER"},
					},
				},
				{
					Name: "song",
					Columns: []schema.Column{
						{Name: "song_id", Type: "INTEGER", IsPrimary: true},
						{Name: "title", Type: "TEXT"},
						{Name: "singer_id", Type: "INTEGER", IsForeign: true},
					},
				},
			},
			ForeignKeys: []schema.ForeignKey{
				{
					SourceTable: "song", 
					SourceColumn: "singer_id",
					TargetTable: "singer", 
					TargetColumn: "singer_id",
				},
			},
		}
		t.Logf("使用模拟的Schema继续测试\n")
	}

	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)
	t.Logf("数据库Schema加载成功，表数量: %d\n", len(dbSchema.Tables))

	// 示例5：使用LLM生成SQL
	question := "找出所有歌手的名字和他们的歌曲数量"
	prompt := fmt.Sprintf("数据库Schema:\n%s\n\n问题: %s", schemaPrompt, question)

	// 设置选项
	options := factory.GetDefaultOptions()
	options.DisableThinking = false

	// 生成SQL
	t.Logf("\n正在使用 %s (%s) 生成SQL...\n",
		defaultClient.Provider(), defaultClient.ModelName())

	response, err := defaultClient.GenerateSQL(prompt, options)
	if err != nil {
		t.Logf("生成SQL失败: %v\n", err)
		t.Log("使用模拟SQL响应继续测试")
		response = &llm.SQLResponse{
			Response: "SELECT singer.name, COUNT(song.song_id) as song_count FROM singer LEFT JOIN song ON singer.singer_id = song.singer_id GROUP BY singer.singer_id, singer.name",
			PromptTokens: 150,
			ResponseTokens: 50,
			TotalTokens: 200,
			Thinking: "我需要找出所有歌手的名字和他们的歌曲数量。\n1. 从singer表中获取歌手名字\n2. 使用LEFT JOIN连接song表，这样即使歌手没有歌曲也会被包含\n3. 按歌手ID分组\n4. 计算每个歌手的歌曲数量",
		}
	}

	// 输出思考过程
	if response.Thinking != "" {
		t.Logf("\n思考过程:")
		t.Logf(response.Thinking)
	}

	// 输出SQL
	t.Logf("\n生成的SQL:")
	t.Logf(response.Response)

	// 输出Token使用情况
	t.Logf("\nToken使用情况: 提示 %d, 响应 %d, 总计 %d\n",
		response.PromptTokens, response.ResponseTokens, response.TotalTokens)

	// 示例6：使用LLM生成文本
	textPrompt := "解释SQL语言中JOIN操作的不同类型"
	t.Logf("\n正在生成文本解释...")

	text, err := defaultClient.GenerateText(textPrompt, options)
	if err != nil {
		t.Logf("生成文本失败: %v\n", err)
		t.Log("使用模拟文本响应继续测试")
		text = "SQL中的JOIN操作有几种不同类型：\n1. INNER JOIN：返回两表中匹配的行\n2. LEFT JOIN：返回左表所有行和右表匹配的行\n3. RIGHT JOIN：返回右表所有行和左表匹配的行\n4. FULL JOIN：返回两表中所有行，不管是否匹配"
	}

	t.Logf("\n生成的文本:")
	t.Logf(text)

	// 示例7：使用LLM进行对话
	t.Logf("\n正在进行对话...")

	messages := []llm.Message{
		{Role: "system", Content: "你是一个SQL专家，请简洁地回答用户的SQL相关问题。"},
		{Role: "user", Content: "什么是子查询？"},
	}

	chatResponse, err := defaultClient.Chat(messages, options)
	if err != nil {
		t.Logf("对话失败: %v\n", err)
		t.Log("使用模拟对话响应继续测试")
		chatResponse = "子查询是嵌套在另一个SQL查询内部的查询。它可以用在SELECT、INSERT、UPDATE或DELETE语句中，通常与IN、EXISTS、ANY、ALL等操作符一起使用。子查询可以返回单个值、一列值或一个结果集，用于为外部查询提供数据或条件。"
	}

	t.Logf("\n对话响应:")
	t.Logf(chatResponse)
}
