# 交互式 SQL 生成使用指南

## 概述

交互式 SQL 生成模式允许 LLM 在生成最终 SQL 查询之前，先对数据库执行探索性查询以获取必要的业务信息。这对于复杂的业务逻辑判断特别有用，比如判断员工是否在试用期内。

## 工作原理

1. **分析阶段**: LLM 首先分析自然语言问题和数据库 Schema
2. **探索阶段**: 如果需要，LLM 会生成查询 SQL 来了解数据的具体情况
3. **执行查询**: 系统执行这些查询并返回结果摘要（遵循最小必要原则）
4. **生成阶段**: 基于查询到的信息，LLM 生成最终的 SQL 查询

## 使用方法

### 基本用法

```bash
./predict --config configs/llm_config.yaml \
         --dataset configs/datasets/ccspider_pg_fields.json \
         --interactive \
         --db-type postgres \
         --id 329969630
```

### 完整参数说明

- `--interactive`: 启用交互式模式
- `--config`: LLM 配置文件路径
- `--dataset`: 数据集配置文件路径
- `--db-type`: 数据库类型（推荐使用 postgres）
- `--id`: 特定样例 ID（可选，用于测试）
- `--output-dir`: 输出目录（默认 results）

### 示例场景

#### 场景 1：试用期员工判断

**问题**: "2023 年有多少员工在试用期内获得了客户满意度奖？"

**交互过程**:

1. LLM 发现需要了解如何判断员工是否在试用期
2. 执行查询: `SELECT DISTINCT status FROM probation_employees LIMIT 10`
3. 发现 status 字段包含 '在职'、'离职' 等值
4. 执行查询: `SELECT employee_id, start_date, end_date FROM probation_employees WHERE status = '在职' LIMIT 5`
5. 了解试用期的时间范围表示方法
6. 生成最终 SQL

#### 场景 2：数据格式探索

**问题**: "查找所有在北京工作的员工"

**交互过程**:

1. 查询地址字段的具体格式: `SELECT DISTINCT address FROM employees WHERE address LIKE '%北京%' LIMIT 10`
2. 了解地址存储格式（如："北京市朝阳区 xxx"）
3. 生成准确的查询条件

## 输出格式

交互式模式会生成增强的输出，包含：

```json
{
  "idx": 329969630,
  "db_id": "hr",
  "question": "2023年有多少员工在试用期内获得了客户满意度奖？",
  "ground_truth": "SELECT COUNT(DISTINCT pe.employee_id) FROM...",
  "pred": "SELECT COUNT(DISTINCT e.employee_id) FROM...",
  "thinking": "LLM的思考过程",
  "ambiguous": "False",
  "steps": [
    {
      "step_type": "query",
      "query": "SELECT DISTINCT status FROM probation_employees LIMIT 10",
      "query_result": "{\"success\":true,\"rows\":[...],\"summary\":\"...\"}",
      "reasoning": "需要了解试用期状态的表示方法"
    },
    {
      "step_type": "final",
      "reasoning": "基于查询结果生成最终SQL"
    }
  ],
  "total_steps": 2,
  "query_count": 1,
  "is_interactive": true
}
```

## 安全限制

- **最大查询次数**: 5 次
- **单次查询返回行数**: 最多 10 行
- **查询超时**: 每个查询最多 1 分钟
- **最小必要原则**: 只返回确定最终 SQL 所需的最少信息

## 提示词设计

LLM 会收到以下格式的提示：

```
你需要将以下自然语言问题转换为 SQL 查询。

数据库结构:
[Schema信息]

问题:
[自然语言问题]

在生成最终 SQL 之前，你可以选择先查询数据库以获得必要的信息...

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

## 适用场景

交互式模式特别适合以下情况：

1. **复杂业务逻辑**: 需要了解数据的具体值来判断业务规则
2. **数据格式不明确**: 需要查看实际数据格式
3. **枚举值查询**: 需要了解状态字段的可能取值
4. **时间范围判断**: 需要了解时间字段的存储格式
5. **关联关系确认**: 需要验证表之间的关联方式

## 注意事项

1. 交互式模式会增加执行时间，建议用于复杂查询
2. 确保数据库连接稳定，避免查询中断
3. 监控查询的执行情况，必要时可以中断
4. 交互式结果文件会比普通结果文件更大

## 与非交互式模式的对比

| 特性     | 非交互式模式 | 交互式模式   |
| -------- | ------------ | ------------ |
| 执行速度 | 快           | 较慢         |
| 准确性   | 一般         | 更高         |
| 适用场景 | 简单查询     | 复杂业务逻辑 |
| 资源消耗 | 低           | 较高         |
| 调试信息 | 基本         | 详细         |
