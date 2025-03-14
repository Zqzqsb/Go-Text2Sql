package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"

	"github.com/yourusername/gosql/internal/config"
	"github.com/yourusername/gosql/internal/eval"
	"github.com/yourusername/gosql/internal/llm"
	"github.com/yourusername/gosql/internal/schema"
	"github.com/yourusername/gosql/pkg/utils"
)

func main() {
	// 解析命令行参数
	configPath := flag.String("config", "config.yaml", "配置文件路径")
	question := flag.String("question", "", "自然语言问题")
	dbName := flag.String("db", "", "数据库名称")
	disableThinking := flag.Bool("disable-thinking", false, "禁用思考过程")
	evalSQL := flag.Bool("eval", true, "是否评估SQL")
	flag.Parse()

	// 检查必要参数
	if *question == "" {
		fmt.Println("错误: 必须提供问题参数 --question")
		flag.Usage()
		os.Exit(1)
	}

	if *dbName == "" {
		fmt.Println("错误: 必须提供数据库名称参数 --db")
		flag.Usage()
		os.Exit(1)
	}

	// 加载配置
	cfg, err := config.LoadConfig(*configPath)
	if err != nil {
		fmt.Printf("加载配置失败: %v\n", err)
		os.Exit(1)
	}

	// 加载数据库Schema
	dbPath := filepath.Join(cfg.Eval.DBDir, *dbName)
	dbSchema, err := schema.LoadSchema(dbPath)
	if err != nil {
		fmt.Printf("加载数据库Schema失败: %v\n", err)
		os.Exit(1)
	}

	// 格式化Schema为提示
	schemaPrompt := schema.FormatSchemaForPrompt(dbSchema)

	// 创建LLM客户端
	client := llm.NewClient(&cfg.OpenAI)

	// 格式化提示
	prompt := utils.FormatPrompt(*question, schemaPrompt)

	// 向LLM发送请求
	fmt.Println("正在向LLM发送请求...")
	response, err := client.AskLLM(cfg.Model.Name, prompt, cfg.Model.Temperature, cfg.Model.MaxTokens, *disableThinking)
	if err != nil {
		fmt.Printf("向LLM发送请求失败: %v\n", err)
		os.Exit(1)
	}

	// 输出思考过程
	if !*disableThinking && response.Thinking != "" {
		fmt.Println("\n思考过程:")
		fmt.Println(response.Thinking)
	}

	// 输出SQL
	fmt.Println("\n生成的SQL:")
	fmt.Println(response.Response)

	// 输出Token使用情况
	fmt.Printf("\nToken使用情况: 提示 %d, 响应 %d, 总计 %d\n", 
		response.PromptTokens, response.ResponseTokens, response.TotalTokens)

	// 评估SQL
	if *evalSQL {
		fmt.Println("\n正在评估SQL...")
		
		// 执行SQL
		dbFilePath := filepath.Join(dbPath, *dbName + ".sqlite")
		result, err := eval.ExecSQL(dbFilePath, response.Response)
		if err != nil {
			fmt.Printf("执行SQL失败: %v\n", err)
		} else {
			// 输出执行结果
			fmt.Println(eval.FormatExecResult(result))
		}
	}
}
