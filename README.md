# GoSql

> GoSql 是一个基于 Go 语言的 Text-to-SQL 项目，能够将自然语言问题转换为 SQL 查询语句。

## 项目概述

GoSql 利用大型语言模型(LLM)的能力，将自然语言问题转换为 SQL 查询语句，并评估生成 SQL 的正确性。项目支持中英文查询，并提供灵活的配置选项来控制 SQL 生成行为。

## 主要特性

- **多 LLM 提供商支持**：支持 OpenAI、Azure OpenAI 和 Google Gemini 等多种 LLM 服务
- **多语言支持**：支持处理中文和英文自然语言问题
- **中文词汇处理**：可配置是否保留中文词汇或将其翻译为英文
- **数据集支持**：支持 Spider 和 CSpider 数据集
- **SQL 评估**：使用 test-suite-sql-eval 评估 SQL 正确性
- **思考过程**：可选择是否保存 LLM 的思考过程
- **灵活配置**：通过命令行参数和配置文件提供丰富的自定义选项

## 项目结构

```
GoSql/
├── cmd/                # 命令行工具
│   └── predict/        # SQL预测工具
├── configs/            # 配置文件
│   ├── datasets/       # 数据集配置
│   └── models/         # 模型配置
├── data/               # 数据集文件
│   ├── spider/         # Spider数据集
│   └── cspider/        # CSpider数据集
├── internal/           # 内部包
│   ├── dataset/        # 数据集处理
│   ├── llm/            # LLM通信模块
│   └── schema/         # 数据库Schema处理
├── results/            # 结果输出目录
├── scripts/            # 脚本文件
└── README.md           # 项目说明
```

## 快速开始

### 安装

1. 克隆仓库
```bash
git clone https://github.com/yourusername/GoSql.git
cd GoSql
```

2. 安装依赖
```bash
go mod download
```

### 配置

在 `configs` 目录下配置相应的 LLM 提供商和数据集：

1. 配置 LLM 提供商（OpenAI、Azure 或 Gemini）
2. 配置数据集路径和类型

### 运行

使用提供的脚本运行：

```bash
# 使用默认配置运行（将中文翻译为英文）
./run_r1.sh

# 保留原始中文词汇
./run_r1.sh --preserve-chinese=true

# 限制处理的样例数量
./run_r1.sh --limit 10
```

或者直接使用 `gosql-predict` 命令：

```bash
go build -o bin/gosql-predict ./cmd/predict
./bin/gosql-predict \
  --dataset configs/datasets/cspider.json \
  --provider openai \
  --model deepseek-r1-250120 \
  --preserve-chinese=true
```

## 配置选项

### 命令行参数

- `--dataset`：数据集配置文件路径
- `--provider`：LLM 提供商 (openai, azure, gemini)
- `--model`：模型名称
- `--split`：数据集分割 (train, dev, test)
- `--limit`：最大样例数量
- `--disable-thinking`：禁用思考过程
- `--preserve-chinese`：是否保留中文词汇不翻译

### 中文词汇处理

项目提供了灵活的中文词汇处理选项：

- 当 `--preserve-chinese=true` 时：保留原始中文词汇不变
  例如：`WHERE Country = '法国'`

- 当 `--preserve-chinese=false` 时（默认）：将中文地名、国家名和人名翻译为英文，并以大写字母开头
  例如：`WHERE Country = 'France'`

## 结果输出

执行结果将保存在 `results` 目录下，包含：

- `info.jsonl`：详细的执行信息，包括问题、生成的 SQL、标准 SQL 和执行时间
- `pred.sql`：生成的 SQL 语句

## 开发指南

### 添加新的 LLM 提供商

1. 在 `internal/llm` 目录下创建新的提供商实现
2. 实现 `LLM` 接口
3. 在 `factory.go` 中注册新的提供商

### 添加新的数据集

1. 在 `configs/datasets` 目录下创建新的数据集配置
2. 在 `internal/dataset` 中实现相应的加载逻辑

## 许可证

[MIT License](LICENSE)