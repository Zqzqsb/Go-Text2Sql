package agents

import (
	"context"
	"errors"
	"fmt"
	
	"github.com/zqzqsb/gosql/internal/agents/base"
	"github.com/zqzqsb/gosql/internal/config"
	"github.com/zqzqsb/gosql/internal/llm"
)

// Manager 负责协调和管理agents
type Manager struct {
	registry   *Registry
	messageBus *base.MessageBus
	config     map[string]interface{}
	llmClient  llm.LLM
}

// NewManager 创建新的agent管理器
func NewManager(config map[string]interface{}) *Manager {
	registry := NewRegistry()
	messageBus := base.NewMessageBus()
	
	manager := &Manager{
		registry:   registry,
		messageBus: messageBus,
		config:     config,
	}
	
	// 为所有agent注册消息处理器
	for _, agent := range registry.GetAllAgents() {
		messageBus.Register(agent.GetName(), func(msg base.Message) base.Message {
			result := agent.Execute(context.Background(), msg.Content)
			return base.Message{
				From:    agent.GetName(),
				To:      msg.From,
				Type:    "response",
				Content: result,
			}
		})
	}
	
	return manager
}

// NewManagerWithLLM 创建带有LLM支持的agent管理器
func NewManagerWithLLM(cfg *config.Config) (*Manager, error) {
	// 创建LLM客户端
	llmClient, err := createLLMClient(cfg)
	if err != nil {
		return nil, fmt.Errorf("创建LLM客户端失败: %v", err)
	}
	
	// 创建带有LLM支持的Registry
	registry := NewRegistryWithLLM(llmClient)
	messageBus := base.NewMessageBus()
	
	// 转换配置为map
	configMap := make(map[string]interface{})
	
	// 添加LLM配置
	configMap["llm"] = map[string]interface{}{
		"provider": cfg.LLM.Provider,
		"model":    cfg.LLM.Model,
	}
	
	manager := &Manager{
		registry:   registry,
		messageBus: messageBus,
		config:     configMap,
		llmClient:  llmClient,
	}
	
	// 为所有agent注册消息处理器
	for _, agent := range registry.GetAllAgents() {
		agentName := agent.GetName()
		messageBus.Register(agentName, func(msg base.Message) base.Message {
			result := agent.Execute(context.Background(), msg.Content)
			return base.Message{
				From:    agentName,
				To:      msg.From,
				Type:    "response",
				Content: result,
			}
		})
	}
	
	return manager, nil
}

// createLLMClient 根据配置创建LLM客户端
func createLLMClient(cfg *config.Config) (llm.LLM, error) {
	switch cfg.LLM.Provider {
	case "openai":
		// 创建OpenAI配置
		openaiCfg := &config.OpenAIConfig{
			APIKey:  cfg.LLM.OpenAI.APIKey,
			BaseURL: cfg.LLM.OpenAI.BaseURL,
		}
		
		// 创建并返回OpenAI客户端
		client := llm.NewOpenAIClient(openaiCfg, cfg.LLM.Model)
		return client, nil
	default:
		return nil, fmt.Errorf("不支持的LLM提供商: %s", cfg.LLM.Provider)
	}
}

// ValidateQuery 使用QueryValidator验证查询
func (m *Manager) ValidateQuery(ctx context.Context, query string) (*base.AgentResult, error) {
	agent, exists := m.registry.GetAgent("query_validator")
	if !exists {
		return nil, errors.New("query validator agent not found")
	}
	
	agentCtx := base.NewAgentContext(ctx).WithConfig(m.config)
	result := agent.Execute(agentCtx, query)
	
	return &result, nil
}

// ExecuteAgent 执行指定的agent
func (m *Manager) ExecuteAgent(ctx context.Context, agentName string, input interface{}) (*base.AgentResult, error) {
	agent, exists := m.registry.GetAgent(agentName)
	if !exists {
		return nil, fmt.Errorf("agent %s not found", agentName)
	}
	
	if !agent.CanHandle(input) {
		return nil, fmt.Errorf("agent %s cannot handle input of type %T", agentName, input)
	}
	
	agentCtx := base.NewAgentContext(ctx).WithConfig(m.config)
	result := agent.Execute(agentCtx, input)
	
	return &result, nil
}

// SendMessage 通过消息总线发送消息
func (m *Manager) SendMessage(from string, to string, msgType string, content interface{}) base.Message {
	msg := base.Message{
		From:    from,
		To:      to,
		Type:    msgType,
		Content: content,
	}
	
	return m.messageBus.Send(msg)
}

// RegisterAgent 注册新的agent
func (m *Manager) RegisterAgent(agent base.Agent) {
	m.registry.Register(agent)
	
	// 同时注册消息处理器
	m.messageBus.Register(agent.GetName(), func(msg base.Message) base.Message {
		result := agent.Execute(context.Background(), msg.Content)
		return base.Message{
			From:    agent.GetName(),
			To:      msg.From,
			Type:    "response",
			Content: result,
		}
	})
}
