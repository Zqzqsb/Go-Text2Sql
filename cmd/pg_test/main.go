package main

import (
	"database/sql"
	"fmt"
	"os"
	"path/filepath"

	_ "github.com/lib/pq" // PostgreSQL驱动
)

// PostgreSQLConfig 定义PostgreSQL连接配置
type PostgreSQLConfig struct {
	Host     string
	Port     int
	User     string
	Password string
	DBName   string
	SSLMode  string
}

// GetConnectionString 返回PostgreSQL连接字符串
func (c *PostgreSQLConfig) GetConnectionString() string {
	return fmt.Sprintf("postgres://%s:%s@%s:%d/%s?sslmode=%s", 
		c.User, c.Password, c.Host, c.Port, c.DBName, c.SSLMode)
}

// DefaultPGConfig 返回默认的PostgreSQL配置（连接到本地Docker）
func DefaultPGConfig() *PostgreSQLConfig {
	return &PostgreSQLConfig{
		Host:     "localhost",
		Port:     5432,
		User:     "postgres",
		Password: "password",
		DBName:   "nl2sql",
		SSLMode:  "disable",
	}
}

func main() {
	// 测试PostgreSQL连接
	fmt.Println("测试PostgreSQL连接...")
	
	// 默认PostgreSQL配置
	pgConfig := DefaultPGConfig()
	fmt.Printf("PostgreSQL连接: %s\n", pgConfig.GetConnectionString())
	
	// 连接到PostgreSQL
	db, err := sql.Open("postgres", pgConfig.GetConnectionString())
	if err != nil {
		fmt.Printf("打开PostgreSQL连接失败: %v\n", err)
		os.Exit(1)
	}
	defer db.Close()
	
	// 测试连接
	if err = db.Ping(); err != nil {
		fmt.Printf("无法连接到PostgreSQL: %v\n", err)
		os.Exit(1)
	}
	fmt.Println("成功连接到PostgreSQL!")
	
	// 测试执行SQL查询
	testQuery := "SELECT version();"
	var version string
	err = db.QueryRow(testQuery).Scan(&version)
	if err != nil {
		fmt.Printf("查询版本失败: %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("PostgreSQL版本: %s\n", version)
	
	// 数据目录
	dataDir := filepath.Join(os.Getenv("HOME"), "Projects", "GoProjects", "GoSql", "data", "ccsipder_pg")
	fmt.Printf("\n数据目录: %s\n", dataDir)
	fmt.Printf("当PostgreSQL容器运行时，可以通过以下命令进行测试:\n")
	fmt.Printf("go run cmd/predict/main.go --dir=%s --model=deepseek-v3-241226\n", dataDir)
}
