package schema

import (
	"database/sql"
	"fmt"
	"strings"

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

// LoadSchemaFromPostgres 从PostgreSQL数据库加载数据库Schema
func LoadSchemaFromPostgres(config *PostgreSQLConfig) (*DatabaseSchema, error) {
	// 获取连接字符串
	connString := config.GetConnectionString()

	// 打开数据库连接
	db, err := sql.Open("postgres", connString)
	if err != nil {
		return nil, fmt.Errorf("连接PostgreSQL数据库失败: %w", err)
	}
	defer db.Close()

	// 测试连接
	if err = db.Ping(); err != nil {
		return nil, fmt.Errorf("无法连接到PostgreSQL: %w", err)
	}

	// 初始化Schema
	schema := &DatabaseSchema{
		Tables:      []Table{},
		ForeignKeys: []ForeignKey{},
	}

	// 查询所有表（仅限public模式）
	tableRows, err := db.Query(`
		SELECT table_name 
		FROM information_schema.tables 
		WHERE table_schema = 'public'
		  AND table_type = 'BASE TABLE'
		ORDER BY table_name
	`)
	if err != nil {
		return nil, fmt.Errorf("查询表信息失败: %w", err)
	}
	defer tableRows.Close()

	// 处理表信息
	var tableNames []string
	for tableRows.Next() {
		var tableName string
		if err := tableRows.Scan(&tableName); err != nil {
			return nil, fmt.Errorf("读取表名失败: %w", err)
		}
		tableNames = append(tableNames, tableName)
	}

	if err := tableRows.Err(); err != nil {
		return nil, fmt.Errorf("遍历表信息失败: %w", err)
	}

	// 对每个表查询列信息
	for _, tableName := range tableNames {
		table := Table{
			Name:    tableName,
			Columns: []Column{},
		}

		// 查询列信息
		colRows, err := db.Query(`
			SELECT c.column_name, c.data_type, 
				   CASE WHEN pk.column_name IS NOT NULL THEN true ELSE false END AS is_primary,
				   CASE WHEN fk.column_name IS NOT NULL THEN true ELSE false END AS is_foreign
			FROM information_schema.columns c
			LEFT JOIN (
				SELECT kcu.column_name
				FROM information_schema.table_constraints tc
				JOIN information_schema.key_column_usage kcu
					ON tc.constraint_name = kcu.constraint_name
				WHERE tc.constraint_type = 'PRIMARY KEY'
					AND tc.table_schema = 'public'
					AND tc.table_name = $1
			) pk ON c.column_name = pk.column_name
			LEFT JOIN (
				SELECT kcu.column_name
				FROM information_schema.table_constraints tc
				JOIN information_schema.key_column_usage kcu
					ON tc.constraint_name = kcu.constraint_name
				WHERE tc.constraint_type = 'FOREIGN KEY'
					AND tc.table_schema = 'public'
					AND tc.table_name = $1
			) fk ON c.column_name = fk.column_name
			WHERE c.table_schema = 'public'
				AND c.table_name = $1
			ORDER BY c.ordinal_position
		`, tableName)

		if err != nil {
			return nil, fmt.Errorf("查询表%s的列信息失败: %w", tableName, err)
		}

		for colRows.Next() {
			var colName, colType string
			var isPrimary, isForeign bool

			if err := colRows.Scan(&colName, &colType, &isPrimary, &isForeign); err != nil {
				colRows.Close()
				return nil, fmt.Errorf("读取列信息失败: %w", err)
			}

			column := Column{
				Name:      colName,
				Type:      colType,
				IsPrimary: isPrimary,
				IsForeign: isForeign,
			}

			table.Columns = append(table.Columns, column)
		}
		colRows.Close()

		if len(table.Columns) > 0 {
			schema.Tables = append(schema.Tables, table)
		}
	}

	// 查询外键关系
	fkRows, err := db.Query(`
		SELECT
			tc.table_name AS source_table,
			kcu.column_name AS source_column,
			ccu.table_name AS target_table,
			ccu.column_name AS target_column
		FROM information_schema.table_constraints tc
		JOIN information_schema.key_column_usage kcu
			ON tc.constraint_name = kcu.constraint_name
			AND tc.table_schema = kcu.table_schema
		JOIN information_schema.constraint_column_usage ccu
			ON tc.constraint_name = ccu.constraint_name
			AND tc.table_schema = ccu.table_schema
		WHERE tc.constraint_type = 'FOREIGN KEY'
			AND tc.table_schema = 'public'
		ORDER BY tc.table_name, kcu.column_name
	`)

	if err != nil {
		return nil, fmt.Errorf("查询外键关系失败: %w", err)
	}
	defer fkRows.Close()

	for fkRows.Next() {
		var sourceTable, sourceColumn, targetTable, targetColumn string
		if err := fkRows.Scan(&sourceTable, &sourceColumn, &targetTable, &targetColumn); err != nil {
			return nil, fmt.Errorf("读取外键关系失败: %w", err)
		}

		fk := ForeignKey{
			SourceTable:  sourceTable,
			SourceColumn: sourceColumn,
			TargetTable:  targetTable,
			TargetColumn: targetColumn,
		}

		schema.ForeignKeys = append(schema.ForeignKeys, fk)
	}

	if err := fkRows.Err(); err != nil {
		return nil, fmt.Errorf("遍历外键关系失败: %w", err)
	}

	return schema, nil
}

// IsPostgresURI 检查给定的路径是否为PostgreSQL连接URI
func IsPostgresURI(path string) bool {
	return strings.HasPrefix(path, "postgres://") || 
		   strings.HasPrefix(path, "postgresql://")
}

// ParsePostgresURI 解析PostgreSQL连接URI
func ParsePostgresURI(uri string) (*PostgreSQLConfig, error) {
	// 简单解析，实际项目中可能需要更复杂的处理
	uri = strings.TrimPrefix(uri, "postgres://")
	uri = strings.TrimPrefix(uri, "postgresql://")
	
	// 分离用户信息和主机信息
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
		var err error
		_, err = fmt.Sscanf(hostPortParts[1], "%d", &port)
		if err != nil {
			return nil, fmt.Errorf("无效的端口号: %w", err)
		}
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
		Host:     host,
		Port:     port,
		User:     user,
		Password: password,
		DBName:   dbName,
		SSLMode:  sslMode,
	}, nil
}
