package eval

import (
	"strings"
	"testing"
)

// TestExecSQL 测试SQL执行功能
func TestExecSQL(t *testing.T) {
	// 使用Spider数据集中的restaurant_1数据库
	dbPath := "/home/zq/Projects/BackupProjects/AI/GoSql/data/spider/database/restaurant_1/restaurant_1.sqlite"

	// 测试用例
	tests := []struct {
		name     string
		sql      string
		wantRows int
		wantErr  bool
	}{
		{
			name:     "查询所有餐厅",
			sql:      "SELECT * FROM Restaurant",
			wantRows: 2,
			wantErr:  false,
		},
		{
			name:     "查询评分最高的餐厅",
			sql:      "SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC LIMIT 3",
			wantRows: 2,
			wantErr:  false,
		},
		{
			name:     "多表连接查询",
			sql:      "SELECT s.Fname, s.LName, r.ResName, v.Spent FROM Student s JOIN Visits_Restaurant v ON s.StuID = v.StuID JOIN Restaurant r ON v.ResID = r.ResID ORDER BY v.Spent DESC",
			wantRows: 2,
			wantErr:  false,
		},
		{
			name:     "分组聚合查询",
			sql:      "SELECT rt.ResTypeName, COUNT(*) as count FROM Restaurant r JOIN Type_Of_Restaurant tor ON r.ResID = tor.ResID JOIN Restaurant_Type rt ON tor.ResTypeID = rt.ResTypeID GROUP BY rt.ResTypeName",
			wantRows: 2,
			wantErr:  false,
		},
		{
			name:     "查询不存在的表",
			sql:      "SELECT * FROM NonExistentTable",
			wantRows: 0,
			wantErr:  true,
		},
		{
			name:     "语法错误的SQL",
			sql:      "SELEC * FROM Restaurant",
			wantRows: 0,
			wantErr:  true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result, err := ExecSQL(dbPath, tt.sql)
			
			// 检查错误情况
			if (err != nil) != tt.wantErr && (result != nil && !result.Success) != tt.wantErr {
				t.Errorf("ExecSQL() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			
			// 如果预期有错误，不进行后续检查
			if tt.wantErr {
				return
			}
			
			// 检查结果行数（减去表头行）
			if len(result.Rows)-1 != tt.wantRows {
				t.Errorf("ExecSQL() got %d rows, want %d rows", len(result.Rows)-1, tt.wantRows)
			}
		})
	}
}

// TestFormatExecResult 测试结果格式化功能
func TestFormatExecResult(t *testing.T) {
	// 测试成功的结果格式化
	successResult := &ExecResult{
		Success: true,
		Rows: [][]string{
			{"id", "name"},
			{"1", "Test1"},
			{"2", "Test2"},
		},
	}
	
	formatted := FormatExecResult(successResult)
	if !strings.Contains(formatted, "共 2 行数据") {
		t.Errorf("FormatExecResult() 未包含正确的行数统计")
	}
	
	// 检查表头是否存在（不检查具体格式，因为格式可能会变化）
	if !strings.Contains(formatted, "id") || !strings.Contains(formatted, "name") {
		t.Errorf("FormatExecResult() 未包含表头列名")
	}
	
	// 测试失败的结果格式化
	failResult := &ExecResult{
		Success: false,
		Error:   "测试错误",
	}
	
	formatted = FormatExecResult(failResult)
	if !strings.Contains(formatted, "测试错误") {
		t.Errorf("FormatExecResult() 未正确显示错误信息")
	}
}

// TestTestSuiteEval 测试评估功能
func TestTestSuiteEval(t *testing.T) {
	// 这个测试需要Python环境和评估脚本，可以在有条件时实现
	t.Skip("需要Python环境和评估脚本，暂时跳过")
}
