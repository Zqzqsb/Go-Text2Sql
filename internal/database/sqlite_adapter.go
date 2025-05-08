package database

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"

	_ "github.com/mattn/go-sqlite3" // SQLite驱动

	"github.com/zqzqsb/gosql/internal/dbmodel"
	"github.com/zqzqsb/gosql/internal/schema"
)

// SQLiteAdapter SQLite数据库适配器
type SQLiteAdapter struct{}

// Connect 建立SQLite数据库连接
func (a *SQLiteAdapter) Connect(config DBConfig) (*sql.DB, error) {
	sqliteConfig, ok := config.(*SQLiteConfig)
	if !ok {
		return nil, fmt.Errorf("无效的SQLite配置类型")
	}

	// 检查文件是否存在
	if _, err := os.Stat(sqliteConfig.FilePath); os.IsNotExist(err) {
		return nil, fmt.Errorf("SQLite数据库文件不存在: %s", sqliteConfig.FilePath)
	}

	// 建立连接
	return sql.Open("sqlite3", sqliteConfig.FilePath)
}

// GetConnectionString 返回SQLite连接字符串
func (a *SQLiteAdapter) GetConnectionString(config DBConfig) string {
	sqliteConfig, ok := config.(*SQLiteConfig)
	if !ok {
		return ""
	}
	return sqliteConfig.FilePath
}

// AdaptSQL 调整SQL方言，处理SQLite特定语法
func (a *SQLiteAdapter) AdaptSQL(query string) string {
	// SQLite不需要特殊处理，作为基础方言
	return query
}

// LoadSchema 从数据库加载Schema
func (a *SQLiteAdapter) LoadSchema(config DBConfig) (*dbmodel.DatabaseSchema, error) {
	sqliteConfig, ok := config.(*SQLiteConfig)
	if !ok {
		return nil, fmt.Errorf("无效的SQLite配置类型")
	}

	// 数据库目录
	dbDir := filepath.Dir(sqliteConfig.FilePath)
	
	// 优先使用JSON加载器，这借用了之前实现的JSON Schema加载机制
	// 找出顶级数据集目录
	datasetDir := filepath.Dir(filepath.Dir(dbDir))
	jsonFiles, err := schema.FindJSONSchemaFiles(datasetDir)
	
	if err == nil && len(jsonFiles) > 0 {
		schemas, err := schema.LoadTablesFromJSON(jsonFiles)
		if err == nil {
			// 从路径中提取数据库ID
			dbID := sqliteConfig.GetDBName()
			if schemaGraph, ok := schemas[dbID]; ok {
				// 先转换为schema.DatabaseSchema
				schemaDB := schema.ConvertToDBSchema(schemaGraph)
				// 再转换为dbmodel.DatabaseSchema
				return convertSchemaToDBModel(schemaDB), nil
			}
		}
	}
	
	// 如果JSON加载失败，尝试读取schema.json文件
	schemaPath := filepath.Join(dbDir, "schema.json")
	_, err = os.Stat(schemaPath)
	
	// 如果schema.json不存在，尝试读取schema.sql文件
	if os.IsNotExist(err) {
		sqlSchemaPath := filepath.Join(dbDir, "schema.sql")
		// 先载入为schema.DatabaseSchema类型
		schemaDB, err := a.loadSchemaFromSQL(sqlSchemaPath)
		if err != nil {
			return nil, err
		}
		// 转换为dbmodel.DatabaseSchema
		return convertSchemaToDBModel(schemaDB), nil
	} else if err != nil {
		return nil, fmt.Errorf("读取Schema文件失败: %w", err)
	}
	
	// 从schema.json读取
	data, err := os.ReadFile(schemaPath)
	if err != nil {
		return nil, fmt.Errorf("读取Schema文件失败: %w", err)
	}
	// 解析JSON
	// 先解析为schema.DatabaseSchema类型
	schemaDB, err := parseSchemaJSON(data)
	if err != nil {
		return nil, err
	}
	// 转换为dbmodel.DatabaseSchema
	return convertSchemaToDBModel(schemaDB), nil
}

