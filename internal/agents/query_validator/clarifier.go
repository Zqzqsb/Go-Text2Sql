package query_validator

import "strings"

// ClarificationQuestion 表示澄清问题
type ClarificationQuestion struct {
	Question     string // 问题内容
	Type         string // 问题类型
	FieldRelated string // 相关字段
	Priority     int    // 优先级（1-5，1为最高）
}

// GenerateClarificationQuestions 为模糊查询生成澄清问题
func GenerateClarificationQuestions(query string) []ClarificationQuestion {
	var questions []ClarificationQuestion
	
	// 员工相关模糊查询
	if containsAny(query, []string{"特定员工", "某个员工", "某些员工", "指定员工"}) {
		questions = append(questions, ClarificationQuestion{
			Question:     "您想查询哪个员工的信息？请提供员工姓名或ID。",
			Type:         "entity_specification",
			FieldRelated: "employee",
			Priority:     1,
		})
	}
	
	// 产品相关模糊查询
	if containsAny(query, []string{"特定产品", "某个产品", "某些产品", "指定产品"}) {
		questions = append(questions, ClarificationQuestion{
			Question:     "您想查询哪个产品的信息？请提供产品名称或ID。",
			Type:         "entity_specification",
			FieldRelated: "product",
			Priority:     1,
		})
	}
	
	// 日期相关模糊查询
	if containsAny(query, []string{"特定日期", "某个日期", "某些日期", "指定日期", "特定时间", "某个时间段"}) {
		questions = append(questions, ClarificationQuestion{
			Question:     "您想查询哪个日期或时间段的信息？请提供具体日期或日期范围（如YYYY-MM-DD或YYYY-MM-DD至YYYY-MM-DD）。",
			Type:         "time_specification",
			FieldRelated: "date",
			Priority:     2,
		})
	}
	
	// 订单相关模糊查询
	if containsAny(query, []string{"特定订单", "某个订单", "某些订单", "指定订单"}) {
		questions = append(questions, ClarificationQuestion{
			Question:     "您想查询哪个订单的信息？请提供订单ID或订单相关信息。",
			Type:         "entity_specification",
			FieldRelated: "order",
			Priority:     1,
		})
	}
	
	// 部门相关模糊查询
	if containsAny(query, []string{"特定部门", "某个部门", "某些部门", "指定部门"}) {
		questions = append(questions, ClarificationQuestion{
			Question:     "您想查询哪个部门的信息？请提供部门名称或ID。",
			Type:         "entity_specification",
			FieldRelated: "department",
			Priority:     1,
		})
	}
	
	// 金额相关模糊查询
	if containsAny(query, []string{"特定金额", "某个金额", "某些金额", "指定金额范围"}) {
		questions = append(questions, ClarificationQuestion{
			Question:     "您想查询哪个金额范围的信息？请提供具体金额或金额范围（如>1000或1000-5000）。",
			Type:         "value_specification",
			FieldRelated: "amount",
			Priority:     2,
		})
	}
	
	// 如果没有匹配到特定模式，但查询仍然被标记为模糊，提供一个通用问题
	if len(questions) == 0 {
		questions = append(questions, ClarificationQuestion{
			Question:     "您的查询包含模糊条件，请提供更具体的信息，以便我们准确理解您的需求。",
			Type:         "general_clarification",
			FieldRelated: "",
			Priority:     3,
		})
	}
	
	return questions
}

// containsAny 检查字符串是否包含给定列表中的任何子字符串
func containsAny(s string, substrings []string) bool {
	lowercaseStr := strings.ToLower(s)
	for _, substr := range substrings {
		if strings.Contains(lowercaseStr, strings.ToLower(substr)) {
			return true
		}
	}
	return false
}
