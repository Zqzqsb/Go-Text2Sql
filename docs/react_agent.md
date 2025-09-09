# ReAct驱动的Text2SQL代理框架

本文档介绍了基于ReAct模式（"思考-行动-观察"循环）的Text2SQL代理框架的使用方法。这个框架使用状态机模型，让LLM作为状态转移驱动器，自主选择和执行工具，实现真正的Agent自主性。

## 架构概述

ReAct代理框架基于以下核心组件：

1. **状态机模型**：整个系统被建模为一个状态机，LLM负责决定状态转移
2. **工具注册机制**：提供各种功能的工具可以被注册到代理
3. **思考-行动-观察循环**：代理通过思考、执行工具、观察结果来逐步解决问题
4. **共享状态**：所有历史步骤和上下文信息都保存在共享状态中

## 主要组件

### ReActAgent

核心代理实现，负责执行ReAct循环，使用LLM进行决策。

### Text2SQLAgent

特定于Text2SQL任务的代理，整合了ReActAgent，并提供了数据库Schema管理等功能。

### 工具集

系统提供了多种工具，包括：
- 查询验证器工具：检测查询中的歧义
- Schema分析器工具：分析数据库结构
- SQL生成器工具：生成SQL语句
- 字段对齐工具：映射自然语言与数据库字段

## 使用示例

### 初始化代理

```go
// 创建LLM实例
llm, err := openai.New(openai.WithModel("gpt-3.5-turbo"))
if err != nil {
    return fmt.Errorf("创建LLM失败: %v", err)
}

// 创建工具注册表
toolRegistry := tools.NewToolRegistry()

// 注册标准工具
tools.RegisterStandardTools(toolRegistry, llm)

// 创建Text2SQL Agent
agent := react.NewText2SQLAgent(react.Text2SQLConfig{
    LLM:         llm,
    DBSchema:    dbSchema,
    DBName:      "hr",
    DBType:      "postgres",
    MaxSteps:    10,
    Interactive: false,
})

// 设置工具
agent.SetTools(toolRegistry)
```

### 执行查询转换

```go
// 设置查询
query := "获取所有员工的姓名和部门"

// 创建上下文
ctx, cancel := context.WithTimeout(context.Background(), 60*time.Second)
defer cancel()

// 执行转换
result, err := agent.Execute(ctx, query)
if err != nil {
    return fmt.Errorf("执行失败: %v", err)
}

// 使用结果
fmt.Printf("SQL: %s\n", result.GetSQL())
fmt.Printf("Explanation: %s\n", result.GetExplanation())
```

## 模糊查询处理

系统能够自动检测并处理模糊查询，例如含有"特定"、"某个"等词汇的查询。当检测到模糊查询时，系统会生成澄清问题。

模糊查询检测包括：

1. **基于模式匹配**：系统维护了常见模糊词汇表（如"特定"、"某个"等）
2. **基于LLM判断**：系统使用LLM判断查询是否存在模糊之处

## 开发自定义工具

要开发自定义工具，只需实现`tools.Tool`接口：

```go
type MyCustomTool struct {
    // 工具所需状态
}

func (t *MyCustomTool) Name() string {
    return "my_custom_tool"
}

func (t *MyCustomTool) Description() string {
    return "执行某种特定功能的工具"
}

func (t *MyCustomTool) ParameterSchema() map[string]string {
    return map[string]string{
        "param1": "参数1的描述",
        "param2": "参数2的描述",
    }
}

func (t *MyCustomTool) Execute(ctx context.Context, params map[string]interface{}) (string, error) {
    // 实现工具逻辑
    return "执行结果", nil
}
```

然后注册到工具注册表：

```go
toolRegistry.Register(NewMyCustomTool())
```

## 交互式与非交互式模式

系统支持两种模式：

1. **非交互式模式**：一次性生成SQL，适用于明确的查询
2. **交互式模式**：遇到模糊查询时生成澄清问题，等待用户反馈

通过设置`Interactive`参数控制模式：

```go
agent := react.NewText2SQLAgent(react.Text2SQLConfig{
    // ...其他参数
    Interactive: true,  // 启用交互式模式
})
```
