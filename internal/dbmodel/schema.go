package dbmodel

// Column 表示数据库表的列
type Column struct {
	Name      string `json:"column_name"`
	Type      string `json:"data_type"`
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
