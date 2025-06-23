## 数据集清洗

+ 将中电金信提供的数据集对齐到了 cspider 和 原生 postgresql 两种格式。

### PostgreSQL 数据集规模

> 下表分库展示了各主要数据库的表及其行数，反映了数据集的实际规模和多样性。

#### hr 库
| 表名                     | 行数   |
|--------------------------|--------|
| attendance_records       | 300000 |
| awards                   | 10000  |
| departments              | 10     |
| employees                | 10000  |
| interviews               | 10000  |
| performance_evaluations  | 10000  |
| probation_employees      | 6645   |

#### loan_user 库
| 表名                       | 行数  |
|----------------------------|-------|
| bank_orgnization           | 15    |
| credit_card_data           | 13    |
| currency                   | 23    |
| debit_card_information     | 20    |
| deposit_account_info       | 26    |
| deposit_type               | 7     |
| financial_products         | 20    |
| five_level_classification  | 5     |
| loan_application           | 7459  |
| loan_credit                | 15026 |
| loan_detail_info           | 13    |
| loan_repayment             | 22863 |
| loan_status                | 3     |
| loan_type                  | 3     |
| occupation                 | 5     |
| transfer                   | 7581  |
| user_behavior              | 7386  |
| customer                   | 5000  |

#### retail 库
| 表名            | 行数   |
|-----------------|--------|
| salesstatistics | 10000  |
| salesorders     | 10000  |
| stores          | 10000  |
| employees       | 10000  |
| orderdetails    | 10000  |
| products        | 10000  |

#### risk_control 库
| 表名                  | 行数   |
|-----------------------|--------|
| risk_monitoring_logs  | 10000  |
| customers             | 10000  |
| transactions          | 10000  |
| risk_assessments      | 10000  |
| audit_logs            | 10000  |
| risk_events           | 10000  |
| risk_indicators       | 10000  |
| rule_configurations   | 10000  |
| alerts                | 10000  |
| risk_reports          | 10000  |

#### supervise 库
| 表名                        | 行数   |
|-----------------------------|--------|
| liquidity_ratio              | 10000  |
| capital_adequacy_ratio       | 10000  |
| non_performing_loans         | 10000  |
| risk_exposure                | 10000  |
| related_party_transactions   | 10000  |
| compliance_records           | 10000  |
| income_statement             | 10000  |
| balance_sheet                | 9997   |
| regulatory_reports           | 10000  |
| financial_institution_info   | 10000  |

> 数据集涵盖了人力资源、信贷、零售、风控、监管等多领域，适合多样化的 SQL 任务和复杂业务场景分析。

## 项目使用

```shell
## 执行预测管线
go run cmd/predict/*.go --config configs/llms/config_deepseek_v3_0324.yaml --start 0 --end 1134 --dataset configs/datasets/ccspider_pg_fields.json --db-type pg --field-info-type fields

## 执行评估管线
go run cmd/analyze_results/*.go --input=results/pg_interactive_description --db-type=pg
```

## 问答样例

