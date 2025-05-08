package dbmodel

import "github.com/zqzqsb/gosql/internal/schema"

// SchemaToDBModel 将 schema.DatabaseSchema 转换为 dbmodel.DatabaseSchema
func SchemaToDBModel(src *schema.DatabaseSchema) *DatabaseSchema {
	if src == nil {
		return nil
	}
	
	dest := &DatabaseSchema{
		Tables:      make([]Table, len(src.Tables)),
		ForeignKeys: make([]ForeignKey, len(src.ForeignKeys)),
	}
	
	// 转换表
	for i, srcTable := range src.Tables {
		destTable := Table{
			Name:    srcTable.Name,
			Columns: make([]Column, len(srcTable.Columns)),
		}
		
		// 转换列
		for j, srcCol := range srcTable.Columns {
			destTable.Columns[j] = Column{
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
		dest.ForeignKeys[i] = ForeignKey{
			SourceTable:  srcFK.SourceTable,
			SourceColumn: srcFK.SourceColumn,
			TargetTable:  srcFK.TargetTable,
			TargetColumn: srcFK.TargetColumn,
		}
	}
	
	return dest
}

// DBModelToSchema 将 dbmodel.DatabaseSchema 转换为 schema.DatabaseSchema
func DBModelToSchema(src *DatabaseSchema) *schema.DatabaseSchema {
	if src == nil {
		return nil
	}
	
	dest := &schema.DatabaseSchema{
		Tables:      make([]schema.Table, len(src.Tables)),
		ForeignKeys: make([]schema.ForeignKey, len(src.ForeignKeys)),
	}
	
	// 转换表
	for i, srcTable := range src.Tables {
		destTable := schema.Table{
			Name:    srcTable.Name,
			Columns: make([]schema.Column, len(srcTable.Columns)),
		}
		
		// 转换列
		for j, srcCol := range srcTable.Columns {
			destTable.Columns[j] = schema.Column{
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
		dest.ForeignKeys[i] = schema.ForeignKey{
			SourceTable:  srcFK.SourceTable,
			SourceColumn: srcFK.SourceColumn,
			TargetTable:  srcFK.TargetTable,
			TargetColumn: srcFK.TargetColumn,
		}
	}
	
	return dest
}
