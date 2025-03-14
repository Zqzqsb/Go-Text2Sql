package dataset_test

import (
	"testing"
	"path/filepath"

	"github.com/zqzqsb/gosql/internal/dataset"
)

func TestSpiderDataset(t *testing.T) {
	// 加载Spider数据集配置
	configPath := filepath.Join("/home/zq/Projects/BackupProjects/AI/GoSql/configs/datasets/spider.json")
	spider, err := dataset.LoadFromFile(configPath)
	if err != nil {
		t.Fatalf("加载Spider数据集配置失败: %v", err)
	}

	// 测试基本信息
	t.Run("基本信息", func(t *testing.T) {
		if spider.Type != "spider" {
			t.Errorf("数据集类型错误，期望 'spider'，实际 '%s'", spider.Type)
		}
		
		if spider.Name != "Spider" {
			t.Errorf("数据集名称错误，期望 'Spider'，实际 '%s'", spider.Name)
		}
	})
	
	// 测试统计信息
	t.Run("统计信息", func(t *testing.T) {
		if spider.Stats.TrainCount != 8659 {
			t.Errorf("训练样例数错误，期望 8659，实际 %d", spider.Stats.TrainCount)
		}
		
		if spider.Stats.DevCount != 1034 {
			t.Errorf("开发样例数错误，期望 1034，实际 %d", spider.Stats.DevCount)
		}
		
		if spider.Stats.DBCount != 166 {
			t.Errorf("数据库数量错误，期望 166，实际 %d", spider.Stats.DBCount)
		}
	})
	
	// 测试获取数据库路径
	t.Run("数据库路径", func(t *testing.T) {
		dbName := "restaurant_1/restaurant_1.sqlite"
		expectedPath := filepath.Join(spider.BaseDir, spider.DBDir, dbName)
		actualPath := spider.DBPath(dbName)
		
		if actualPath != expectedPath {
			t.Errorf("数据库路径错误，期望 '%s'，实际 '%s'", expectedPath, actualPath)
		}
	})
	
	// 测试文件配置
	t.Run("文件配置", func(t *testing.T) {
		if len(spider.Files.Train) != 2 {
			t.Errorf("训练文件数量错误，期望 2，实际 %d", len(spider.Files.Train))
		}
		
		if len(spider.Files.Dev) != 1 {
			t.Errorf("开发文件数量错误，期望 1，实际 %d", len(spider.Files.Dev))
		}
		
		if spider.Files.Tables != "tables.json" {
			t.Errorf("表结构文件错误，期望 'tables.json'，实际 '%s'", spider.Files.Tables)
		}
		
		if len(spider.Files.GoldSQL) != 2 {
			t.Errorf("黄金SQL文件数量错误，期望 2，实际 %d", len(spider.Files.GoldSQL))
		}
	})
	
	// 测试数据加载功能（仅检查是否有错误，不验证内容）
	t.Run("数据加载", func(t *testing.T) {
		// 测试加载表结构信息
		tables, err := spider.LoadTables()
		if err != nil {
			t.Errorf("加载表结构信息失败: %v", err)
		}
		
		// 检查表结构是否为空
		switch v := tables.(type) {
		case []interface{}:
			if len(v) == 0 {
				t.Errorf("表结构数组为空")
			}
		case map[string]interface{}:
			if len(v) == 0 {
				t.Errorf("表结构映射为空")
			}
		default:
			t.Errorf("表结构类型错误，期望数组或映射，实际 %T", tables)
		}
		
		// 测试加载开发集示例
		devExamples, err := spider.LoadDevExamples()
		if err != nil {
			t.Errorf("加载开发集示例失败: %v", err)
		} else if len(devExamples) == 0 {
			t.Errorf("开发集示例为空")
		}
		
		// 测试加载黄金SQL
		goldSQLs, err := spider.LoadGoldSQL("dev")
		if err != nil {
			t.Errorf("加载黄金SQL失败: %v", err)
		} else if len(goldSQLs) == 0 {
			t.Errorf("黄金SQL为空")
		}
	})
}
