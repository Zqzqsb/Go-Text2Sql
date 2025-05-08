package database

import (
	"database/sql"

	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// DBAdapter 数据库适配器接口，定义了所有数据库操作的统一接口
type DBAdapter interface {
	// 连接相关方法
	Connect(config DBConfig) (*sql.DB, error)
	GetConnectionString(config DBConfig) string
	
	// SQL处理相关方法
	AdaptSQL(query string) string  // 处理SQL方言差异
	
	// Schema相关方法
	LoadSchema(config DBConfig) (*dbmodel.DatabaseSchema, error)
}

// DBAdapterFactory 工厂类，根据数据库类型创建适配器
type DBAdapterFactory struct{}

// CreateAdapter 根据数据库类型创建适配器实例
func (f *DBAdapterFactory) CreateAdapter(dbType string) DBAdapter {
	switch dbType {
	case "sqlite", "sqlite3":
		return &SQLiteAdapter{}
	case "postgres", "postgresql":
		return &PostgreSQLAdapter{}
	default:
		// 默认使用SQLite
		return &SQLiteAdapter{}
	}
}
