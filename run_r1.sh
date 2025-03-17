#!/bin/bash

# 默认值
PRESERVE_CHINESE=false
START=0
END=5

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
    --start=*)
      START="${1#*=}"
      shift
      ;;
    --end=*)
      END="${1#*=}"
      shift
      ;;
    *)
      # 保存其他参数
      ARGS+=("$1")
      shift
      ;;
  esac
done

# 设置工作目录
cd "$(dirname "$0")"
echo "当前工作目录: $(pwd)"

# 重新编译predict命令
echo "正在编译 gosql-predict..."
go build -v -o bin/gosql-predict ./cmd/predict
if [ $? -eq 0 ]; then
  echo "编译成功!"
else
  echo "编译失败，退出"
  exit 1
fi

# 运行predict命令
echo "运行参数: --preserve-chinese=$PRESERVE_CHINESE --start=$START --end=$END ${ARGS[*]}"
./bin/gosql-predict \
  --dataset configs/datasets/cspider.json \
  --provider openai \
  --model deepseek-r1-250120\
  --start $START \
  --end $END \
  --use-index=true \
  --preserve-chinese=$PRESERVE_CHINESE \
  "${ARGS[@]}"
