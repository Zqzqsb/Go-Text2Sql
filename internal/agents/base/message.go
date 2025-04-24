package base

// Message 定义了agent间通信的消息格式
type Message struct {
	From    string                  // 发送方
	To      string                  // 接收方
	Type    string                  // 消息类型
	Content interface{}             // 消息内容
}

// MessageBus 实现简单的agent间通信机制
type MessageBus struct {
	handlers map[string]func(Message) Message
}

// NewMessageBus 创建新的消息总线
func NewMessageBus() *MessageBus {
	return &MessageBus{
		handlers: make(map[string]func(Message) Message),
	}
}

// Register 注册消息处理器
func (mb *MessageBus) Register(agentName string, handler func(Message) Message) {
	mb.handlers[agentName] = handler
}

// Send 向指定agent发送消息并获取响应
func (mb *MessageBus) Send(msg Message) Message {
	handler, exists := mb.handlers[msg.To]
	if !exists {
		return Message{
			From:    "system",
			To:      msg.From,
			Type:    "error",
			Content: "目标agent不存在",
		}
	}
	
	return handler(msg)
}
