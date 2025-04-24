# AgentContext 设计文档

> AgentContext是一个扩展了Go标准context.Context的自定义上下文实现，专为Agent间通信和状态共享而设计。它在保持与标准Context兼容的同时，添加了Agent系统所需的状态管理、配置和会话功能。

## Go标准Context简介

> Go的context包提供了一种在API边界和进程间传递截止时间、取消信号和其他请求范围值的标准方式。

### Context的核心概念

1. **取消传播** - 父Context取消时，所有从它派生的Context都会取消
2. **值传递** - Context可以携带请求范围的值，但建议只用于传递进程和API边界的请求域数据
3. **截止时间** - Context可以设置截止时间，表示操作应在何时完成
4. **无可变性** - Context是不可变的，修改操作（如WithValue）总是返回新的Context实例

### Context接口

标准的`context.Context`接口定义了四个方法：

```go
type Context interface {
    Deadline() (deadline time.Time, ok bool)
    Done() <-chan struct{}
    Err() error
    Value(key interface{}) interface{}
}
```

- `Deadline()` - 返回Context超时的时间，如果未设置则ok为false
- `Done()` - 返回一个通道，当Context被取消或超时时关闭
- `Err()` - 返回Context取消的原因，未取消则为nil
- `Value()` - 返回与key关联的值，未找到则为nil

## AgentContext设计

> AgentContext在标准Context基础上添加了Agent系统特有的功能，同时保持接口兼容性，使其可以无缝用于任何接受标准Context的函数和方法中。

### 扩展功能

1. **状态管理** - 提供了State字段和相关方法，用于Agent间共享运行时状态
2. **配置存储** - 提供了Config字段和相关方法，用于存储Agent配置信息
3. **用户会话** - 提供了UserSession字段和相关方法，用于跟踪用户会话状态
4. **链式调用** - 采用With类方法支持流畅的链式调用API

### 结构设计

```go
type AgentContext struct {
    ctx         context.Context      // 内部持有的标准Context
    State       map[string]interface{}   // 全局状态
    Config      map[string]interface{}   // 配置信息
    UserSession interface{}              // 用户会话信息
}
```

- 内部持有一个标准Context实例，代理其Context接口方法
- 使用映射存储键值对形式的状态和配置
- 使用通用interface{}存储用户会话，提供最大灵活性

### 使用模式

#### 创建与转换

```go
// 创建基础AgentContext
ctx := base.NewAgentContext(context.Background())

// 添加配置并获得新的AgentContext
configCtx := ctx.WithConfig(map[string]interface{}{
    "timeout": 30 * time.Second,
    "model": "deepseek-v3",
})

// 添加状态并获得新的AgentContext
stateCtx := configCtx.WithState(map[string]interface{}{
    "query_count": 0,
    "last_query": "select * from users",
})

// 添加用户会话
sessionCtx := stateCtx.WithUserSession(userSession)
```

#### 状态操作

```go
// 设置状态值
ctx.SetValue("current_step", "validate_query")

// 获取状态值
if step, ok := ctx.GetValue("current_step"); ok {
    // 使用step...
}

// 获取配置
if timeout, ok := ctx.GetConfig("timeout"); ok {
    // 使用timeout...
}
```

## AgentContext 与 MessageBus 的关系

AgentContext和MessageBus共同构成了Agent系统的通信基础：

- **AgentContext** - 提供长寿命状态存储和上下文传递
- **MessageBus** - 提供Agent间即时消息传递

在典型使用场景中：
1. 创建带有系统配置的AgentContext
2. 将AgentContext传递给各个Agent初始化函数
3. Agent通过MessageBus发送消息进行通信
4. Agent可以通过AgentContext访问共享状态和配置

## 最佳实践

1. **分离关注点** - 使用State存储运行时状态，Config存储不变配置
2. **不可变原则** - 优先使用With*方法创建新上下文，而非修改现有上下文
3. **合理使用** - 不要在AgentContext中存储大量数据，专注于必要的上下文信息
4. **类型安全** - 获取值后进行类型断言确保类型安全
5. **错误处理** - 始终检查GetValue和GetConfig的ok返回值

## 示例：在Agent中使用

```go
func (v *QueryValidator) Execute(ctx context.Context, input interface{}) interface{} {
    // 转换为AgentContext
    agentCtx, ok := ctx.(*base.AgentContext)
    if !ok {
        agentCtx = base.NewAgentContext(ctx)
    }
    
    // 访问配置
    maxTokens, _ := agentCtx.GetConfig("max_tokens")
    
    // 更新状态
    if count, ok := agentCtx.GetValue("query_count"); ok {
        agentCtx.SetValue("query_count", count.(int) + 1)
    } else {
        agentCtx.SetValue("query_count", 1)
    }
    
    // 执行验证...
    
    return result
}
```

## 总结

> AgentContext通过扩展Go的标准Context，为Agent系统提供了兼具兼容性和功能性的上下文管理解决方案。它简化了Agent间的状态共享、配置管理和会话跟踪，同时保持了与Go标准库的无缝集成。
