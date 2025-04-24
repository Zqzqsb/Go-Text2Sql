package base

import "context"

// AgentResult 表示agent执行结果
type AgentResult struct {
	Success     bool                     // 执行是否成功
	Data        interface{}              // 返回的数据
	Error       string                   // 错误信息
	NextActions []string                 // 建议的下一步操作
	Metadata    map[string]interface{}   // 元数据
}

// Agent 定义了所有agents必须实现的基本接口
type Agent interface {
	// Execute 执行agent的主要功能
	Execute(ctx context.Context, input interface{}) AgentResult
	
	// GetName 返回agent的唯一名称
	GetName() string
	
	// GetDescription 返回agent的功能描述
	GetDescription() string
	
	// CanHandle 判断agent是否能处理给定的输入
	CanHandle(input interface{}) bool
}
