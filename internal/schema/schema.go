package schema

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
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
	// 首先尝试读取schema.json文件
	schemaPath := filepath.Join(dbPath, "schema.json")
	data, err := os.ReadFile(schemaPath)
	
	// 如果schema.json不存在，尝试读取schema.sql文件
	if os.IsNotExist(err) {
		sqlSchemaPath := filepath.Join(dbPath, "schema.sql")
		return LoadSchemaFromSQL(sqlSchemaPath)
	} else if err != nil {
		return nil, fmt.Errorf("读取Schema文件失败: %w", err)
	}

	// 解析JSON
	var schema DatabaseSchema
	if err := json.Unmarshal(data, &schema); err != nil {
		return nil, fmt.Errorf("解析Schema文件失败: %w", err)
	}

	return &schema, nil
}

// LoadSchemaFromSQL 从SQL文件加载数据库Schema
func LoadSchemaFromSQL(sqlFilePath string) (*DatabaseSchema, error) {
	// 读取SQL文件
	data, err := os.ReadFile(sqlFilePath)
	if err != nil {
		return nil, fmt.Errorf("读取SQL Schema文件失败: %w", err)
	}
	
	sqlContent := string(data)
	
	// 创建Schema对象
	schema := &DatabaseSchema{
		Tables:      []Table{},
		ForeignKeys: []ForeignKey{},
	}
	
	// 解析CREATE TABLE语句
	tableRegex := regexp.MustCompile(`(?i)CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?["']?(\w+)["']?\s*\(([\s\S]*?)\);`)
	tableMatches := tableRegex.FindAllStringSubmatch(sqlContent, -1)
	
	for _, match := range tableMatches {
		if len(match) < 3 {
			continue
		}
		
		tableName := match[1]
		columnsDef := match[2]
		
		// 创建表对象
		table := Table{
			Name:    tableName,
			Columns: []Column{},
		}
		
		// 解析列定义
		columnRegex := regexp.MustCompile(`(?i)["']?(\w+)["']?\s+(\w+)(?:\s+PRIMARY\s+KEY\s*)?`)
		columnMatches := columnRegex.FindAllStringSubmatch(columnsDef, -1)
		
		for _, colMatch := range columnMatches {
			if len(colMatch) < 3 {
				continue
			}
			
			colName := colMatch[1]
			colType := colMatch[2]
			
			// 检查是否为主键
			isPrimary := strings.Contains(strings.ToUpper(colMatch[0]), "PRIMARY KEY")
			
			// 添加列
			column := Column{
				Name:      colName,
				Type:      colType,
				IsPrimary: isPrimary,
				IsForeign: false, // 稍后处理外键
			}
			
			table.Columns = append(table.Columns, column)
		}
		
		// 解析外键
		fkRegex := regexp.MustCompile(`(?i)FOREIGN\s+KEY\s*\(\s*["']?(\w+)["']?\s*\)\s*REFERENCES\s+["']?(\w+)["']?\s*\(\s*["']?(\w+)["']?\s*\)`)
		fkMatches := fkRegex.FindAllStringSubmatch(columnsDef, -1)
		
		for _, fkMatch := range fkMatches {
			if len(fkMatch) < 4 {
				continue
			}
			
			sourceColumn := fkMatch[1]
			targetTable := fkMatch[2]
			targetColumn := fkMatch[3]
			
			// 添加外键关系
			foreignKey := ForeignKey{
				SourceTable:  tableName,
				SourceColumn: sourceColumn,
				TargetTable:  targetTable,
				TargetColumn: targetColumn,
			}
			
			schema.ForeignKeys = append(schema.ForeignKeys, foreignKey)
			
			// 标记列为外键
			for i, col := range table.Columns {
				if col.Name == sourceColumn {
					col.IsForeign = true
					table.Columns[i] = col
					break
				}
			}
		}
		
		schema.Tables = append(schema.Tables, table)
	}
	
	return schema, nil
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
