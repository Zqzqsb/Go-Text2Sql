package base

import (
	"context"

	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/schema"
)

// AgentResult represents the outcome of an agent execution
type AgentResult struct {
	Success     bool
	Data        interface{}
	Error       string
	NextActions []string
	Metadata    map[string]interface{}
}

// Agent defines the interface that all agents must implement
type Agent interface {
	// Execute runs the agent's primary function with the given input
	Execute(ctx context.Context, input interface{}) (AgentResult, error)

	// GetName returns the agent's unique identifier
	GetName() string

	// GetDescription returns information about the agent's purpose
	GetDescription() string

	// CanHandle determines if the agent can process the given input
	CanHandle(input interface{}) bool
}

// BaseAgent provides a basic implementation of the Agent interface
type BaseAgent struct {
	Name        string
	Description string
	LLM         llms.Model
	Memory      schema.Memory
	Tools       []interface{} // Changed from schema.Tool for compatibility
}

// GetName returns the agent's name
func (b *BaseAgent) GetName() string {
	return b.Name
}

// GetDescription returns the agent's description
func (b *BaseAgent) GetDescription() string {
	return b.Description
}

// Execute is a base implementation that should be overridden by concrete agents
func (b *BaseAgent) Execute(ctx context.Context, input interface{}) (AgentResult, error) {
	return AgentResult{
		Success: false,
		Error:   "Execute method not implemented in concrete agent",
	}, nil
}

// CanHandle determines if this agent can process the given input
// Should be overridden by concrete agent implementations
func (b *BaseAgent) CanHandle(input interface{}) bool {
	return false
}
