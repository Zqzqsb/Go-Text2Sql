package schema_analyzer

import (
	"context"
	"testing"

	"github.com/zqzqsb/gosql/internal/schema"
)

func TestSchemaAnalyzer(t *testing.T) {
	// 创建一个简单的测试数据库模式
	testSchema := &schema.DatabaseSchema{
		Tables: []schema.Table{
			{
				Name: "users",
				Columns: []schema.Column{
					{Name: "id", Type: "INT", IsPrimary: true},
					{Name: "username", Type: "VARCHAR"},
					{Name: "email", Type: "VARCHAR"},
					{Name: "created_at", Type: "TIMESTAMP"},
				},
			},
			{
				Name: "orders",
				Columns: []schema.Column{
					{Name: "id", Type: "INT", IsPrimary: true},
					{Name: "user_id", Type: "INT", IsForeign: true},
					{Name: "amount", Type: "DECIMAL"},
					{Name: "status", Type: "VARCHAR"},
				},
			},
		},
		ForeignKeys: []schema.ForeignKey{
			{
				SourceTable:  "orders",
				SourceColumn: "user_id",
				TargetTable:  "users",
				TargetColumn: "id",
			},
		},
	}

	// 创建SchemaAnalyzer实例
	analyzer := NewSchemaAnalyzer()

	// 测试CanHandle方法
	if !analyzer.CanHandle(testSchema) {
		t.Error("SchemaAnalyzer应该能够处理DatabaseSchema")
	}

	// 测试Execute方法
	result := analyzer.Execute(context.Background(), testSchema)
	if !result.Success {
		t.Errorf("SchemaAnalyzer执行失败: %s", result.Error)
	}

	// 获取分析结果
	analysis, ok := result.Data.(*SchemaAnalysis)
	if !ok {
		t.Error("返回结果类型错误")
		return
	}

	// 验证表重要度分析
	if len(analysis.TableImportance) != 2 {
		t.Errorf("期望分析2个表, 实际分析了%d个表", len(analysis.TableImportance))
	}

	// 验证字段重要度分析
	if _, ok := analysis.FieldImportance["users"]; !ok {
		t.Error("缺少users表的字段重要度分析")
	}
	if _, ok := analysis.FieldImportance["orders"]; !ok {
		t.Error("缺少orders表的字段重要度分析")
	}

	// 验证表关系分析
	if len(analysis.TableRelations) != 1 {
		t.Errorf("期望识别1个表关系, 实际识别了%d个", len(analysis.TableRelations))
	}

	// 验证字段描述
	if len(analysis.FieldDescriptions["users"]) != 4 {
		t.Errorf("期望users表有4个字段描述, 实际有%d个", len(analysis.FieldDescriptions["users"]))
	}
	if len(analysis.FieldDescriptions["orders"]) != 4 {
		t.Errorf("期望orders表有4个字段描述, 实际有%d个", len(analysis.FieldDescriptions["orders"]))
	}

	// 验证查询模式
	if len(analysis.CommonQueryPatterns) < 4 {
		t.Errorf("期望至少4个常用查询模式, 实际有%d个", len(analysis.CommonQueryPatterns))
	}

	// 测试缓存机制
	result2 := analyzer.Execute(context.Background(), testSchema)
	if source, ok := result2.Metadata["source"]; !ok || source != "cache" {
		t.Error("第二次执行应该使用缓存")
	}
}
