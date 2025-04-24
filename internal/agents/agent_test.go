package agents

import (
	"context"
	"fmt"
	"testing"
	
	"github.com/zqzqsb/gosql/internal/agents/query_validator"
)

func TestQueryValidator(t *testing.T) {
	// 创建QueryValidator实例
	validator := query_validator.NewQueryValidator()
	
	// 测试用例
	testCases := []struct {
		query         string
		isAmbiguous   bool
		ambiguousType string
	}{
		{"获取所有员工信息", false, ""},
		{"获取员工ID为12345的信息", false, ""},
		{"获取特定员工的信息", true, "ambiguous_term"},
		{"找出某个部门的所有员工", true, "ambiguous_term"},
		{"SELECT * FROM employees WHERE id = '???'", true, "pattern_match"},
		{"获取[请输入]部门的销售数据", true, "placeholder"},
	}
	
	for i, tc := range testCases {
		t.Run(fmt.Sprintf("Case %d: %s", i, tc.query), func(t *testing.T) {
			isAmbiguous, ambiguousType := validator.IsAmbiguousQuery(tc.query)
			
			if isAmbiguous != tc.isAmbiguous {
				t.Errorf("Case %d: IsAmbiguousQuery(%q) returned %v, want %v", 
					i, tc.query, isAmbiguous, tc.isAmbiguous)
			}
			
			if isAmbiguous && ambiguousType != tc.ambiguousType {
				t.Errorf("Case %d: IsAmbiguousQuery(%q) returned type %q, want %q", 
					i, tc.query, ambiguousType, tc.ambiguousType)
			}
		})
	}
}

func TestAgentManager(t *testing.T) {
	// 创建Agent Manager
	config := map[string]interface{}{
		"enable_logging": true,
	}
	manager := NewManager(config)
	
	// 测试模糊查询验证
	ctx := context.Background()
	
	// 测试明确查询
	result, err := manager.ValidateQuery(ctx, "获取员工ID为12345的信息")
	if err != nil {
		t.Fatalf("ValidateQuery failed: %v", err)
	}
	
	if result.Data.(bool) != false {
		t.Errorf("Expected non-ambiguous query to return false, got %v", result.Data)
	}
	
	// 测试模糊查询
	result, err = manager.ValidateQuery(ctx, "获取特定员工的信息")
	if err != nil {
		t.Fatalf("ValidateQuery failed: %v", err)
	}
	
	if result.Data.(bool) != true {
		t.Errorf("Expected ambiguous query to return true, got %v", result.Data)
	}
	
	// 检查是否生成了澄清问题
	metadata := result.Metadata
	if metadata == nil {
		t.Fatalf("Expected metadata to be non-nil")
	}
	
	questions, ok := metadata["clarification_questions"]
	if !ok {
		t.Fatalf("Expected clarification_questions in metadata")
	}
	
	// 打印澄清问题以便手动检查
	fmt.Printf("Clarification questions for '获取特定员工的信息':\n")
	for i, q := range questions.([]query_validator.ClarificationQuestion) {
		fmt.Printf("%d. %s (Priority: %d, Type: %s)\n", 
			i+1, q.Question, q.Priority, q.Type)
	}
}
