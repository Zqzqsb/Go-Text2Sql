package database

import (
	"context"
	"database/sql"
	"fmt"
	"strings"
	"time"

	"github.com/zqzqsb/gosql/internal/dbmodel"
)

// DBExecutor 负责执行数据库操作的统一执行器
type DBExecutor struct {
	factory *DBAdapterFactory
}

// NewDBExecutor 创建新的执行器实例
func NewDBExecutor() *DBExecutor {
	return &DBExecutor{
		factory: &DBAdapterFactory{},
	}
}

// ExecSQL 执行SQL查询，返回查询结果
// 自动识别数据库类型并使用适当的适配器
// 默认超时时间为1分钟
func (e *DBExecutor) ExecSQL(dbPath string, sqlQuery string) ([]map[string]interface{}, error) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Minute)
	defer cancel()
	// 创建配置
	config := NewDBConfigFromPath(dbPath)
	
	// 创建适配器
	adapter := e.factory.CreateAdapter(config.GetType())
	
	// 调整SQL方言
	adaptedSQL := adapter.AdaptSQL(sqlQuery)
	
	// 连接数据库
	db, err := adapter.Connect(config)
	if err != nil {
		return nil, fmt.Errorf("数据库连接失败: %w", err)
	}
	defer db.Close()
	
	// 执行查询（带超时）
	rows, err := db.QueryContext(ctx, adaptedSQL)
	if err != nil {
		if ctx.Err() == context.DeadlineExceeded {
			return nil, fmt.Errorf("查询超时，超过1分钟: %w", err)
		}
		return nil, fmt.Errorf("SQL执行失败: %w", err)
	}
	defer rows.Close()
	
	// 处理查询结果
	return processQueryResults(rows)
}

// LoadSchema 加载数据库Schema
// 自动识别数据库类型并使用适当的适配器
func (e *DBExecutor) LoadSchema(dbPath string) (*dbmodel.DatabaseSchema, error) {
	// 创建配置
	config := NewDBConfigFromPath(dbPath)
	
	// 创建适配器
	adapter := e.factory.CreateAdapter(config.GetType())
	
	// 加载Schema
	return adapter.LoadSchema(config)
}

// IsEquivalentSQL 检查两条SQL语句在不同数据库方言下是否等价
func (e *DBExecutor) IsEquivalentSQL(dbPath, sqlA, sqlB string) (bool, error) {
	config := NewDBConfigFromPath(dbPath)
	adapter := e.factory.CreateAdapter(config.GetType())
	
	// 连接到数据库
	db, err := adapter.Connect(config)
	if err != nil {
		return false, fmt.Errorf("数据库连接失败: %w", err)
	}
	defer db.Close()
	
	// 预处理两条SQL语句
	normSqlA := normalizeSQL(adapter.AdaptSQL(sqlA))
	normSqlB := normalizeSQL(adapter.AdaptSQL(sqlB))
	
	// 如果标准化后的SQL完全相同，则认为等价
	if normSqlA == normSqlB {
		return true, nil
	}
	
	// 执行两条SQL，如果结果相同，则认为等价
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Minute) // 两个SQL查询共享2分钟超时
	defer cancel()
	
	// 使用通道来收集两个查询的结果
	type queryResult struct {
		result []map[string]interface{}
		err    error
	}
	
	ch := make(chan queryResult, 2)
	
	// 并行执行两个查询
	go func() {
		result, err := e.ExecSQL(dbPath, sqlA)
		ch <- queryResult{result, err}
	}()
	
	go func() {
		result, err := e.ExecSQL(dbPath, sqlB)
		ch <- queryResult{result, err}
	}()
	
	// 等待两个查询的结果
	var resultA, resultB []map[string]interface{}
	for i := 0; i < 2; i++ {
		select {
		case <-ctx.Done():
			return false, fmt.Errorf("查询超时，超过2分钟")
		case r := <-ch:
			if r.err != nil {
				return false, fmt.Errorf("执行SQL失败: %w", r.err)
			}
			if resultA == nil {
				resultA = r.result
			} else {
				resultB = r.result
			}
		}
	}
	
	// 比较结果集
	return compareResultSets(resultA, resultB), nil
}

// processQueryResults 处理SQL查询结果
func processQueryResults(rows *sql.Rows) ([]map[string]interface{}, error) {
	// 获取列信息
	columns, err := rows.Columns()
	if err != nil {
		return nil, err
	}
	
	// 准备接收结果的切片
	results := make([]map[string]interface{}, 0)
	
	// 为每行数据创建容器
	values := make([]interface{}, len(columns))
	valuePtrs := make([]interface{}, len(columns))
	
	for i := range columns {
		valuePtrs[i] = &values[i]
	}
	
	// 遍历结果集
	for rows.Next() {
		// 扫描行数据
		if err := rows.Scan(valuePtrs...); err != nil {
			return nil, err
		}
		
		// 构建结果映射
		rowMap := make(map[string]interface{})
		for i, col := range columns {
			var v interface{}
			val := values[i]
			
			// 根据类型转换值
			switch val.(type) {
			case []byte:
				// 将二进制数据转换为字符串
				v = string(val.([]byte))
				
				// 尝试解析数字字符串
				if vStr, ok := v.(string); ok {
					// 尝试解析为浮点数
					if vFloat, err := parseFloat(vStr); err == nil {
						v = vFloat
					}
				}
			default:
				v = val
			}
			
			rowMap[col] = v
		}
		
		results = append(results, rowMap)
	}
	
	// 检查遍历错误
	if err := rows.Err(); err != nil {
		return nil, err
	}
	
	return results, nil
}

// normalizeSQL 标准化SQL字符串，便于比较
func normalizeSQL(sql string) string {
	// 转换为小写
	sql = strings.ToLower(sql)
	
	// 移除多余空白字符
	sql = strings.TrimSpace(sql)
	sql = strings.Join(strings.Fields(sql), " ")
	
	// 移除末尾的分号
	sql = strings.TrimSuffix(sql, ";")
	
	return sql
}

// compareResultSets 比较两个查询结果集是否相同
func compareResultSets(setA, setB []map[string]interface{}) bool {
	if len(setA) != len(setB) {
		return false
	}
	
	// 对每条记录进行比较
	// 注意：这里假设结果集是按相同顺序排列的
	// 实际应用中可能需要更复杂的排序和比较逻辑
	for i, rowA := range setA {
		rowB := setB[i]
		
		// 检查列数量
		if len(rowA) != len(rowB) {
			return false
		}
		
		// 比较每个列的值
		for key, valA := range rowA {
			valB, exists := rowB[key]
			if !exists {
				return false
			}
			
			// 比较值（简化处理）
			// 实际应用中可能需要考虑类型转换和精度问题
			if fmt.Sprintf("%v", valA) != fmt.Sprintf("%v", valB) {
				return false
			}
		}
	}
	
	return true
}

// parseFloat 尝试将字符串解析为浮点数
func parseFloat(s string) (float64, error) {
	var f float64
	_, err := fmt.Sscanf(s, "%f", &f)
	return f, err
}
