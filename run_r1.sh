#!/bin/bash

# 默认值
PRESERVE_CHINESE=false

# 解析命令行参数
while [[ $# -gt 0 ]]; do
  case $1 in
    --preserve-chinese=*)
      PRESERVE_CHINESE="${1#*=}"
      shift
      ;;
    --no-preserve-chinese)
      PRESERVE_CHINESE=false
      shift
      ;;
    *)
      # 保存其他参数
      ARGS+=("$1")
      shift
      ;;
  esac
done

# 编译并运行 gosql-predict
cd "$(dirname "$0")" && \
# 重新编译predict命令
go build -o bin/gosql-predict ./cmd/predict && \
# 运行predict命令
./bin/gosql-predict \
  --dataset configs/datasets/cspider.json \
  --provider openai \
  --model deepseek-r1-250120 \
  --limit 5 \
  --preserve-chinese=$PRESERVE_CHINESE \
  "${ARGS[@]}"