```shell
└> go run cmd/predict/*.go --config configs/llms/config_deepseek_v3_0324.yaml --start 10 --end 10 --dataset configs/datasets/ccspider_pg_fields.json --db-type postgres --fields-info-type fields 
使用PostgreSQL数据库
数据集: 类型=ccspider_pg, 名称=C-CSpider In PG With Fields
test样例数量: 1134
LLM客户端: 提供商=openai, 模型=deepseek-v3-250324

将处理 1 个样例
使用交互式 SQL 生成模式 (最大查询行数: 100)
处理样例 1/1...

================================================================================
🔄 开始处理问题 ID: 187164736 (数据库: hr)
❓ 问题: 2023年入职的员工中，哪些人在2024年10月5日有考勤记录，并且他们的绩效等级是什么？
📄 标准SQL: SELECT e.name, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.hire_date >= '2023-01-01' AND e.hire_date < '2024-01-01' AND a.date = '2024-10-05';
================================================================================
🏷️  使用字段列表: name, rating
🚀 开始交互式 SQL 生成...
📋 数据库Schema已加载，包含 7 个表

------------------------------------------------------------
🔄 第 1 步 (最多 5 步)
📝 即将发送给LLM的Prompt:
┌──────────────────────────────────────────────────────────┐
│ 你需要将以下问题转换为符合PostgreSQL语法的查询。
│ 
│ 数据库结构:
│ 数据库Schema信息:
│ 表名: attendance_records
│ 列:
│   - id: integer (主键)
│   - employee_id: character varying (外键)
│   - date: date
│   - check_in: time without time zone
│ ... (省略 90 行) ...
│ 
│ 注意：每个<query/>查询最多返回100行,<final/> sql 不受此限制(一定不要为最终 sql 添加 LIMIT 限制，除非问题里明确要求)。
│ 
│ 要求：生成正确的SQL，语法正确，逻辑符合问题要求，以分号结尾。
│ 
│ 返回字段:
│ name, rating
│ 
│ 请确保返回的字段严格符合上述要求,**不多字段也不少字段**。
│ 对于你返回的每个字段，都需要一个贴合语义的别名，所有字段不能够有相同的别名
└──────────────────────────────────────────────────────────┘
🤖 正在请求LLM响应... (尝试 1/3)
✅ LLM响应已收到:
┌──────────────────────────────────────────────────────────┐
│ <query>
│ SQL: SELECT e.name, p.rating
│ FROM employees e
│ JOIN performance_evaluations p ON e.employee_id = p.employee_id
│ JOIN attendance_records a ON e.employee_id = a.employee_id
│ WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
│ AND a.date = '2024-10-05';
│ REASONING: 这个查询首先连接employees表与performance_evaluations表获取员工姓名和绩效等级，然后连接attendance_records表筛选2024年10月5日的考勤记录，最后通过hire_date筛选2023年入职的员工。
│ NEED_MORE: false
│ </query>
└──────────────────────────────────────────────────────────┘
🔍 需要执行SQL查询:
┌──────────────────────────────────────────────────────────────────────────────┐
│ 📄 SQL: SELECT e.name, p.rating
FROM employees e
JOIN performance_evaluations p ON e.employee_id = p.employee_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
AND a.date = '2024-10-05';
│ 🤔 推理: 这个查询首先连接employees表与performance_evaluations表获取员工姓名和绩效等级，然后连接attendance_records表筛选2024年10月5日的考勤记录，最后通过hire_date筛选2023年入职的员工。
│ 🔄 是否可能需要更多查询: false
└──────────────────────────────────────────────────────────────────────────────┘
⚡ 正在执行查询...
✅ 查询执行成功!
┌──────────────────────────────────────────────────────────────────────────────┐
│ 查询返回 100 行数据 (已截断到前100行)
│ 样本数据: 
│ 行1: {name: 周秀英, rating: A+}
│ 行2: {name: 赵静, rating: B}
│ 行3: {name: 吴丽, rating: B+}
│ ...
└──────────────────────────────────────────────────────────────────────────────┘
📋 查询阶段结束
   原因: LLM表示不需要更多查询

------------------------------------------------------------
🔄 第 2 步 (最多 5 步)
📝 即将发送给LLM的Prompt:
┌──────────────────────────────────────────────────────────┐
│ 你需要将以下问题转换为符合PostgreSQL语法的查询。
│ 
│ 数据库结构:
│ 数据库Schema信息:
│ 表名: attendance_records
│ 列:
│   - id: integer (主键)
│   - employee_id: character varying (外键)
│   - date: date
│   - check_in: time without time zone
│ ... (省略 109 行) ...
│ 
│ 注意：每个<query/>查询最多返回100行,<final/> sql 不受此限制(一定不要为最终 sql 添加 LIMIT 限制，除非问题里明确要求)。
│ 
│ 要求：生成正确的SQL，语法正确，逻辑符合问题要求，以分号结尾。
│ 
│ 返回字段:
│ name, rating
│ 
│ 请确保返回的字段严格符合上述要求,**不多字段也不少字段**。
│ 对于你返回的每个字段，都需要一个贴合语义的别名，所有字段不能够有相同的别名
└──────────────────────────────────────────────────────────┘
🤖 正在请求LLM响应... (尝试 1/3)
✅ LLM响应已收到:
┌──────────────────────────────────────────────────────────┐
│ <final>
│ SELECT e.name AS name, p.rating AS rating
│ FROM employees e
│ JOIN performance_evaluations p ON e.employee_id = p.employee_id
│ JOIN attendance_records a ON e.employee_id = a.employee_id
│ WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
│ AND a.date = '2024-10-05';
│ </final>
└──────────────────────────────────────────────────────────┘

🏁 交互式生成完成!
📊 统计信息: 共 2 步，1 次查询
================================================================================

结果已保存到: results/C-CSpider In PG With Fields_test_pg_interactive_with_fields_info/info.jsonl
预测文件已保存到: results/C-CSpider In PG With Fields_test_pg_interactive_with_fields_info/pred.sql
SQL结果已保存到: results/C-CSpider In PG With Fields_test_pg_interactive_with_fields_info/sql_results
模糊问题结果已保存到: results/C-CSpider In PG With Fields_test_pg_interactive_with_fields_info/ambiguous_queries

总共处理了 1 个样例，其中 0 个是模糊查询
```

## 最新评测结果 2025-06-23

```shell
======================================
             SQL分析结果摘要             
======================================

总查询数: 1134
正确数量: 778 (精确匹配: 113, 语义等价: 665)
模糊查询: 33
错误数量: 323
总体正确率(排除模糊和参考答案错误): 76.54%

错误类型统计(按频率排序)
--------------------------------------
错误类型                         数量             百分比
----------------------------------------
行数错误                        188           16.58%
数据不一致错误                      55            4.85%
投影错误                          5            0.44%

详细错误分类统计
--------------------------------------
错误类型                         数量             百分比
----------------------------------------
语法错误                          0            0.00%
参考答案语法错误                     57            5.03%
投影错误                          5            0.44%
行数错误                        188           16.58%
数据不一致                        55            4.85%
执行错误                         18            1.59%
其他错误                          0            0.00%

分析完成，总耗时: 2m5.102663104s
```