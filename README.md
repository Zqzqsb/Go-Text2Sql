## GoSql

> GoSql是一个基于Go语言的text2sql基座项目，用于将自然语言问题转换为SQL查询语句。

### 项目概述

> GoSql利用大型语言模型(LLM)的能力，将自然语言问题转换为SQL查询语句，并评估生成SQL的正确性。

### 主要特性

- 使用OpenAI API与LLM通信
- 支持Spider和CSpider数据集
- 使用test-suite-sql-eval评估SQL正确性
- 保存LLM的思考过程
- 确保最终输出为单条SQL语句

### 项目结构

```
GoSql/
├── cmd/                # 命令行工具
│   └── gosql/          # 主程序入口
├── internal/           # 内部包
│   ├── config/         # 配置管理
│   ├── llm/            # LLM通信模块
│   ├── eval/           # SQL评估模块
│   └── schema/         # 数据库Schema处理
├── pkg/                # 公共包
│   ├── db/             # 数据库操作
│   └── utils/          # 工具函数
├── scripts/            # 脚本文件
├── test/               # 测试文件
└── README.md           # 项目说明
```

### 安装与使用

1. 克隆仓库
```bash
git clone https://github.com/yourusername/GoSql.git
cd GoSql
```

2. 安装依赖
```bash
go mod download
```

3. 配置OpenAI API
```bash
cp config.example.yaml config.yaml
# 编辑config.yaml，填入你的API密钥和其他配置
```

4. 运行程序
```bash
go run cmd/gosql/main.go --question "查询所有学生的姓名和年龄" --db school
```

### 配置说明

在`config.yaml`中可以配置以下参数：

- `openai.api_key`: OpenAI API密钥
- `openai.base_url`: API基础URL
- `model.name`: 使用的模型名称
- `model.temperature`: 温度参数
- `eval.method`: 评估方法

### 开发指南

详细的开发文档请参考[开发指南](docs/development.md)。