package database

import (
	"fmt"
	"path/filepath"
	"strings"
)

// DBConfig 数据库配置接口
type DBConfig interface {
	GetType() string     // 返回数据库类型
	GetDBName() string   // 返回数据库名称
}

// BaseDBConfig 基础数据库配置，实现DBConfig接口的基本功能
type BaseDBConfig struct {
	Type   string  // 数据库类型
	DBName string  // 数据库名称
}

// GetType 返回数据库类型
func (c *BaseDBConfig) GetType() string {
	return c.Type
}

// GetDBName 返回数据库名称
func (c *BaseDBConfig) GetDBName() string {
	return c.DBName
}

// SQLiteConfig SQLite配置
type SQLiteConfig struct {
	BaseDBConfig
	FilePath string  // 数据库文件路径
}

// PostgreSQLConfig PostgreSQL配置
type PostgreSQLConfig struct {
	BaseDBConfig
	Host     string
	Port     int
	User     string
	Password string
	SSLMode  string
}

// GetConnectionString 返回PostgreSQL连接字符串
func (c *PostgreSQLConfig) GetConnectionString() string {
	return fmt.Sprintf("postgres://%s:%s@%s:%d/%s?sslmode=%s",
		c.User, c.Password, c.Host, c.Port, c.DBName, c.SSLMode)
}

// DefaultPGConfig 返回默认的PostgreSQL配置
func DefaultPGConfig() *PostgreSQLConfig {
	return &PostgreSQLConfig{
		BaseDBConfig: BaseDBConfig{
			Type:   "postgres",
			DBName: "hr",
		},
		Host:     "localhost",
		Port:     5432,
		User:     "postgres",
		Password: "password",
		SSLMode:  "disable",
	}
}

// NewDBConfigFromPath 从路径创建适当的数据库配置
// 根据路径特征或显式指定数据库类型进行判断
func NewDBConfigFromPath(path string) DBConfig {
	// 显式识别PostgreSQL路径或URI
	if strings.HasPrefix(path, "pg:") || strings.HasPrefix(path, "postgres:") {
		// 处理类似 "pg:hr" 或 "postgres:hr" 这样的简化路径
		dbName := strings.TrimPrefix(strings.TrimPrefix(path, "pg:"), "postgres:")
		pgConfig := DefaultPGConfig()
		if dbName != "" {
			pgConfig.DBName = dbName
		}
		return pgConfig
	}

	// 检查是否为PostgreSQL连接URI
	if strings.HasPrefix(path, "postgres://") || strings.HasPrefix(path, "postgresql://") {
		pgConfig, err := ParsePostgresURI(path)
		if err == nil {
			return pgConfig
		}
		// 解析失败时使用默认配置
		fmt.Printf("警告: PostgreSQL URI 解析失败: %v\n", err)
		return DefaultPGConfig()
	}
	
	// 根据目录名特征判断
	if strings.Contains(path, "ccsipder_pg") || strings.Contains(path, "ccspider_pg") ||
		strings.Contains(path, "pg_hr") || strings.Contains(path, "postgres_") {
		pgConfig := DefaultPGConfig()
		// 从路径中提取数据库名
		dbName := filepath.Base(path)
		if dbName != "" && dbName != "." {
			pgConfig.DBName = dbName
		}
		return pgConfig
	}
	
	// 默认视为SQLite文件路径
	return &SQLiteConfig{
		BaseDBConfig: BaseDBConfig{
			Type:   "sqlite",
			DBName: filepath.Base(filepath.Dir(path)),
		},
		FilePath: path,
	}
}

// ParsePostgresURI 解析PostgreSQL URI并创建配置
func ParsePostgresURI(uri string) (*PostgreSQLConfig, error) {
	// 移除前缀
	uri = strings.TrimPrefix(uri, "postgres://")
	uri = strings.TrimPrefix(uri, "postgresql://")
	
	// 解析用户名和密码与主机部分
	parts := strings.Split(uri, "@")
	if len(parts) != 2 {
		return nil, fmt.Errorf("无效的PostgreSQL URI格式")
	}
	
	userPart := parts[0]
	hostPart := parts[1]
	
	// 解析用户名和密码
	userParts := strings.Split(userPart, ":")
	if len(userParts) != 2 {
		return nil, fmt.Errorf("无效的用户凭证格式")
	}
	user := userParts[0]
	password := userParts[1]
	
	// 解析主机、端口和数据库名
	hostParts := strings.Split(hostPart, "/")
	if len(hostParts) < 2 {
		return nil, fmt.Errorf("无效的主机信息格式")
	}
	
	hostPortParts := strings.Split(hostParts[0], ":")
	host := hostPortParts[0]
	port := 5432 // 默认端口
	if len(hostPortParts) > 1 {
		fmt.Sscanf(hostPortParts[1], "%d", &port)
	}
	
	// 解析数据库名和参数
	dbNameParts := strings.Split(hostParts[1], "?")
	dbName := dbNameParts[0]
	
	sslMode := "disable" // 默认禁用SSL
	if len(dbNameParts) > 1 {
		params := strings.Split(dbNameParts[1], "&")
		for _, param := range params {
			if strings.HasPrefix(param, "sslmode=") {
				sslMode = strings.TrimPrefix(param, "sslmode=")
				break
			}
		}
	}
	
	return &PostgreSQLConfig{
		BaseDBConfig: BaseDBConfig{
			Type:   "postgres",
			DBName: dbName,
		},
		Host:     host,
		Port:     port,
		User:     user,
		Password: password,
		SSLMode:  sslMode,
	}, nil
}
