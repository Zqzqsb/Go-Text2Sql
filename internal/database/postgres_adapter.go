package database

import (
	"database/sql"
	"fmt"
	"log"
	"regexp"
	"strings"

	_ "github.com/lib/pq" // PostgreSQL驱动

	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// PostgreSQLAdapter PostgreSQL数据库适配器
type PostgreSQLAdapter struct{}

// Connect 建立PostgreSQL数据库连接
func (a *PostgreSQLAdapter) Connect(config DBConfig) (*sql.DB, error) {
	pgConfig, ok := config.(*PostgreSQLConfig)
	if !ok {
		return nil, fmt.Errorf("无效的PostgreSQL配置类型")
	}

	// 建立连接
	connStr := pgConfig.GetConnectionString()
	return sql.Open("postgres", connStr)
}

// GetConnectionString 返回PostgreSQL连接字符串
func (a *PostgreSQLAdapter) GetConnectionString(config DBConfig) string {
	pgConfig, ok := config.(*PostgreSQLConfig)
	if !ok {
		return ""
	}
	return pgConfig.GetConnectionString()
}

// AdaptSQL 调整SQL方言，处理PostgreSQL特定语法
func (a *PostgreSQLAdapter) AdaptSQL(query string) string {
	// 如果是空查询，直接返回
	if strings.TrimSpace(query) == "" {
		return query
	}

	// 处理SQLite → PostgreSQL的语法差异
	
	// 1. INTEGER PRIMARY KEY AUTOINCREMENT → SERIAL PRIMARY KEY
	query = strings.Replace(
		query,
		"INTEGER PRIMARY KEY AUTOINCREMENT",
		"SERIAL PRIMARY KEY",
		-1,
	)
	query = strings.Replace(
		query,
		"integer primary key autoincrement",
		"SERIAL PRIMARY KEY",
		-1,
	)
	
	// 2. AUTOINCREMENT → SERIAL 编号相关
	query = strings.Replace(query, "AUTOINCREMENT", "SERIAL", -1)
	query = strings.Replace(query, "autoincrement", "SERIAL", -1)
	
	// 3. 处理PRAGMA
	if strings.Contains(query, "PRAGMA") || strings.Contains(query, "pragma") {
		return "SELECT 1" // PRAGMA语句在PostgreSQL中不支持，返回一个简单查询
	}
	
	// 4. 处理Date函数
	query = strings.Replace(query, "Date('", "'", -1) // Date('2021-01-01') -> '2021-01-01'
	query = strings.Replace(query, "')", "'", -1)    // 去除多余的括号
	
	// 5. 处理datetime函数
	query = strings.Replace(query, "datetime(", "to_timestamp(", -1)
	
	// 6. 处理LIKE区分大小写
	query = strings.Replace(query, " LIKE ", " ILIKE ", -1) // PostgreSQL中ILIKE不区分大小写
	
	// 7. 处理strftime -> EXTRACT
	// 两种常见模式：
	// A. strftime('%s', time1) - strftime('%s', time2) > X
	pattern1 := regexp.MustCompile(`(?i)strftime\('%s',\s*([^)]+)\)\s*-\s*strftime\('%s',\s*([^)]+)\)\s*>\s*(\d+)`)
	query = pattern1.ReplaceAllString(query, 
		"EXTRACT(EPOCH FROM $1::timestamp) - EXTRACT(EPOCH FROM $2::timestamp) > $3")
	
	// B. 日期时间函数差异处理 (strftime('%s') 单独出现的情况)
	query = strings.Replace(
		query, 
		"strftime('%s',", 
		"EXTRACT(EPOCH FROM ", 
		-1,
	)
	
	// 8. 处理时间差异计算 - 特别处理 time without time zone 类型
	// 对于 time 类型的列，需要特殊处理，当发现 check_in/check_out 这样的时间列时
	// 直接使用 interval 类型表示时间差
	timeColPattern := regexp.MustCompile(`\(([^.]*)\.(check_in|check_out|time)\s*-\s*([^.]*)\.(check_in|check_out|time)\)\s*>\s*'(\d+):(\d+):(\d+)'`)
	query = timeColPattern.ReplaceAllString(query,
		"($1.$2::time - $3.$4::time) > interval '$5 hours $6 minutes $7 seconds'")
	
	// 处理一般形式的时间差异计算
	timePattern := regexp.MustCompile(`\(([^)]+)\s*-\s*([^)]+)\)\s*>\s*'(\d+):(\d+):(\d+)'`)
	if !strings.Contains(query, "interval") && !strings.Contains(query, "INTERVAL") {
		query = timePattern.ReplaceAllStringFunc(query, func(match string) string {
			submatches := timePattern.FindStringSubmatch(match)
			if len(submatches) >= 6 {
				hours := submatches[3]
				minutes := submatches[4]
				seconds := submatches[5]
				return fmt.Sprintf("(%s - %s) > INTERVAL '%s hours %s minutes %s seconds'", 
					submatches[1], submatches[2], hours, minutes, seconds)
			}
			return match
		})
	}
	
	// 9. 处理时间格式 - 优化时间格式如 '10:30' -> '10:30:00'
	timeFormatRegex := regexp.MustCompile(`([=><])\s*'(\d+):(\d+)'`)
	query = timeFormatRegex.ReplaceAllString(query, "$1 '$2:$3:00'")
	
	return query
}

// LoadSchema 从PostgreSQL数据库加载Schema
func (a *PostgreSQLAdapter) LoadSchema(config DBConfig) (*dbmodel.DatabaseSchema, error) {
	pgConfig, ok := config.(*PostgreSQLConfig)
	if !ok {
		return nil, fmt.Errorf("无效的PostgreSQL配置类型")
	}
	
	// 连接到PostgreSQL数据库
	db, err := a.Connect(pgConfig)
	if err != nil {
		return nil, fmt.Errorf("连接PostgreSQL数据库失败: %w", err)
	}
	defer db.Close()
	
	// 初始化Schema
	dbSchema := &dbmodel.DatabaseSchema{
		Tables:      []dbmodel.Table{},
		ForeignKeys: []dbmodel.ForeignKey{},
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
		table := dbmodel.Table{
			Name:    tableName,
			Columns: []dbmodel.Column{},
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

			column := dbmodel.Column{
				Name:      colName,
				Type:      colType,
				IsPrimary: isPrimary,
				IsForeign: isForeign,
			}

			table.Columns = append(table.Columns, column)
		}
		colRows.Close()

		if len(table.Columns) > 0 {
			dbSchema.Tables = append(dbSchema.Tables, table)
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

		fk := dbmodel.ForeignKey{
			SourceTable:  sourceTable,
			SourceColumn: sourceColumn,
			TargetTable:  targetTable,
			TargetColumn: targetColumn,
		}

		dbSchema.ForeignKeys = append(dbSchema.ForeignKeys, fk)
	}

	if err := fkRows.Err(); err != nil {
		return nil, fmt.Errorf("遍历外键关系失败: %w", err)
	}
	
	// 记录加载信息
	log.Printf("从PostgreSQL数据库[%s]成功加载Schema，共%d张表", 
		pgConfig.DBName, len(dbSchema.Tables))
	
	return dbSchema, nil
}
