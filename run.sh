#!/bin/bash

# 默认值
PRESERVE_CHINESE=false
START=0
END=5
DATASET="configs/datasets/cspider.json"
PROVIDER="openai"
MODEL="deepseek-r1-250120"
USE_INDEX=true
CONFIG="configs/config.yaml"
SPLIT="test"
OUTPUT_DIR="results"
DISABLE_THINKING=false
DB_TYPE="sqlite"  # 默认数据库类型

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
    --dataset=*)
      DATASET="${1#*=}"
      shift
      ;;
    --provider=*)
      PROVIDER="${1#*=}"
      shift
      ;;
    --model=*)
      MODEL="${1#*=}"
      shift
      ;;
    --use-index=*)
      USE_INDEX="${1#*=}"
      shift
      ;;
    --config=*)
      CONFIG="${1#*=}"
      shift
      ;;
    --split=*)
      SPLIT="${1#*=}"
      shift
      ;;
    --output-dir=*)
      OUTPUT_DIR="${1#*=}"
      shift
      ;;
    --disable-thinking=*)
      DISABLE_THINKING="${1#*=}"
      shift
      ;;
    --db-type=*)
      DB_TYPE="${1#*=}"
      shift
      ;;
    --db-type)
      DB_TYPE="$2"
      shift 2
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
echo "运行参数:"
echo "  --dataset=$DATASET"
echo "  --provider=$PROVIDER"
echo "  --model=$MODEL"
echo "  --start=$START"
echo "  --end=$END"
echo "  --use-index=$USE_INDEX"
echo "  --preserve-chinese=$PRESERVE_CHINESE"
echo "  --config=$CONFIG"
echo "  --split=$SPLIT"
echo "  --output-dir=$OUTPUT_DIR"
echo "  --disable-thinking=$DISABLE_THINKING"
echo "  --db-type=$DB_TYPE"
echo "  其他参数: ${ARGS[*]}"

./bin/gosql-predict \
  --dataset "$DATASET" \
  --provider "$PROVIDER" \
  --model "$MODEL" \
  --start "$START" \
  --end "$END" \
  --use-index="$USE_INDEX" \
  --preserve-chinese="$PRESERVE_CHINESE" \
  --config "$CONFIG" \
  --split "$SPLIT" \
  --output-dir "$OUTPUT_DIR" \
  --disable-thinking="$DISABLE_THINKING" \
  --db-type="$DB_TYPE" \
  "${ARGS[@]}"
