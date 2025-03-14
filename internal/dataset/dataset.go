package dataset

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

// Dataset 表示一个文本到SQL任务的数据集
type Dataset struct {
	// 数据集类型
	Type string `json:"type"`
	// 数据集名称
	Name string `json:"name"`
	// 数据集基础目录
	BaseDir string `json:"base_dir"`
	// 数据文件配置
	Files struct {
		// 训练文件
		Train []string `json:"train"`
		// 开发文件
		Dev []string `json:"dev"`
		// 测试文件
		Test []string `json:"test"`
		// 表结构文件
		Tables string `json:"tables"`
		// 黄金SQL文件
		GoldSQL map[string]string `json:"gold_sql"`
	} `json:"files"`
	// 数据库目录
	DBDir string `json:"db_dir"`
	// 统计信息
	Stats struct {
		// 训练样例数
		TrainCount int `json:"train_count"`
		// 开发样例数
		DevCount int `json:"dev_count"`
		// 测试样例数
		TestCount int `json:"test_count"`
		// 数据库数量
		DBCount int `json:"db_count"`
	} `json:"stats"`
}

// LoadFromFile 从配置文件加载数据集
func LoadFromFile(configPath string) (*Dataset, error) {
	data, err := os.ReadFile(configPath)
	if err != nil {
		return nil, fmt.Errorf("读取配置文件失败: %w", err)
	}

	var dataset Dataset
	if err := json.Unmarshal(data, &dataset); err != nil {
		return nil, fmt.Errorf("解析配置文件失败: %w", err)
	}

	return &dataset, nil
}

// DBPath 返回指定数据库的路径
func (d *Dataset) DBPath(dbName string) string {
	return filepath.Join(d.BaseDir, d.DBDir, dbName)
}

// LoadTrainExamples 加载训练样例
func (d *Dataset) LoadTrainExamples() ([]map[string]interface{}, error) {
	return d.loadExamples(d.Files.Train)
}

// LoadDevExamples 加载开发样例
func (d *Dataset) LoadDevExamples() ([]map[string]interface{}, error) {
	return d.loadExamples(d.Files.Dev)
}

// LoadTestExamples 加载测试样例
func (d *Dataset) LoadTestExamples() ([]map[string]interface{}, error) {
	return d.loadExamples(d.Files.Test)
}

// LoadTables 加载表结构信息
func (d *Dataset) LoadTables() (interface{}, error) {
	if d.Files.Tables == "" {
		return nil, fmt.Errorf("未配置表结构文件")
	}
	
	path := filepath.Join(d.BaseDir, d.Files.Tables)
	data, err := os.ReadFile(path)
	if err != nil {
		return nil, fmt.Errorf("读取表结构文件失败: %w", err)
	}
	
	// 首先尝试解析为数组
	var tablesArray []interface{}
	if err := json.Unmarshal(data, &tablesArray); err == nil {
		return tablesArray, nil
	}
	
	// 如果解析为数组失败，尝试解析为对象
	var tablesObject map[string]interface{}
	if err := json.Unmarshal(data, &tablesObject); err != nil {
		return nil, fmt.Errorf("解析表结构文件失败: %w", err)
	}
	
	return tablesObject, nil
}

// LoadGoldSQL 加载指定分割的黄金SQL
func (d *Dataset) LoadGoldSQL(split string) ([]string, error) {
	path, ok := d.Files.GoldSQL[split]
	if !ok {
		return nil, fmt.Errorf("未找到分割 %s 的黄金SQL文件", split)
	}
	
	fullPath := filepath.Join(d.BaseDir, path)
	data, err := os.ReadFile(fullPath)
	if err != nil {
		return nil, fmt.Errorf("读取黄金SQL文件失败: %w", err)
	}
	
	lines := strings.Split(string(data), "\n")
	var queries []string
	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line != "" {
			queries = append(queries, line)
		}
	}
	
	return queries, nil
}

// 内部辅助函数

// loadExamples 从JSON文件加载样例
func (d *Dataset) loadExamples(files []string) ([]map[string]interface{}, error) {
	var allExamples []map[string]interface{}
	
	for _, file := range files {
		path := filepath.Join(d.BaseDir, file)
		data, err := os.ReadFile(path)
		if err != nil {
			return nil, fmt.Errorf("读取文件 %s 失败: %w", file, err)
		}
		
		var examples []map[string]interface{}
		if err := json.Unmarshal(data, &examples); err != nil {
			return nil, fmt.Errorf("解析文件 %s 失败: %w", file, err)
		}
		
		allExamples = append(allExamples, examples...)
	}
	
	return allExamples, nil
}
