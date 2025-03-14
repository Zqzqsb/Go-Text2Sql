package main

import (
	"fmt"
	"log"
	"path/filepath"

	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/eval"
)

func main() {
	// 加载Spider数据集配置
	configPath := filepath.Join("configs", "datasets", "spider.json")
	spider, err := dataset.LoadFromFile(configPath)
	if err != nil {
		log.Fatalf("加载数据集配置失败: %v", err)
	}

	// 打印数据集基本信息
	fmt.Printf("数据集: %s (%s)\n", spider.Name, spider.Type)
	fmt.Printf("基础目录: %s\n", spider.BaseDir)
	
	// 打印数据集统计信息
	fmt.Println("\n数据集统计:")
	fmt.Printf("  训练样例数: %d\n", spider.Stats.TrainCount)
	fmt.Printf("  开发样例数: %d\n", spider.Stats.DevCount)
	fmt.Printf("  测试样例数: %d\n", spider.Stats.TestCount)
	fmt.Printf("  数据库数量: %d\n", spider.Stats.DBCount)
	
	// 获取restaurant_1数据库路径
	dbName := "restaurant_1/restaurant_1.sqlite"
	dbPath := spider.DBPath(dbName)
	fmt.Printf("\n数据库 %s 的路径: %s\n", dbName, dbPath)
	
	// 执行简单查询
	fmt.Println("\n在restaurant_1数据库上执行查询:")
	query := "SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC LIMIT 3"
	result, err := eval.ExecSQL(dbPath, query)
	if err != nil {
		log.Fatalf("执行查询失败: %v", err)
	}
	
	if !result.Success {
		log.Fatalf("查询执行失败: %s", result.Error)
	}
	
	fmt.Println(eval.FormatExecResult(result))
	
	// 尝试加载开发集示例
	fmt.Println("\n加载开发集示例:")
	devExamples, err := spider.LoadDevExamples()
	if err != nil {
		log.Printf("警告: 加载开发集示例失败: %v", err)
	} else {
		fmt.Printf("已加载 %d 个开发集示例\n", len(devExamples))
		if len(devExamples) > 0 {
			// 打印第一个示例的信息
			fmt.Println("\n第一个示例:")
			example := devExamples[0]
			fmt.Printf("  问题: %v\n", example["question"])
			fmt.Printf("  数据库: %v\n", example["db_id"])
		}
	}
	
	// 尝试加载黄金SQL
	fmt.Println("\n加载开发集黄金SQL:")
	goldSQLs, err := spider.LoadGoldSQL("dev")
	if err != nil {
		log.Printf("警告: 加载黄金SQL失败: %v", err)
	} else {
		fmt.Printf("已加载 %d 条黄金SQL\n", len(goldSQLs))
		if len(goldSQLs) > 0 {
			fmt.Println("\n第一条黄金SQL:")
			fmt.Printf("  %s\n", goldSQLs[0])
		}
	}
}
