package schema

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

// Column 表示数据库表的列
type Column struct {
	Name     string `json:"column_name"`
	Type     string `json:"data_type"`
	IsPrimary bool   `json:"is_primary"`
	IsForeign bool   `json:"is_foreign"`
}

// Table 表示数据库表
type Table struct {
	Name    string   `json:"table_name"`
	Columns []Column `json:"columns"`
}

// ForeignKey 表示外键关系
type ForeignKey struct {
	SourceTable  string `json:"source_table"`
	SourceColumn string `json:"source_column"`
	TargetTable  string `json:"target_table"`
	TargetColumn string `json:"target_column"`
}

// DatabaseSchema 表示数据库的结构
type DatabaseSchema struct {
	Tables      []Table      `json:"tables"`
	ForeignKeys []ForeignKey `json:"foreign_keys"`
}

// LoadSchema 从指定的路径加载数据库Schema
func LoadSchema(dbPath string) (*DatabaseSchema, error) {
	// 读取Schema文件
	schemaPath := filepath.Join(dbPath, "schema.json")
	data, err := os.ReadFile(schemaPath)
	if err != nil {
		return nil, fmt.Errorf("读取Schema文件失败: %w", err)
	}

	// 解析JSON
	var schema DatabaseSchema
	if err := json.Unmarshal(data, &schema); err != nil {
		return nil, fmt.Errorf("解析Schema文件失败: %w", err)
	}

	return &schema, nil
}

// FormatSchemaForPrompt 将Schema格式化为Prompt
func FormatSchemaForPrompt(schema *DatabaseSchema) string {
	var builder strings.Builder

	builder.WriteString("数据库Schema信息:\n")

	// 添加表信息
	for _, table := range schema.Tables {
		builder.WriteString(fmt.Sprintf("表名: %s\n", table.Name))
		builder.WriteString("列:\n")

		for _, column := range table.Columns {
			primaryKey := ""
			if column.IsPrimary {
				primaryKey = " (主键)"
			}
			foreignKey := ""
			if column.IsForeign {
				foreignKey = " (外键)"
			}
			builder.WriteString(fmt.Sprintf("  - %s: %s%s%s\n", column.Name, column.Type, primaryKey, foreignKey))
		}
		builder.WriteString("\n")
	}

	// 添加外键关系
	if len(schema.ForeignKeys) > 0 {
		builder.WriteString("外键关系:\n")
		for _, fk := range schema.ForeignKeys {
			builder.WriteString(fmt.Sprintf("  - %s.%s -> %s.%s\n", 
				fk.SourceTable, fk.SourceColumn, fk.TargetTable, fk.TargetColumn))
		}
	}

	return builder.String()
}

// GetDBNames 获取数据库目录中所有数据库的名称
func GetDBNames(dbDir string) ([]string, error) {
	// 读取目录
	entries, err := os.ReadDir(dbDir)
	if err != nil {
		return nil, fmt.Errorf("读取数据库目录失败: %w", err)
	}

	// 筛选出包含schema.json的子目录
	var dbNames []string
	for _, entry := range entries {
		if entry.IsDir() {
			schemaPath := filepath.Join(dbDir, entry.Name(), "schema.json")
			if _, err := os.Stat(schemaPath); err == nil {
				dbNames = append(dbNames, entry.Name())
			}
		}
	}

	return dbNames, nil
}
