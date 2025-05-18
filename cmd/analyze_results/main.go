package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/database"
)

func main() {
	// 解析命令行参数
	inputPath := flag.String("input", "", "输入文件或目录路径")
	outputDir := flag.String("output", "./output", "输出目录路径")
	dbDir := flag.String("db-dir", "", "数据库目录路径")
	dbType := flag.String("db-type", "", "数据库类型 (sqlite, postgresql)")
	flag.Parse()

	// 验证输入参数
	if *inputPath == "" {
		fmt.Println("错误: 必须指定输入文件或目录路径")
		flag.Usage()
		os.Exit(1)
	}
	
	// 如果db-type为sqlite或未指定，必须提供数据库目录
	if (*dbType == "" || *dbType == "sqlite") && *dbDir == "" {
		fmt.Println("错误: 使用SQLite时必须指定数据库目录路径 (--db-dir)")
		flag.Usage()
		os.Exit(1)
	}

	// 确保输出目录存在
	if err := EnsureDirectoryExists(*outputDir); err != nil {
		fmt.Printf("创建输出目录失败: %v\n", err)
		os.Exit(1)
	}

	// 自动检测数据库类型
	detectedDBType := ""
	if *dbType == "" {
		// 尝试从路径中自动检测数据库类型
		if strings.Contains(*dbDir, "pg_") || strings.Contains(*dbDir, "postgres") {
			detectedDBType = "pg"
		} else {
			detectedDBType = "sqlite"
		}
		fmt.Printf("自动检测到数据库类型: %s\n", detectedDBType)
	} else {
		detectedDBType = *dbType
	}

	// 创建SQL执行器
	dbExecutor := database.NewDBExecutor()

	// 创建SQL分析器
	analyzer := NewSQLAnalyzer()

	// 创建报告生成器
	reporter := NewReporter(*outputDir)

	// 加载输入结果
	var inputResults []InputResult
	var err error

	// 检查输入路径是文件还是目录
	fileInfo, err := os.Stat(*inputPath)
	if err != nil {
		fmt.Printf("获取输入路径信息失败: %v\n", err)
		os.Exit(1)
	}

	// 根据输入路径类型加载结果
	if fileInfo.IsDir() {
			// 仅从目录中的info.jsonl文件加载结果
		jsonlPath := filepath.Join(*inputPath, "info.jsonl")
		fmt.Printf("从目录中的info.jsonl加载结果: %s\n", jsonlPath)
		
		// 检查info.jsonl文件是否存在
		if _, err := os.Stat(jsonlPath); os.IsNotExist(err) {
			fmt.Printf("错误: info.jsonl文件不存在于指定目录: %s\n", *inputPath)
			os.Exit(1)
		}
		
		// 只加载info.jsonl文件
		inputResults, err = LoadInputFile(jsonlPath)
	} else {
		// 从单个文件加载结果
		fmt.Printf("从文件加载结果: %s\n", *inputPath)

		// 检查文件扩展名
		if strings.HasSuffix(*inputPath, ".jsonl") {
			// 加载JSONL文件
			inputResults, err = LoadInputFile(*inputPath)
		} else {
			// 加载单个JSON文件
			result, err := LoadSingleResultFile(*inputPath)
			if err == nil && result != nil {
				inputResults = append(inputResults, *result)
			}
		}
	}

	if err != nil {
		fmt.Printf("加载输入结果失败: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("成功加载 %d 个结果\n", len(inputResults))

	// 开始分析
	fmt.Println("开始分析SQL查询...")
	startTime := time.Now()

	// 处理每个输入结果
	for i, input := range inputResults {
		// 显示进度
		if i > 0 && i%10 == 0 {
			fmt.Printf("已处理 %d/%d 个查询...\n", i, len(inputResults))
		}

		// 执行SQL查询
		fmt.Printf("执行查询: ID=%d, DB=%s\n", input.ID, input.DBName)

		// 构造数据库路径
		dbPath := input.DBName
		if detectedDBType == "pg" || detectedDBType == "postgres" || detectedDBType == "postgresql" {
			// 如果是PostgreSQL，添加pg:前缀
			dbPath = "pg:" + input.DBName
		} else if *dbDir != "" {
			// 如果是SQLite且指定了数据库目录
			dbPath = filepath.Join(*dbDir, input.DBName)
		}

		// 执行标准SQL
		gtResult := &ExecResult{Success: false}
		predResult := &ExecResult{Success: false}
		var gtErr, predErr error

		// 执行标准SQL
		fmt.Printf("执行标准SQL: %s\n", input.GTSQL)
		gtData, gtErr := dbExecutor.ExecSQL(dbPath, input.GTSQL)
		if gtErr == nil {
			gtResult.Success = true
			gtResult.Rows = ConvertResultFormat(gtData)
		} else {
			gtResult.Error = gtErr.Error()
			fmt.Printf("标准SQL执行错误: %v\n", gtErr)
		}

		// 执行预测SQL
		fmt.Printf("执行预测SQL: %s\n", input.PredSQL)
		predData, predErr := dbExecutor.ExecSQL(dbPath, input.PredSQL)
		if predErr == nil {
			predResult.Success = true
			predResult.Rows = ConvertResultFormat(predData)
		} else {
			predResult.Error = predErr.Error()
			fmt.Printf("预测SQL执行错误: %v\n", predErr)
		}

		// 分析结果
		analyzer.AnalyzeSQL(input, gtResult, predResult, gtErr, predErr)

		// 不保存单个分析结果，只生成总结性报告
	}

	// 计算分析时间
	elapsedTime := time.Since(startTime)

	// 获取统计信息
	stats := analyzer.GetStatistics()

	// 生成汇总报告
	if err := reporter.GenerateSummaryReport(stats, len(inputResults)); err != nil {
		fmt.Printf("生成汇总报告失败: %v\n", err)
	}

	// 打印摘要
	reporter.PrintSummary(stats, len(inputResults))

	// 显示总耗时
	fmt.Printf("\n分析完成，总耗时: %s\n", elapsedTime)
}
