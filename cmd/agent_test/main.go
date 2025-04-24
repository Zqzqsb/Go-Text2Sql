package main

import (
	"context"
	"fmt"
	"os"
	
	"github.com/zqzqsb/gosql/internal/agents"
	"github.com/zqzqsb/gosql/internal/agents/query_validator"
	"github.com/zqzqsb/gosql/internal/config"
)

func main() {
	// 加载配置
	configPath := "configs/config_deepseek_v3_0324.yaml"
	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		fmt.Printf("加载配置失败: %v\n", err)
		os.Exit(1)
	}
	
	// 创建Agent管理器
	manager, err := agents.NewManagerWithLLM(cfg)
	if err != nil {
		fmt.Printf("创建Agent管理器失败: %v\n", err)
		os.Exit(1)
	}
	
	// 测试查询
	testQueries := []string{
		"获取所有员工信息",
		"获取员工ID为12345的信息",
		"获取特定员工的信息",
		"找出某个部门的所有员工",
		"获取2023年销售额超过100万的产品",
		"统计某个月份的总销售额",
	}
	
	// 测试每个查询
	for _, query := range testQueries {
		fmt.Printf("\n=== 测试查询: %s ===\n", query)
		
		// 验证查询
		result, err := manager.ValidateQuery(context.Background(), query)
		if err != nil {
			fmt.Printf("验证查询失败: %v\n", err)
			continue
		}
		
		// 输出结果
		isAmbiguous := result.Data.(bool)
		
		if isAmbiguous {
			fmt.Printf("查询判定为模糊，需要澄清\n")
			
			// 显示置信度
			if confidence, ok := result.Metadata["confidence"].(float64); ok {
				fmt.Printf("置信度: %.2f\n", confidence)
			}
			
			// 显示模糊类型
			if ambiguousType, ok := result.Metadata["ambiguous_type"].(string); ok {
				fmt.Printf("模糊类型: %s\n", ambiguousType)
			}
			
			// 显示澄清问题
			if questions, ok := result.Metadata["clarification_questions"]; ok {
				fmt.Println("澄清问题:")
				
				// 处理不同类型的澄清问题
				switch q := questions.(type) {
				case []interface{}:
					// 处理通用接口切片
					for i, question := range q {
						questionMap, ok := question.(map[string]interface{})
						if ok {
							fmt.Printf("%d. %s\n", i+1, questionMap["Question"])
						}
					}
				case []query_validator.ClarificationQuestion:
					// 直接处理ClarificationQuestion切片
					for i, question := range q {
						fmt.Printf("%d. %s (优先级: %d, 类型: %s)\n", 
							i+1, question.Question, question.Priority, question.Type)
					}
				default:
					fmt.Printf("未识别的澄清问题类型: %T\n", questions)
				}
			}
		} else {
			fmt.Printf("查询判定为明确，可以直接执行\n")
			
			// 显示置信度
			if confidence, ok := result.Metadata["confidence"].(float64); ok {
				fmt.Printf("置信度: %.2f\n", confidence)
			}
		}
	}
}