// loadSchemaFromSQL 从SQL文件加载Schema
func (a *SQLiteAdapter) loadSchemaFromSQL(sqlFilePath string) (*schema.DatabaseSchema, error) {
	// 读取SQL文件
	data, err := os.ReadFile(sqlFilePath)
	if err != nil {
		return nil, fmt.Errorf("读取SQL Schema文件失败: %w", err)
	}
	
	sqlContent := string(data)
	
	// 创建Schema对象
	dbSchema := &schema.DatabaseSchema{
		Tables:      []schema.Table{},
		ForeignKeys: []schema.ForeignKey{},
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
		table := schema.Table{
			Name:    tableName,
			Columns: []schema.Column{},
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
			column := schema.Column{
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
			foreignKey := schema.ForeignKey{
				SourceTable:  tableName,
				SourceColumn: sourceColumn,
				TargetTable:  targetTable,
				TargetColumn: targetColumn,
			}
			
			dbSchema.ForeignKeys = append(dbSchema.ForeignKeys, foreignKey)
			
			// 标记列为外键
			for i, col := range table.Columns {
				if col.Name == sourceColumn {
					col.IsForeign = true
					table.Columns[i] = col
					break
				}
			}
		}
		
		dbSchema.Tables = append(dbSchema.Tables, table)
	}
	
	return dbSchema, nil
}

// convertSchemaToDBModel 将schema.DatabaseSchema转换为dbmodel.DatabaseSchema
func convertSchemaToDBModel(src *schema.DatabaseSchema) *dbmodel.DatabaseSchema {
	if src == nil {
		return nil
	}
	
	dest := &dbmodel.DatabaseSchema{
		Tables:      make([]dbmodel.Table, len(src.Tables)),
		ForeignKeys: make([]dbmodel.ForeignKey, len(src.ForeignKeys)),
	}
	
	// 转换表
	for i, srcTable := range src.Tables {
		destTable := dbmodel.Table{
			Name:    srcTable.Name,
			Columns: make([]dbmodel.Column, len(srcTable.Columns)),
		}
		
		// 转换列
		for j, srcCol := range srcTable.Columns {
			destTable.Columns[j] = dbmodel.Column{
				Name:      srcCol.Name,
				Type:      srcCol.Type,
				IsPrimary: srcCol.IsPrimary,
				IsForeign: srcCol.IsForeign,
			}
		}
		
		dest.Tables[i] = destTable
	}
	
	// 转换外键
	for i, srcFK := range src.ForeignKeys {
		dest.ForeignKeys[i] = dbmodel.ForeignKey{
			SourceTable:  srcFK.SourceTable,
			SourceColumn: srcFK.SourceColumn,
			TargetTable:  srcFK.TargetTable,
			TargetColumn: srcFK.TargetColumn,
		}
	}
	
	return dest
}

// convertSchemaGraphToDBSchema 将SchemaGraph转换为DatabaseSchema
func convertSchemaGraphToDBSchema(graph *schema.SchemaGraph) *schema.DatabaseSchema {
	dbSchema := &schema.DatabaseSchema{
		Tables:      []schema.Table{},
		ForeignKeys: []schema.ForeignKey{},
	}

	// 转换表
	for _, schemaTable := range graph.Tables {
		table := schema.Table{
			Name:    schemaTable.OrigName,
			Columns: []schema.Column{},
		}

		// 转换列
		for _, schemaCol := range schemaTable.Columns {
			// 检查是否为主键
			isPrimary := false
			for _, pk := range schemaTable.PrimaryKeys {
				if pk.ID == schemaCol.ID {
					isPrimary = true
					break
				}
			}

			column := schema.Column{
				Name:     schemaCol.OrigName,
				Type:     schemaCol.Type,
				IsPrimary: isPrimary,
				IsForeign: false, // 稍后处理外键
			}
			table.Columns = append(table.Columns, column)
		}

		dbSchema.Tables = append(dbSchema.Tables, table)
	}

	// 转换外键
	for sourceTableID, targetTables := range graph.ForeignKeys {
		for targetTableID, pairs := range targetTables {
			for _, pair := range pairs {
				sourceColumnID := pair[0]
				targetColumnID := pair[1]

				sourceColumn := graph.Columns[sourceColumnID]
				targetColumn := graph.Columns[targetColumnID]

				// 添加外键关系
				foreignKey := schema.ForeignKey{
					SourceTable:  graph.Tables[sourceTableID].OrigName,
					SourceColumn: sourceColumn.OrigName,
					TargetTable:  graph.Tables[targetTableID].OrigName,
					TargetColumn: targetColumn.OrigName,
				}

				dbSchema.ForeignKeys = append(dbSchema.ForeignKeys, foreignKey)

				// 标记列为外键
				for i, table := range dbSchema.Tables {
					if table.Name == foreignKey.SourceTable {
						for j, col := range table.Columns {
							if col.Name == foreignKey.SourceColumn {
								col.IsForeign = true
								table.Columns[j] = col
								break
							}
						}
						dbSchema.Tables[i] = table
						break
					}
				}
			}
		}
	}

	return dbSchema
}

// parseSchemaJSON 解析JSON格式的Schema
func parseSchemaJSON(data []byte) (*schema.DatabaseSchema, error) {
	type rawColumn struct {
		Name      string `json:"name"`
		Type      string `json:"type"`
		IsPrimary bool   `json:"is_primary"`
		IsForeign bool   `json:"is_foreign"`
	}

	type rawTable struct {
		Name    string      `json:"name"`
		Columns []rawColumn `json:"columns"`
	}

	type rawForeignKey struct {
		SourceTable  string `json:"source_table"`
		SourceColumn string `json:"source_column"`
		TargetTable  string `json:"target_table"`
		TargetColumn string `json:"target_column"`
	}

	type rawSchema struct {
		Tables      []rawTable      `json:"tables"`
		ForeignKeys []rawForeignKey `json:"foreign_keys"`
	}

	// 解析JSON数据
	var raw rawSchema
	if err := json.Unmarshal(data, &raw); err != nil {
		return nil, fmt.Errorf("解析Schema JSON失败: %w", err)
	}

	// 创建Schema
	dbSchema := &schema.DatabaseSchema{
		Tables:      []schema.Table{},
		ForeignKeys: []schema.ForeignKey{},
	}

	// 转换表和列
	for _, rawTable := range raw.Tables {
		table := schema.Table{
			Name:    rawTable.Name,
			Columns: []schema.Column{},
		}

		for _, rawCol := range rawTable.Columns {
			col := schema.Column{
				Name:      rawCol.Name,
				Type:      rawCol.Type,
				IsPrimary: rawCol.IsPrimary,
				IsForeign: rawCol.IsForeign,
			}
			table.Columns = append(table.Columns, col)
		}

		dbSchema.Tables = append(dbSchema.Tables, table)
	}

	// 转换外键
	for _, rawFK := range raw.ForeignKeys {
		fk := schema.ForeignKey{
			SourceTable:  rawFK.SourceTable,
			SourceColumn: rawFK.SourceColumn,
			TargetTable:  rawFK.TargetTable,
			TargetColumn: rawFK.TargetColumn,
		}
		dbSchema.ForeignKeys = append(dbSchema.ForeignKeys, fk)
	}

	return dbSchema, nil
}
