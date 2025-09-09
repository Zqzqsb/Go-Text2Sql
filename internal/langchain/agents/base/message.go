package base

import (
	"context"
)
// Message 定义了agent间通信的消息格式
type Message struct {
	From    string      // 发送方
	To      string      // 接收方
	Type    string      // 消息类型
	Content interface{} // 消息内容
}

// 定义常用的消息类型常量
const (
	MessageTypeQuery         = "query"         // 查询消息
	MessageTypeValidation    = "validation"    // 验证结果
	MessageTypeSchema        = "schema"        // Schema信息
	MessageTypeSQL           = "sql"           // SQL生成
	MessageTypeFieldAlign    = "field_align"   // 字段对齐
	MessageTypeBusinessInfo  = "business_info" // 业务信息
	MessageTypeError         = "error"         // 错误信息
	MessageTypeResult        = "result"        // 执行结果
)

// NewMessage 创建新消息
func NewMessage(from, to, msgType string, content interface{}) Message {
	return Message{
		From:    from,
		To:      to,
		Type:    msgType,
		Content: content,
	}
}

// MessageBus 消息总线接口
type MessageBus interface {
	// Send 发送消息
	Send(msg Message) error
	
	// Subscribe 订阅消息
	Subscribe(agent Agent, msgTypes ...string) error
	
	// Unsubscribe 取消订阅
	Unsubscribe(agent Agent, msgTypes ...string) error
}

// SimpleMessageBus 简单的内存消息总线实现
type SimpleMessageBus struct {
	subscribers map[string]map[string][]Agent // msgType -> agentName -> []Agent
}

// NewSimpleMessageBus 创建新的简单消息总线
func NewSimpleMessageBus() *SimpleMessageBus {
	return &SimpleMessageBus{
		subscribers: make(map[string]map[string][]Agent),
	}
}

// Send 发送消息给所有订阅该消息类型的Agent
func (b *SimpleMessageBus) Send(msg Message) error {
	// 创建一个上下文 - 避免使用 nil context
	ctx := context.TODO()
	
	if subscribers, exists := b.subscribers[msg.Type]; exists {
		// 如果指定了接收方，则只发送给该接收方
		if msg.To != "" {
			if agents, ok := subscribers[msg.To]; ok {
				for _, agent := range agents {
					// 实际项目中应该异步处理，这里简化为同步
					_, err := agent.Execute(ctx, msg.Content)
					if err != nil {
						return err
					}
				}
			}
		} else {
			// 否则发送给所有订阅者
			for _, agentList := range subscribers {
				for _, agent := range agentList {
					// 实际项目中应该异步处理，这里简化为同步
					_, err := agent.Execute(ctx, msg.Content)
					if err != nil {
						return err
					}
				}
			}
		}
	}
	return nil
}

// Subscribe 订阅特定类型的消息
func (b *SimpleMessageBus) Subscribe(agent Agent, msgTypes ...string) error {
	agentName := agent.GetName()
	
	for _, msgType := range msgTypes {
		if _, exists := b.subscribers[msgType]; !exists {
			b.subscribers[msgType] = make(map[string][]Agent)
		}
		
		if _, exists := b.subscribers[msgType][agentName]; !exists {
			b.subscribers[msgType][agentName] = []Agent{}
		}
		
		b.subscribers[msgType][agentName] = append(b.subscribers[msgType][agentName], agent)
	}
	
	return nil
}

// Unsubscribe 取消订阅特定类型的消息
func (b *SimpleMessageBus) Unsubscribe(agent Agent, msgTypes ...string) error {
	agentName := agent.GetName()
	
	for _, msgType := range msgTypes {
		if _, exists := b.subscribers[msgType]; exists {
			delete(b.subscribers[msgType], agentName)
		}
	}
	
	return nil
}
