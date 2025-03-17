package schema

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
)

// SchemaDict 表示从JSON文件加载的原始schema字典
type SchemaDict struct {
	DBID             string     `json:"db_id"`
	TableNames       []string   `json:"table_names"`
	TableNamesOrig   []string   `json:"table_names_original"`
	ColumnNames      [][]any    `json:"column_names"`      // [[table_id, column_name], ...]
	ColumnNamesOrig  [][]any    `json:"column_names_original"`
	ColumnTypes      []string   `json:"column_types"`
	PrimaryKeys      []int      `json:"primary_keys"`
	ForeignKeys      [][]int    `json:"foreign_keys"`      // [[source_column_id, target_column_id], ...]
}

// TableInfo 表示表的信息
type TableInfo struct {
	ID        int
	Name      string
	OrigName  string
	Columns   []*ColumnInfo
	PrimaryKeys []*ColumnInfo
}

// ColumnInfo 表示列的信息
type ColumnInfo struct {
	ID        int
	Table     *TableInfo
	Name      string
	OrigName  string
	Type      string
	ForeignKeyFor *ColumnInfo
}

// SchemaGraph 表示从JSON文件加载的schema图
type SchemaGraph struct {
	DBID        string
	Tables      []*TableInfo
	Columns     []*ColumnInfo
	ForeignKeys map[int]map[int][][]int // source_table_id -> target_table_id -> [(source_col_id, target_col_id), ...]
	RawSchema   *SchemaDict
}

// LoadTablesFromJSON 从JSON文件加载数据库schema
func LoadTablesFromJSON(paths []string) (map[string]*SchemaGraph, error) {
	schemas := make(map[string]*SchemaGraph)

	for _, path := range paths {
		data, err := os.ReadFile(path)
		if err != nil {
			return nil, fmt.Errorf("读取schema JSON文件失败: %w", err)
		}

		var schemaDicts []SchemaDict
		if err := json.Unmarshal(data, &schemaDicts); err != nil {
			return nil, fmt.Errorf("解析schema JSON文件失败: %w", err)
		}

		for _, schemaDict := range schemaDicts {
			// 创建表
			tables := make([]*TableInfo, len(schemaDict.TableNames))
			for i := range schemaDict.TableNames {
				tables[i] = &TableInfo{
					ID:       i,
					Name:     schemaDict.TableNames[i],
					OrigName: schemaDict.TableNamesOrig[i],
					Columns:  make([]*ColumnInfo, 0),
				}
			}

			// 创建列
			columns := make([]*ColumnInfo, len(schemaDict.ColumnNames))
			for i := range schemaDict.ColumnNames {
				tableID, ok := schemaDict.ColumnNames[i][0].(float64)
				if !ok {
					return nil, fmt.Errorf("无效的表ID类型: %T", schemaDict.ColumnNames[i][0])
				}
				
				colName, ok := schemaDict.ColumnNames[i][1].(string)
				if !ok {
					return nil, fmt.Errorf("无效的列名类型: %T", schemaDict.ColumnNames[i][1])
				}
				
				origColName, ok := schemaDict.ColumnNamesOrig[i][1].(string)
				if !ok {
					return nil, fmt.Errorf("无效的原始列名类型: %T", schemaDict.ColumnNamesOrig[i][1])
				}

				var table *TableInfo
				if int(tableID) >= 0 {
					table = tables[int(tableID)]
				}

				column := &ColumnInfo{
					ID:       i,
					Table:    table,
					Name:     colName,
					OrigName: origColName,
					Type:     schemaDict.ColumnTypes[i],
				}
				
				columns[i] = column
				
				// 将列关联到表
				if table != nil {
					table.Columns = append(table.Columns, column)
				}
			}

			// 设置主键
			for _, columnID := range schemaDict.PrimaryKeys {
				column := columns[columnID]
				if column.Table != nil {
					column.Table.PrimaryKeys = append(column.Table.PrimaryKeys, column)
				}
			}

			// 设置外键
			foreignKeyGraph := make(map[int]map[int][][]int)
			for _, fk := range schemaDict.ForeignKeys {
				sourceColumnID := fk[0]
				targetColumnID := fk[1]
				
				sourceColumn := columns[sourceColumnID]
				targetColumn := columns[targetColumnID]
				
				sourceColumn.ForeignKeyFor = targetColumn
				
				sourceTableID := sourceColumn.Table.ID
				targetTableID := targetColumn.Table.ID
				
				if _, ok := foreignKeyGraph[sourceTableID]; !ok {
					foreignKeyGraph[sourceTableID] = make(map[int][][]int)
				}
				
				if _, ok := foreignKeyGraph[sourceTableID][targetTableID]; !ok {
					foreignKeyGraph[sourceTableID][targetTableID] = make([][]int, 0)
				}
				
				foreignKeyGraph[sourceTableID][targetTableID] = append(
					foreignKeyGraph[sourceTableID][targetTableID],
					[]int{sourceColumnID, targetColumnID},
				)
				
				if _, ok := foreignKeyGraph[targetTableID]; !ok {
					foreignKeyGraph[targetTableID] = make(map[int][][]int)
				}
				
				if _, ok := foreignKeyGraph[targetTableID][sourceTableID]; !ok {
					foreignKeyGraph[targetTableID][sourceTableID] = make([][]int, 0)
				}
				
				foreignKeyGraph[targetTableID][sourceTableID] = append(
					foreignKeyGraph[targetTableID][sourceTableID],
					[]int{targetColumnID, sourceColumnID},
				)
			}

			// 创建schema图
			schemaGraph := &SchemaGraph{
				DBID:        schemaDict.DBID,
				Tables:      tables,
				Columns:     columns,
				ForeignKeys: foreignKeyGraph,
				RawSchema:   &schemaDict,
			}
			
			schemas[schemaDict.DBID] = schemaGraph
		}
	}

	return schemas, nil
}

