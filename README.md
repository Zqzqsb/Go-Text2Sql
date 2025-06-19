# GoSQL

> 基于大语言模型的智能 Text-to-SQL 系统，支持交互式 SQL 生成和结果分析

## 项目概述

GoSQL 是一个基于 Go 语言开发的 Text-to-SQL 系统，能够将自然语言问题转换为 SQL 查询语句。项目支持多种大语言模型，提供交互式 SQL 生成模式，并包含完整的结果分析工具链。

## 核心特性

### 🚀 智能 SQL 生成

- **多模型支持**: OpenAI (GPT-3.5/GPT-4)、DeepSeek (V3/R1)、Azure OpenAI、Google Gemini
- **交互式生成**: LLM 可先查询数据库获取信息，再生成最终 SQL
- **多数据库支持**: SQLite、PostgreSQL
- **字段信息增强**: 支持精确字段描述和字段约束

### 🔍 智能结果分析

- **自动分类**: 根据执行结果自动分类正确/错误查询
- **错误类型识别**: 数据不匹配、执行错误、投影错误、引用错误等
- **模糊查询处理**: 自动识别和处理语义不明确的查询

### 🌐 多语言支持

- **中英文处理**: 完整支持中文和英文自然语言查询
- **中文词汇策略**: 可配置中文地名/人名的翻译处理
- **数据集支持**: Spider、C-Spider、CC-Spider 等主流数据集

## 项目结构

```
GoSQL/
├── cmd/                           # 命令行工具
│   ├── predict/                   # SQL预测工具
│   ├── analyze_results/           # 结果分析工具
│   └── gosql/                     # 主程序入口
├── configs/                       # 配置文件
│   ├── datasets/                  # 数据集配置
│   ├── llms/                      # LLM模型配置
│   ├── llm_config_example.yaml    # LLM配置示例
│   └── database_config_pg.yaml    # 数据库配置
├── internal/                      # 核心模块
│   ├── agents/                    # 智能代理系统
│   ├── database/                  # 数据库适配层
│   ├── dataset/                   # 数据集处理
│   ├── llm/                       # LLM通信模块
│   ├── schema/                    # 数据库Schema处理
│   └── eval/                      # 执行评估模块
├── results/                       # 结果输出目录
├── docs/                          # 文档
└── scripts/                       # 辅助脚本
```

## 快速开始

### 环境要求

- Go 1.19+
- PostgreSQL (可选，用于 PostgreSQL 数据集)

### 安装配置

1. **克隆仓库**

```bash
git clone <repository-url>
cd GoSQL
```

2. **安装依赖**

```bash
go mod download
```

3. **配置 LLM 服务** (必需)

   复制配置模板：

   ```bash
   cp configs/llm_config_example.yaml configs/your_config.yaml
   ```

   编辑配置文件，填入真实的 API 密钥：

   ```yaml
   llm:
     provider: "openai"
     model: "gpt-3.5-turbo"
     openai:
       api_key: "your-real-api-key-here"
       base_url: "https://api.openai.com/v1"
   ```

4. **准备数据集** (可选)

   项目内置样例数据集配置，如需使用完整数据集，请将数据文件放置到 `data/` 目录。

## 使用指南

### SQL 预测工具 (predict)

**基本用法：**

```bash
go run cmd/predict/*.go \
  --config configs/your_config.yaml \
  --dataset configs/datasets/spider.json \
  --start 0 --end 10
```

**交互式模式：**

```bash
go run cmd/predict/*.go \
  --config configs/your_config.yaml \
  --dataset configs/datasets/ccspider_pg_fields.json \
  --db-type postgres \
  --fields-info-type description \
  --interactive=true \
  --max-query-rows 10
```

**主要参数：**

- `--config`: LLM 配置文件路径
- `--dataset`: 数据集配置文件
- `--start/--end`: 处理样例范围
- `--db-type`: 数据库类型 (sqlite/postgres)
- `--fields-info-type`: 字段信息类型 (empty/fields/description)
- `--interactive`: 启用交互式 SQL 生成
- `--max-query-rows`: 交互式查询最大返回行数
- `--expand-schema`: 在日志中完整显示 schema
- `--verbose-debug`: 输出详细调试信息

### 结果分析工具 (analyze_results)

```bash
go run cmd/analyze_results/*.go \
  --input results/your_result_directory \
  --output analysis_report.json
```

**分析功能：**

- 自动分类正确/错误查询
- 生成错误类型统计
- 识别常见问题模式
- 生成详细分析报告

### 输出结果

运行完成后，结果保存在 `results/` 目录下：

```
results/your_experiment/
├── info.jsonl                    # 详细执行信息
├── pred.sql                      # 预测SQL语句
├── sql_results/                  # 单独结果文件
├── correct_exact_match/          # 完全匹配的正确结果
├── correct_equivalent/           # 语义等价的正确结果
├── incorrect_execution/          # 执行错误
├── incorrect_data_mismatch/      # 数据不匹配
├── incorrect_projection/         # 投影错误
├── incorrect_reference/          # 引用错误
├── incorrect_row_count/          # 行数不匹配
└── ambiguous_queries/            # 模糊查询
```

## 项目特点

### 技术优势

1. **模块化架构**: 清晰的分层设计，易于扩展和维护
2. **多模型适配**: 统一的 LLM 接口，支持主流模型无缝切换
3. **交互式智能**: LLM 可主动查询数据库，提高 SQL 生成准确性
4. **完整评估链**: 从生成到分析的完整工具链

### 实用特性

1. **中文优化**: 专门针对中文 Text-to-SQL 场景优化
2. **错误分类**: 细粒度的错误类型识别，便于问题定位
3. **可视化日志**: 清晰的控制台输出，支持调试信息控制
4. **灵活配置**: 丰富的命令行参数，适应不同使用场景

### 性能特点

1. **并发处理**: 支持批量处理大规模数据集
2. **内存优化**: 流式处理，支持大文件处理
3. **容错机制**: 完善的错误处理和恢复机制

## 配置说明

### LLM 配置示例

```yaml
llm:
  provider: "openai"
  model: "deepseek-v3-250324"
  temperature: 0.3
  max_tokens: 2048

  openai:
    api_key: "your-api-key"
    base_url: "https://api.deepseek.com/v1"
```

### 数据集配置示例

```json
{
  "type": "spider",
  "name": "Spider",
  "base_dir": "data/spider",
  "db_dir": "database",
  "test_file": "test.json"
}
```

## 已知问题和后续优化

### 当前限制

1. **复杂查询处理**: 对于涉及多层嵌套的复杂查询，准确率有待提升
2. **中文数值理解**: 对中文数字表达("三个月"、"前五名")的理解需要加强
3. **业务逻辑推理**: 对隐含的业务规则(如试用期判定标准)推理能力有限
4. **模糊查询处理**: 对语义不明确查询的处理策略需要进一步优化

### 计划改进

1. **增强语义理解**: 集成更多领域知识，提高对业务概念的理解
2. **多轮对话支持**: 支持澄清模糊查询的多轮交互
3. **结果验证机制**: 加入结果合理性检查和自动修正
4. **性能优化**: 减少不必要的 LLM 调用，提高响应速度

### 贡献指南

欢迎提交 Issue 和 Pull Request！主要需求：

1. **测试用例**: 补充更多边界情况的测试
2. **错误分析**: 完善错误类型分类规则
3. **文档完善**: 改进使用文档和代码注释
4. **新模型适配**: 支持更多 LLM 模型

## 许可证

MIT License
