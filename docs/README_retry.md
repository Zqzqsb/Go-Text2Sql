# LLM 重试机制使用指南

## 概述

交互式 SQL 生成器现在支持 LLM 调用失败时的自动重试机制，采用指数退避策略，提高系统的稳定性和容错能力。

## 重试策略

### 默认配置

- **最大重试次数**: 3 次
- **初始延迟**: 2 秒
- **最大延迟**: 30 秒
- **退避策略**: 指数退避（每次延迟时间 × 1.5）

### 重试流程

1. 第 1 次尝试失败 → 等待 2 秒
2. 第 2 次尝试失败 → 等待 3 秒（2 × 1.5）
3. 第 3 次尝试失败 → 等待 4.5 秒（3 × 1.5）
4. 如果第 3 次还是失败，则最终失败

## 使用方式

### 基本使用（默认配置）

```go
// 创建生成器，自动使用默认重试配置
generator := predict.NewInteractiveGenerator(llmClient, 10)

// 直接使用，重试会自动进行
result := generator.GenerateInteractiveSQL(dataset, example, options, dbType)
```

### 自定义重试配置

```go
generator := predict.NewInteractiveGenerator(llmClient, 10)

// 自定义重试参数：5次重试，初始延迟1秒，最大延迟15秒
generator.SetRetryConfig(5, 1*time.Second, 15*time.Second)

result := generator.GenerateInteractiveSQL(dataset, example, options, dbType)
```

### 禁用重试

```go
generator := predict.NewInteractiveGenerator(llmClient, 10)

// 设置重试次数为1，实际上禁用重试
generator.SetRetryConfig(1, 0, 0)
```

## 日志输出

重试过程中会输出详细的日志信息：

```
🤖 正在请求LLM响应... (尝试 1/3)
❌ LLM请求失败 (尝试 1/3): context deadline exceeded
🔄 第 1 次重试LLM请求，等待 2.0 秒...
🤖 正在请求LLM响应... (尝试 2/3)
✅ LLM重试成功！
```

## 适用场景

- **网络不稳定**: 临时网络问题导致的连接失败
- **API 限流**: LLM 服务商的临时限流
- **服务器过载**: LLM 服务器临时过载
- **超时错误**: 请求超时但服务正常

## 注意事项

1. **重试会增加总执行时间**，特别是在 LLM 服务持续不可用时
2. **指数退避策略**可以避免对服务器造成过大压力
3. **最大延迟限制**确保单次等待时间不会过长
4. **重试只针对网络/服务错误**，不会重试由于参数错误等导致的失败

## 最佳实践

- 在生产环境中建议保持默认配置
- 在测试环境中可以适当减少重试次数以加快测试速度
- 监控重试频率，如果重试过于频繁应检查 LLM 服务状态
