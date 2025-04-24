package agents

import (
	"github.com/zqzqsb/gosql/internal/agents/base"
	"github.com/zqzqsb/gosql/internal/agents/query_validator"
	"github.com/zqzqsb/gosql/internal/llm"
)

// Registry 管理所有可用的agents
type Registry struct {
	agents map[string]base.Agent
}

// NewRegistry 创建新的agent注册中心
func NewRegistry() *Registry {
	registry := &Registry{
		agents: make(map[string]base.Agent),
	}
	
	return registry
}

// InitWithLLM 使用LLM客户端初始化Agent注册中心
func NewRegistryWithLLM(llmClient llm.LLM) *Registry {
	registry := NewRegistry()
	
	// 注册支持LLM的QueryValidator
	validator := query_validator.NewQueryValidator().WithLLM(llmClient)
	registry.Register(validator)
	
	// 后续会注册更多agents
	
	return registry
}

// Register 注册一个新agent
func (r *Registry) Register(agent base.Agent) {
	r.agents[agent.GetName()] = agent
}

// GetAgent 获取指定名称的agent
func (r *Registry) GetAgent(name string) (base.Agent, bool) {
	agent, exists := r.agents[name]
	return agent, exists
}

// GetAllAgents 获取所有注册的agents
func (r *Registry) GetAllAgents() []base.Agent {
	result := make([]base.Agent, 0, len(r.agents))
	for _, agent := range r.agents {
		result = append(result, agent)
	}
	return result
}
