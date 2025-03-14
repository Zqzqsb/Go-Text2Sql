package eval

import (
	"database/sql"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

// ExecResult 表示SQL执行结果
type ExecResult struct {
	Success bool
	Error   string
	Rows    [][]string
}

// ExecSQL 执行SQL语句并返回结果
func ExecSQL(dbPath string, sqlQuery string) (*ExecResult, error) {
	// 打开数据库连接
	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		return nil, fmt.Errorf("打开数据库连接失败: %w", err)
	}
	defer db.Close()

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
