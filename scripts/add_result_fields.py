#!/usr/bin/env python3
import json
import re
import os
import argparse

def extract_select_fields(query):
    """从SQL查询中提取SELECT子句中的字段"""
    # 确保查询是一个字符串
    if not isinstance(query, str):
        return []
    
    # 找到SELECT和FROM之间的部分
    match = re.search(r'SELECT\s+(.*?)\s+FROM', query, re.IGNORECASE | re.DOTALL)
    if not match:
        return []
    
    select_clause = match.group(1).strip()
    
    # 处理可能的子查询和特殊情况
    # 分割字段，考虑括号内的表达式不会被错误分割
    fields = []
    current_field = ""
    nested_level = 0
    
    for char in select_clause:
        if char == ',' and nested_level == 0:
            fields.append(current_field.strip())
            current_field = ""
        else:
            current_field += char
            if char == '(':
                nested_level += 1
            elif char == ')':
                nested_level -= 1
    
    # 添加最后一个字段
    if current_field.strip():
        fields.append(current_field.strip())
    
    # 清理字段名称
    cleaned_fields = []
    for field in fields:
        # 处理AS别名
        field = re.sub(r'\s+AS\s+.*$', '', field, flags=re.IGNORECASE)
        field = field.strip()
        cleaned_fields.append(field)
    
    return cleaned_fields

def update_dataset_with_result_fields(file_path):
    """更新数据集，为每个查询添加result_fields属性"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 添加result_fields到每个查询
        for item in data:
            if 'query' in item:
                result_fields = extract_select_fields(item['query'])
                item['result_fields'] = result_fields
        
        # 保存更新后的文件
        output_path = file_path.replace('.json', '_with_fields.json')
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        print(f"已成功处理文件，结果保存至: {output_path}")
        print(f"处理了 {len(data)} 条记录")
        return True
    except Exception as e:
        print(f"处理文件时出错: {e}")
        return False

def update_dataset_with_result_fields(file_path, overwrite=False):
    """更新数据集，为每个查询添加result_fields属性"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 添加result_fields到每个查询
        field_counts = {}
        for item in data:
            if 'query' in item:
                result_fields = extract_select_fields(item['query'])
                item['result_fields'] = result_fields
                
                # 统计字段数量
                num_fields = len(result_fields)
                field_counts[num_fields] = field_counts.get(num_fields, 0) + 1
        
        # 保存更新后的文件
        if overwrite:
            output_path = file_path
        else:
            output_path = file_path.replace('.json', '_with_fields.json')
            
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        print(f"已成功处理文件，结果保存至: {output_path}")
        print(f"处理了 {len(data)} 条记录")
        
        # 打印字段统计
        print("\n字段数量统计:")
        for count, num in sorted(field_counts.items()):
            print(f"  {count} 个字段: {num} 条记录 ({num/len(data)*100:.2f}%)")
            
        return True
    except Exception as e:
        print(f"处理文件时出错: {e}")
        return False

def process_directory(directory_path, pattern="*.json", overwrite=False):
    """处理目录中所有匹配的JSON文件"""
    import glob
    
    json_files = glob.glob(os.path.join(directory_path, pattern))
    
    if not json_files:
        print(f"在 {directory_path} 中没有找到匹配的JSON文件")
        return
    
    for file_path in json_files:
        # 跳过已经处理过的文件
        if not overwrite and "_with_fields.json" in file_path:
            continue
            
        print(f"\n处理文件: {file_path}")
        update_dataset_with_result_fields(file_path, overwrite)

def main():
    parser = argparse.ArgumentParser(description='为SQL数据集添加result_fields字段')
    parser.add_argument('path', help='要处理的JSON文件路径或目录')
    parser.add_argument('--recursive', '-r', action='store_true', help='递归处理目录中的所有JSON文件')
    parser.add_argument('--overwrite', '-o', action='store_true', help='覆盖原始文件而不是创建新文件')
    parser.add_argument('--pattern', '-p', default='*.json', help='文件匹配模式，默认为*.json')
    
    args = parser.parse_args()
    
    if os.path.isdir(args.path):
        if args.recursive:
            for root, _, _ in os.walk(args.path):
                process_directory(root, args.pattern, args.overwrite)
        else:
            process_directory(args.path, args.pattern, args.overwrite)
    else:
        update_dataset_with_result_fields(args.path, args.overwrite)

if __name__ == "__main__":
    main()
