package base

import (
	"context"
	"time"
)

// AgentContext 定义了agents间共享的上下文信息
type AgentContext struct {
	ctx         context.Context     // 内部持有的上下文
	State       map[string]interface{}  // 全局状态
	Config      map[string]interface{}  // 配置信息
	UserSession interface{}             // 用户会话信息
}

// NewAgentContext 创建新的agent上下文
func NewAgentContext(ctx context.Context) *AgentContext {
	return &AgentContext{
		ctx:    ctx,
		State:  make(map[string]interface{}),
		Config: make(map[string]interface{}),
	}
}

// Deadline 实现context.Context接口
func (ac *AgentContext) Deadline() (deadline time.Time, ok bool) {
	return ac.ctx.Deadline()
}

// Done 实现context.Context接口
func (ac *AgentContext) Done() <-chan struct{} {
	return ac.ctx.Done()
}

// Err 实现context.Context接口 
func (ac *AgentContext) Err() error {
	return ac.ctx.Err()
}

// Value 实现context.Context接口
func (ac *AgentContext) Value(key interface{}) interface{} {
	return ac.ctx.Value(key)
}

// WithConfig 设置配置信息并返回新的上下文
func (ac *AgentContext) WithConfig(config map[string]interface{}) *AgentContext {
	newCtx := *ac
	newCtx.Config = config
	return &newCtx
}

// WithState 设置状态信息并返回新的上下文
func (ac *AgentContext) WithState(state map[string]interface{}) *AgentContext {
	newCtx := *ac
	newCtx.State = state
	return &newCtx
}

// WithUserSession 设置用户会话信息并返回新的上下文
func (ac *AgentContext) WithUserSession(session interface{}) *AgentContext {
	newCtx := *ac
	newCtx.UserSession = session
	return &newCtx
}

// GetValue 从状态中获取值
func (ac *AgentContext) GetValue(key string) (interface{}, bool) {
	val, ok := ac.State[key]
	return val, ok
}

// SetValue 设置状态值
func (ac *AgentContext) SetValue(key string, value interface{}) {
	ac.State[key] = value
}

// GetConfig 从配置中获取值
func (ac *AgentContext) GetConfig(key string) (interface{}, bool) {
	val, ok := ac.Config[key]
	return val, ok
}
