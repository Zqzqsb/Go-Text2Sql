package eval

import (
	"database/sql"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	_ "github.com/lib/pq"       // PostgreSQL驱动
	_ "github.com/mattn/go-sqlite3" // SQLite驱动
)

// ExecResult 表示SQL执行结果
type ExecResult struct {
	Success bool
	Error   string
	Rows    [][]string
}

// ExecSQL 执行SQL语句并返回结果
func ExecSQL(dbPath string, sqlQuery string) (*ExecResult, error) {
	var db *sql.DB
	var err error
	
	// 检查是否为PostgreSQL连接字符串
	if strings.HasPrefix(dbPath, "postgres://") || strings.HasPrefix(dbPath, "postgresql://") {
		// 使用PostgreSQL连接
		db, err = sql.Open("postgres", dbPath)
	} else if strings.Contains(dbPath, "ccsipder_pg") || strings.Contains(dbPath, "ccspider_pg") {
		// 使用默认PostgreSQL配置
		pgConfig := DefaultPGConfig()
		db, err = sql.Open("postgres", pgConfig.GetConnectionString())
	} else {
		// 默认使用SQLite连接
		db, err = sql.Open("sqlite3", dbPath)
	}

	if err != nil {
		return nil, fmt.Errorf("打开数据库连接失败: %w", err)
	}
	defer db.Close()
	
	// 测试连接
	if err = db.Ping(); err != nil {
		return nil, fmt.Errorf("无法连接到数据库: %w", err)
	}
	
	// 对PostgreSQL连接修复SQL语法差异
	if strings.HasPrefix(dbPath, "postgres://") || strings.HasPrefix(dbPath, "postgresql://") || 
	   strings.Contains(dbPath, "ccsipder_pg") || strings.Contains(dbPath, "ccspider_pg") {
		sqlQuery = fixSQLDialectDifferences(sqlQuery)
	}

	// 执行查询
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return &ExecResult{
			Success: false,
			Error:   err.Error(),
		}, nil
	}
	defer rows.Close()

	// 获取列名
	columns, err := rows.Columns()
	if err != nil {
		return nil, fmt.Errorf("获取列名失败: %w", err)
	}

	// 准备结果数据
	var result [][]string
	result = append(result, columns)

	// 读取行数据
	values := make([]interface{}, len(columns))
	valuePtrs := make([]interface{}, len(columns))
	for i := range columns {
		valuePtrs[i] = &values[i]
	}

	// 读取所有行
	for rows.Next() {
		err := rows.Scan(valuePtrs...)
		if err != nil {
			return nil, fmt.Errorf("读取行数据失败: %w", err)
		}

		// 转换为字符串
		var rowData []string
		for _, val := range values {
			var strVal string
			if val == nil {
				strVal = "NULL"
			} else {
				strVal = fmt.Sprintf("%v", val)
			}
			rowData = append(rowData, strVal)
		}
		result = append(result, rowData)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("遍历行数据失败: %w", err)
	}

	return &ExecResult{
		Success: true,
		Rows:    result,
	}, nil
}

// TestSuiteEval 使用test-suite-sql-eval评估SQL
func TestSuiteEval(pythonPath, evalScriptPath, goldSQL, predictSQL, dbDir, dbName string) (bool, string, error) {
	// 创建临时文件存储预测的SQL
	tmpDir, err := os.MkdirTemp("", "gosql-eval")
	if err != nil {
		return false, "", fmt.Errorf("创建临时目录失败: %w", err)
	}
	defer os.RemoveAll(tmpDir)

	// 写入预测的SQL到临时文件
	predictPath := filepath.Join(tmpDir, "predict.sql")
	if err := os.WriteFile(predictPath, []byte(predictSQL), 0644); err != nil {
		return false, "", fmt.Errorf("写入预测SQL失败: %w", err)
	}

	// 构建命令
	cmd := exec.Command(
		pythonPath,
		evalScriptPath,
		"--gold", goldSQL,
		"--pred", predictPath,
		"--db", filepath.Join(dbDir, dbName),
		"--etype", "all",
	)

	// 执行命令
	output, err := cmd.CombinedOutput()
	if err != nil {
		return false, string(output), fmt.Errorf("执行评估脚本失败: %w", err)
	}

	// 解析结果
	outputStr := string(output)
	success := strings.Contains(outputStr, "exact match: 1.0")

	return success, outputStr, nil
}

// FormatExecResult 格式化执行结果为字符串
func FormatExecResult(result *ExecResult) string {
	if !result.Success {
		return fmt.Sprintf("执行失败: %s", result.Error)
	}

	if len(result.Rows) == 0 {
		return "查询结果为空"
	}

	var builder strings.Builder
	builder.WriteString("查询结果:\n")

	// 计算每列的最大宽度
	colWidths := make([]int, len(result.Rows[0]))
	for _, row := range result.Rows {
		for i, cell := range row {
			if len(cell) > colWidths[i] {
				colWidths[i] = len(cell)
			}
		}
	}

	// 添加表头
	for i, col := range result.Rows[0] {
		builder.WriteString(fmt.Sprintf("| %-*s ", colWidths[i], col))
	}
	builder.WriteString("|\n")

	// 添加分隔线
	for i, width := range colWidths {
		builder.WriteString("+")
		for j := 0; j < width+2; j++ {
			builder.WriteString("-")
		}
		if i < len(colWidths)-1 {
			builder.WriteString("+")
		}
	}
	builder.WriteString("+\n")

	// 添加数据行
	for i := 1; i < len(result.Rows); i++ {
		for j, cell := range result.Rows[i] {
			builder.WriteString(fmt.Sprintf("| %-*s ", colWidths[j], cell))
		}
		builder.WriteString("|\n")
	}

	builder.WriteString(fmt.Sprintf("\n共 %d 行数据", len(result.Rows)-1))
	return builder.String()
}

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

// DefaultPGConfig 返回默认的PostgreSQL配置
func DefaultPGConfig() PostgreSQLConfig {
	return PostgreSQLConfig{
		Host:     "localhost",
		Port:     5432,
		User:     "postgres",
		Password: "password",
		DBName:   "hr",
		SSLMode:  "disable",
	}
}

// fixSQLDialectDifferences 修复SQLite和PostgreSQL之间的SQL语法差异
func fixSQLDialectDifferences(sqlQuery string) string {
	// 将SQLite的自增语法转换为PostgreSQL语法
	sqlQuery = strings.ReplaceAll(sqlQuery, "INTEGER PRIMARY KEY AUTOINCREMENT", "SERIAL PRIMARY KEY")

	// 将SQLite的日期函数转换为PostgreSQL函数
	sqlQuery = strings.ReplaceAll(sqlQuery, "DATETIME('now')", "CURRENT_TIMESTAMP")

	// 对Filter子句进行处理（PostgreSQL支持FILTER，但语法可能有差异）
	
	// 其他特定于数据库的语法调整可以在这里添加

	return sqlQuery
}
