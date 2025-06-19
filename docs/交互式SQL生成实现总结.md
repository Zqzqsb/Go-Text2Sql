# 交互式 SQL 生成功能实现总结

## 概述

我已经成功实现了交互式 SQL 生成功能，允许 LLM 在生成最终 SQL 之前先查询数据库以获取必要的业务信息。这个功能特别适用于处理复杂的业务逻辑判断，如试用期员工的识别等场景。

## 核心设计理念

### 1. 无状态设计

- LLM 层保持无状态，每次交互都提供全量信息
- 查询历史通过 prompt 传递，确保上下文连续性

### 2. 最小必要原则

- 每次查询只返回确定最终 SQL 所需的最少信息
- 限制查询返回行数（最多 10 行）
- 限制查询次数（最多 5 次）

### 3. 安全可控

- 查询超时机制（1 分钟）
- 错误处理和回退策略
- 数据摘要而不是原始数据返回

## 实现的文件和功能

### 1. 类型定义 (`cmd/predict/types.go`)

```go
// 新增的核心类型
type InteractiveStep struct {
    StepType    string // "query" 或 "final"
    Query       string // 查询 SQL
    QueryResult string // 查询结果（JSON 格式）
    Reasoning   string // 推理过程
}

type InteractiveResult struct {
    SQLResult
    Steps         []InteractiveStep
    TotalSteps    int
    QueryCount    int
    IsInteractive bool
}

type QueryRequest struct {
    SQL       string
    Reasoning string
    NeedMore  bool // 是否还需要更多查询
}

type QueryResponse struct {
    Success bool
    Error   string
    Rows    []map[string]interface{}
    Summary string // 查询结果的摘要
}
```

### 2. 交互式生成器 (`cmd/predict/interactive_generator.go`)

- **InteractiveGenerator**: 核心交互式生成器类
- **GenerateInteractiveSQL()**: 主要的交互式生成逻辑
- **buildInitialPrompt()**: 构建初始提示词
- **parseLLMResponse()**: 解析 LLM 响应
- **executeQuery()**: 执行数据库查询
- **generateQuerySummary()**: 生成查询结果摘要

### 3. 输出处理 (`cmd/predict/output.go`)

- **saveInteractiveResult()**: 保存交互式结果
- **printInteractiveResult()**: 显示交互式结果
- 更新了 **generatePredictionFile()** 以支持交互式结果解析

### 4. 主程序更新 (`cmd/predict/main.go`)

- 添加 `--interactive` 命令行参数
- 集成交互式生成器到主流程
- 支持交互式和非交互式模式的切换

## 工作流程

### 1. 分析阶段

```
输入: 自然语言问题 + 数据库 Schema
↓
LLM 分析是否需要查询数据库
```

### 2. 探索阶段（如果需要）

```
LLM 生成查询 SQL + 推理说明
↓
系统执行查询并生成摘要
↓
将查询历史添加到 prompt
↓
重复直到 LLM 认为信息足够或达到最大步数
```

### 3. 生成阶段

```
基于所有查询历史生成最终 SQL
↓
返回完整的交互式结果
```

## 提示词设计

### 初始提示词格式

```
你需要将以下自然语言问题转换为 SQL 查询。

数据库结构:
[Schema信息]

问题:
[自然语言问题]

在生成最终 SQL 之前，你可以选择先查询数据库以获得必要的信息。
这对于以下情况特别有用：
1. 需要了解数据的具体值或格式
2. 需要确认某些业务逻辑（如试用期的判断标准）
3. 需要查看数据分布以优化查询

请按以下格式回答：

如果你需要先查询数据库：
<query>
SQL: [你的查询SQL]
REASONING: [为什么需要这个查询]
NEED_MORE: [true/false，是否可能需要更多查询]
</query>

如果你可以直接生成最终SQL：
<final>
[你的最终SQL查询]
</final>
```

### 带历史的提示词

```
[初始提示词]

之前的查询历史:
查询 1:
SQL: SELECT DISTINCT status FROM probation_employees LIMIT 10
推理: 需要了解试用期状态的表示方法
结果: 查询返回 3 行数据
样本数据:
行1: {status: 在职}
行2: {status: 离职}
行3: {status: 试用期}
```

## 安全和限制

### 查询限制

- **最大查询次数**: 5 次
- **单次返回行数**: 最多 10 行
- **查询超时**: 1 分钟
- **样本数据显示**: 最多 3 行

### 错误处理

- 查询失败时自动回退到最终生成
- 解析失败时使用默认策略
- 超时时终止交互流程

### 数据保护

- 只返回必要的摘要信息
- 敏感数据不包含在日志中
- 查询结果在内存中限制大小

## 使用示例

### 基本命令

```bash
./predict --config configs/llm_config.yaml \
         --dataset configs/datasets/ccspider_pg_fields.json \
         --interactive \
         --db-type postgres \
         --id 329969630
```

### 输出目录结构

```
results/
├── ccspider_test_pg_interactive_with_no_field_info/
│   ├── info.jsonl          # 详细的交互式结果
│   ├── pred.sql            # 预测的 SQL 文件
│   └── sql_results/        # 分类的结果文件
```

## 适用场景分析

### 最适合的场景

1. **试用期判断**: 需要了解 `probation_employees` 表的业务逻辑
2. **状态枚举**: 需要了解状态字段的可能取值
3. **时间格式**: 需要确认日期时间字段的存储格式
4. **地址格式**: 需要了解地址字段的具体格式

### 示例案例

**问题**: "2023 年有多少员工在试用期内获得了客户满意度奖？"

**问题分析**:

- 需要理解"试用期内"的判断逻辑
- 可能需要查看 `probation_employees` 表的数据结构
- 需要了解时间范围的表示方法

**预期交互过程**:

1. 查询试用期状态: `SELECT DISTINCT status FROM probation_employees LIMIT 10`
2. 查询时间字段: `SELECT start_date, end_date FROM probation_employees WHERE status = '在职' LIMIT 5`
3. 生成最终 SQL，正确处理试用期的时间范围判断

## 技术亮点

### 1. 模块化设计

- 独立的 `InteractiveGenerator` 类
- 清晰的接口分离
- 易于测试和维护

### 2. 灵活的提示词系统

- 自适应的提示词构建
- 支持查询历史的累积
- 格式化的响应解析

### 3. 健壮的错误处理

- 多层次的错误回退
- 超时和资源限制
- 详细的日志记录

### 4. 兼容性设计

- 与现有系统完全兼容
- 可选的交互式模式
- 统一的输出格式

## 未来扩展方向

1. **智能查询优化**: 根据问题类型自动选择查询策略
2. **缓存机制**: 对常见查询结果进行缓存
3. **并行查询**: 支持多个查询的并行执行
4. **查询计划**: 让 LLM 生成完整的查询计划
5. **模板化**: 针对常见场景提供查询模板

## 总结

交互式 SQL 生成功能成功实现了以下目标：

✅ **无状态 LLM 设计**: 每次提供全量信息，保持 LLM 的无状态特性

✅ **最小必要原则**: 查询返回最少但足够的信息

✅ **安全可控**: 多重限制确保系统安全

✅ **完整集成**: 与现有系统无缝集成

✅ **易于使用**: 简单的命令行参数启用

这个功能特别适合处理像试用期员工判断这样需要了解具体业务数据的复杂场景，可以显著提高 SQL 生成的准确性。
