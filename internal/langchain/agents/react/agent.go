package react

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/tmc/langchaingo/llms"
	"github.com/zqzqsb/gosql/internal/langchain/agents/react/tools"
)

// ReActAgent 实现状态机模型的Agent
type ReActAgent struct {
	llm         llms.Model
	tools       *tools.ToolRegistry
	maxSteps    int
	temperature float64
	state       *State
}

// NewReActAgent 创建一个新的ReActAgent
func NewReActAgent(llm llms.Model, toolRegistry *tools.ToolRegistry, maxSteps int) *ReActAgent {
	return &ReActAgent{
		llm:         llm,
		tools:       toolRegistry,
		maxSteps:    maxSteps,
		temperature: 0.1, // 默认较低的temperature以提高确定性
	}
}

// Execute 实现ReAct循环
func (a *ReActAgent) Execute(ctx context.Context, state *State) (*State, error) {
	// 保存状态
	a.state = state
	
	// ReAct循环
	for i := 0; i < a.maxSteps; i++ {
		// 1. 构建提示词
		prompt := a.buildPrompt()
		
		// 2. LLM作为状态转移函数
		response, err := a.llm.Call(ctx, prompt, llms.WithTemperature(a.temperature))
		if err != nil {
			a.state.AddError(fmt.Sprintf("LLM调用失败: %v", err))
			return a.state, fmt.Errorf("LLM调用失败: %v", err)
		}
		
		// 3. 解析响应
		thought, actionStr, isFinal, err := parseResponse(response)
		if err != nil {
			a.state.AddError(fmt.Sprintf("解析响应失败: %v", err))
			return a.state, fmt.Errorf("解析响应失败: %v", err)
		}
		
		// 创建新步骤
		step := Step{
			Thought: thought,
			Timestamp: time.Now(),
		}
		
		// 4. 如果是最终答案，结束循环
		if isFinal {
			a.state.FinalOutput = actionStr
			a.state.History = append(a.state.History, step)
			break
		}
		
		// 5. 解析工具调用
		toolName, params, err := parseActionString(actionStr)
		if err != nil {
			observation := fmt.Sprintf("错误: 解析工具调用失败: %v", err)
			step.Observation = observation
			a.state.History = append(a.state.History, step)
			continue
		}
		
		// 6. 查找工具
		tool, exists := a.tools.Get(toolName)
		if !exists {
			observation := fmt.Sprintf("错误: 找不到请求的工具 '%s'", toolName)
			step.Observation = observation
			a.state.History = append(a.state.History, step)
			continue
		}
		
		// 7. 创建动作
		action := &Action{
			Tool:       toolName,
			Parameters: params,
		}
		step.Action = action
		
		// 8. 执行工具并获取观察结果
		observation, err := tool.Execute(ctx, params)
		if err != nil {
			observation = fmt.Sprintf("错误: 工具执行失败: %v", err)
		}
		step.Observation = observation
		action.Result = observation
		
		// 9. 更新状态
		a.state.History = append(a.state.History, step)
	}
	
	return a.state, nil
}

// buildPrompt 构建ReAct提示词
func (a *ReActAgent) buildPrompt() string {
	var sb strings.Builder
	
	// 系统指令
	sb.WriteString("你是一个智能SQL助手，使用思考-行动-观察循环来解决问题。\n\n")
	
	// 数据库信息
	sb.WriteString(fmt.Sprintf("数据库类型: %s\n", a.state.DBType))
	sb.WriteString(fmt.Sprintf("数据库名称: %s\n\n", a.state.DBName))
	
	// 工具列表
	sb.WriteString("你可以使用以下工具：\n")
	for _, tool := range a.tools.GetAll() {
		sb.WriteString(fmt.Sprintf("- %s: %s\n", tool.Name(), tool.Description()))
		
		params := tool.ParameterSchema()
		if len(params) > 0 {
			sb.WriteString("  参数:\n")
			for name, desc := range params {
				sb.WriteString(fmt.Sprintf("    - %s: %s\n", name, desc))
			}
		}
	}
	
	// 交互格式指南
	sb.WriteString(`
使用以下格式回应:

思考: <思考解决问题需要哪些步骤>
行动: <工具名称>(<参数JSON>)

或者，如果你已经得到最终答案:

思考: <最终思考>
回答: <最终SQL>
`)
	
	// 用户查询
	sb.WriteString(fmt.Sprintf("\n用户查询: %s\n\n", a.state.Query))
	
	// 历史交互
	for i, step := range a.state.History {
		sb.WriteString(fmt.Sprintf("步骤 %d:\n", i+1))
		sb.WriteString(fmt.Sprintf("思考: %s\n", step.Thought))
		
		if step.Action != nil {
			sb.WriteString(fmt.Sprintf("行动: %s(%+v)\n", 
				step.Action.Tool, step.Action.Parameters))
			sb.WriteString(fmt.Sprintf("观察: %s\n\n", step.Observation))
		}
	}
	
	// 当前轮次提示
	sb.WriteString("思考: ")
	
	return sb.String()
}

