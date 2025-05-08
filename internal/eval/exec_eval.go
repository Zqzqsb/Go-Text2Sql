package eval

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/zqzqsb/gosql/internal/database"
)

// ExecResult 表示SQL执行结果
type ExecResult struct {
	Success bool
	Error   string
	Rows    [][]string
}

// ExecSQL 执行SQL语句并返回结果
func ExecSQL(dbPath string, sqlQuery string) (*ExecResult, error) {
	// 创建DBExecutor实例
	executor := database.NewDBExecutor()
	
	// 通过抽象层执行SQL
	results, err := executor.ExecSQL(dbPath, sqlQuery)
	if err != nil {
		return &ExecResult{
			Success: false,
			Error:   err.Error(),
		}, nil
	}

	// 获取列名
	var columns []string
	if len(results) > 0 {
		columns = make([]string, 0, len(results[0]))
		for colName := range results[0] {
			columns = append(columns, colName)
		}
	} else {
		// 无结果
		return &ExecResult{
			Success: true,
			Rows:    [][]string{},
		}, nil
	}

	// 准备结果数据
	var resultRows [][]string
	resultRows = append(resultRows, columns) // 添加列名行

	// 处理每一行数据
	for _, row := range results {
		var rowData []string
		for _, colName := range columns {
			val := row[colName]
			var strVal string
			if val == nil {
				strVal = "NULL"
			} else {
				strVal = fmt.Sprintf("%v", val)
			}
			rowData = append(rowData, strVal)
		}
		resultRows = append(resultRows, rowData)
	}

	return &ExecResult{
		Success: true,
		Rows:    resultRows,
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

// 注意：下面的PostgreSQL配置相关代码已经移到internal/database包中
