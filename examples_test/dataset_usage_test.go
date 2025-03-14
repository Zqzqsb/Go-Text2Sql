package examples_test

import (
	"path/filepath"
	"testing"

	"github.com/zqzqsb/gosql/internal/dataset"
	"github.com/zqzqsb/gosql/internal/eval"
)

func TestDatasetUsage(t *testing.T) {
	// 加载Spider数据集配置
	configPath := filepath.Join("../configs", "datasets", "spider.json")
	spider, err := dataset.LoadFromFile(configPath)
	if err != nil {
		t.Fatalf("加载数据集配置失败: %v", err)
	}

	// 打印数据集基本信息
	t.Logf("数据集: %s (%s)\n", spider.Name, spider.Type)
	t.Logf("基础目录: %s\n", spider.BaseDir)
	
	// 打印数据集统计信息
	t.Log("\n数据集统计:")
	t.Logf("  训练样例数: %d\n", spider.Stats.TrainCount)
	t.Logf("  开发样例数: %d\n", spider.Stats.DevCount)
	t.Logf("  测试样例数: %d\n", spider.Stats.TestCount)
	t.Logf("  数据库数量: %d\n", spider.Stats.DBCount)
	
	// 获取restaurant_1数据库路径
	dbName := "restaurant_1/restaurant_1.sqlite"
	dbPath := spider.DBPath(dbName)
	t.Logf("\n数据库 %s 的路径: %s\n", dbName, dbPath)
	
	// 执行简单查询
	t.Log("\n在restaurant_1数据库上执行查询:")
	query := "SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC LIMIT 3"
	result, err := eval.ExecSQL(dbPath, query)
	if err != nil {
		t.Fatalf("执行查询失败: %v", err)
	}
	
	if !result.Success {
		t.Fatalf("查询执行失败: %s", result.Error)
	}
	
	t.Log(eval.FormatExecResult(result))
	
	// 尝试加载开发集示例
	t.Log("\n加载开发集示例:")
	devExamples, err := spider.LoadDevExamples()
	if err != nil {
		t.Logf("加载开发集示例失败: %v\n", err)
		t.Log("将继续测试其他功能")
	} else {
		if len(devExamples) > 0 {
			example := devExamples[0]
			t.Logf("第一个示例: DB=%s, 问题=%s", 
				example["db_id"], example["question"])
		}
	}
	
	// 尝试加载表结构
	t.Log("\n加载表结构:")
	tables, err := spider.LoadTables()
	if err != nil {
		t.Logf("加载表结构失败: %v\n", err)
		t.Log("将继续测试其他功能")
	} else {
		// 检查tables是否为map类型，并获取其长度
		tablesMap, ok := tables.(map[string]interface{})
		if ok {
			t.Logf("加载了 %d 个数据库的表结构\n", len(tablesMap))
		} else {
			t.Logf("表结构已加载，但类型不是预期的map类型\n")
		}
	}
	
	// 尝试加载黄金SQL
	t.Log("\n加载黄金SQL:")
	goldSQL, err := spider.LoadGoldSQL("dev")
	if err != nil {
		t.Logf("加载黄金SQL失败: %v\n", err)
		t.Log("这是预期的，因为查询可能不存在")
	} else {
		t.Logf("加载了 %d 条黄金SQL\n", len(goldSQL))
	}
}