// parseResponse 解析LLM响应
func parseResponse(response string) (thought string, action string, isFinal bool, err error) {
	lines := strings.Split(response, "\n")
	
	thoughtStart := -1
	actionStart := -1
	answerStart := -1
	
	// 查找思考、行动或回答行
	for i, line := range lines {
		line = strings.TrimSpace(line)
		
		if strings.HasPrefix(strings.ToLower(line), "思考:") {
			thoughtStart = i
		} else if strings.HasPrefix(strings.ToLower(line), "行动:") {
			actionStart = i
		} else if strings.HasPrefix(strings.ToLower(line), "回答:") {
			answerStart = i
		}
	}
	
	// 提取思考
	if thoughtStart >= 0 {
		// 提取思考内容，直到行动或回答行
		endIdx := len(lines)
		if actionStart > thoughtStart {
			endIdx = actionStart
		} else if answerStart > thoughtStart {
			endIdx = answerStart
		}
		
		thoughtLines := lines[thoughtStart:endIdx]
		if len(thoughtLines) > 0 {
			// 移除"思考:"前缀
			thoughtLines[0] = strings.TrimPrefix(strings.TrimPrefix(
				strings.TrimSpace(thoughtLines[0]), "思考:"), "思考：")
			thought = strings.Join(thoughtLines, "\n")
			thought = strings.TrimSpace(thought)
		}
	}
	
	// 检查是否有行动
	if actionStart >= 0 {
		// 提取行动内容
		endIdx := len(lines)
		if answerStart > actionStart {
			endIdx = answerStart
		}
		
		actionLines := lines[actionStart:endIdx]
		if len(actionLines) > 0 {
			// 移除"行动:"前缀
			actionLines[0] = strings.TrimPrefix(strings.TrimPrefix(
				strings.TrimSpace(actionLines[0]), "行动:"), "行动：")
			action = strings.Join(actionLines, " ")
			action = strings.TrimSpace(action)
		}
		
		return thought, action, false, nil
	}
	
	// 检查是否有最终回答
	if answerStart >= 0 {
		// 提取回答内容
		answerLines := lines[answerStart:]
		if len(answerLines) > 0 {
			// 移除"回答:"前缀
			answerLines[0] = strings.TrimPrefix(strings.TrimPrefix(
				strings.TrimSpace(answerLines[0]), "回答:"), "回答：")
			action = strings.Join(answerLines, "\n")
			action = strings.TrimSpace(action)
		}
		
		return thought, action, true, nil
	}
	
	// 没有找到行动或回答
	return thought, "", false, fmt.Errorf("无法从响应中解析行动或回答")
}

// parseActionString 解析行动字符串
func parseActionString(actionStr string) (toolName string, params map[string]interface{}, err error) {
	// 初始化参数
	params = make(map[string]interface{})
	
	// 匹配工具名称和参数部分
	parts := strings.SplitN(actionStr, "(", 2)
	if len(parts) < 2 {
		return "", nil, fmt.Errorf("无法解析工具调用: %s", actionStr)
	}
	
	// 提取工具名称
	toolName = strings.TrimSpace(parts[0])
	
	// 提取参数字符串
	paramsStr := strings.TrimSpace(parts[1])
	// 移除结尾的")"
	paramsStr = strings.TrimSuffix(paramsStr, ")")
	
	// 解析参数
	paramPairs := strings.Split(paramsStr, ",")
	for _, pair := range paramPairs {
		pair = strings.TrimSpace(pair)
		if pair == "" {
			continue
		}
		
		keyValue := strings.SplitN(pair, "=", 2)
		if len(keyValue) < 2 {
			return "", nil, fmt.Errorf("无效的参数格式: %s", pair)
		}
		
		key := strings.TrimSpace(keyValue[0])
		value := strings.TrimSpace(keyValue[1])
		
		// 去除可能的引号
		value = strings.Trim(value, `"'`)
		
		params[key] = value
	}
	
	return toolName, params, nil
}