// ConvertToDBSchema 将SchemaGraph转换为DatabaseSchema
func ConvertToDBSchema(schemaGraph *SchemaGraph) *DatabaseSchema {
	dbSchema := &DatabaseSchema{
		Tables:      make([]Table, len(schemaGraph.Tables)),
		ForeignKeys: make([]ForeignKey, 0),
	}

	// 转换表和列
	for i, tableInfo := range schemaGraph.Tables {
		table := Table{
			Name:    tableInfo.OrigName,
			Columns: make([]Column, len(tableInfo.Columns)),
		}

		for j, columnInfo := range tableInfo.Columns {
			isPrimary := false
			for _, pk := range tableInfo.PrimaryKeys {
				if pk.ID == columnInfo.ID {
					isPrimary = true
					break
				}
			}

			isForeign := columnInfo.ForeignKeyFor != nil

			table.Columns[j] = Column{
				Name:      columnInfo.OrigName,
				Type:      columnInfo.Type,
				IsPrimary: isPrimary,
				IsForeign: isForeign,
			}
		}

		dbSchema.Tables[i] = table
	}

	// 转换外键
	for sourceTableID, targetTables := range schemaGraph.ForeignKeys {
		for targetTableID, columnPairs := range targetTables {
			for _, pair := range columnPairs {
				sourceColumnID := pair[0]
				targetColumnID := pair[1]

				sourceColumn := schemaGraph.Columns[sourceColumnID]
				targetColumn := schemaGraph.Columns[targetColumnID]

				// 只添加一个方向的外键关系
				if sourceTableID < targetTableID {
					fk := ForeignKey{
						SourceTable:  schemaGraph.Tables[sourceTableID].OrigName,
						SourceColumn: sourceColumn.OrigName,
						TargetTable:  schemaGraph.Tables[targetTableID].OrigName,
						TargetColumn: targetColumn.OrigName,
					}
					dbSchema.ForeignKeys = append(dbSchema.ForeignKeys, fk)
				}
			}
		}
	}

	return dbSchema
}

// FindJSONSchemaFiles 查找指定目录下的所有schema.json文件
func FindJSONSchemaFiles(datasetDir string) ([]string, error) {
	var files []string

	// 查找tables.json文件
	tablesPath := filepath.Join(datasetDir, "tables.json")
	if _, err := os.Stat(tablesPath); err == nil {
		files = append(files, tablesPath)
		return files, nil
	}

	// 查找spider目录下的tables.json
	spiderTablesPath := filepath.Join(datasetDir, "spider", "tables.json")
	if _, err := os.Stat(spiderTablesPath); err == nil {
		files = append(files, spiderTablesPath)
	}

	// 查找cspider目录下的tables.json
	cspiderTablesPath := filepath.Join(datasetDir, "cspider", "tables.json")
	if _, err := os.Stat(cspiderTablesPath); err == nil {
		files = append(files, cspiderTablesPath)
	}

	return files, nil
}
