#!/usr/bin/env python3
"""
检查所有数据目录中的 result_fields 和 result_fields_description 字段完整性
"""

import json
import os
from pathlib import Path

def check_file_completeness(file_path):
    """检查单个文件的字段完整性"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        return {"error": f"读取失败: {e}"}
    
    if not isinstance(data, list):
        return {"error": "文件格式错误: 期望JSON数组"}
    
    total = len(data)
    has_rf = 0
    has_rfd = 0
    both_complete = 0
    
    for item in data:
        if not isinstance(item, dict):
            continue
            
        has_result_fields = 'result_fields' in item and item['result_fields']
        has_result_fields_desc = 'result_fields_description' in item and item['result_fields_description']
        
        if has_result_fields:
            has_rf += 1
        if has_result_fields_desc:
            has_rfd += 1
        if has_result_fields and has_result_fields_desc:
            both_complete += 1
    
    return {
        'total': total,
        'has_result_fields': has_rf,
        'has_result_fields_description': has_rfd,
        'both_complete': both_complete,
        'rf_percentage': has_rf / total * 100 if total > 0 else 0,
        'rfd_percentage': has_rfd / total * 100 if total > 0 else 0,
        'both_percentage': both_complete / total * 100 if total > 0 else 0
    }

def find_json_files(base_dir):
    """递归查找所有JSON文件"""
    json_files = []
    for root, dirs, files in os.walk(base_dir):
        for file in files:
            if file.endswith('.json'):
                json_files.append(os.path.join(root, file))
    return json_files

def main():
    print("🔍 正在查找所有数据文件...")
    
    # 查找data目录下所有JSON文件
    data_dir = "data"
    if not os.path.exists(data_dir):
        print("❌ data目录不存在")
        return
    
    json_files = find_json_files(data_dir)
    print(f"📄 找到 {len(json_files)} 个JSON文件")
    
    results = []
    
    for file_path in sorted(json_files):
        relative_path = os.path.relpath(file_path)
        print(f"\n{'='*80}")
        print(f"📂 正在检查: {relative_path}")
        
        result = check_file_completeness(file_path)
        
        if 'error' in result:
            print(f"❌ {result['error']}")
            continue
        
        result['file_path'] = relative_path
        results.append(result)
        
        # 输出结果
        print(f"📊 总条目数: {result['total']}")
        print(f"🏷️  result_fields:        {result['has_result_fields']:4d}/{result['total']} ({result['rf_percentage']:5.1f}%)")
        print(f"📝 result_fields_desc:   {result['has_result_fields_description']:4d}/{result['total']} ({result['rfd_percentage']:5.1f}%)")
        print(f"🎯 两字段都完整:        {result['both_complete']:4d}/{result['total']} ({result['both_percentage']:5.1f}%)")
    
    # 汇总报告
    print(f"\n{'='*80}")
    print("📈 汇总报告")
    print(f"{'='*80}")
    
    print(f"{'文件路径':<50} {'总数':<6} {'RF%':<6} {'RFD%':<6} {'完整%':<6}")
    print("-" * 80)
    
    for result in results:
        print(f"{result['file_path']:<50} {result['total']:<6} {result['rf_percentage']:<6.1f} {result['rfd_percentage']:<6.1f} {result['both_percentage']:<6.1f}")
    
    # 统计有字段描述的文件
    files_with_descriptions = [r for r in results if r['rfd_percentage'] > 0]
    files_complete = [r for r in results if r['both_percentage'] == 100.0]
    
    print(f"\n🎯 摘要:")
    print(f"   📄 总文件数: {len(results)}")
    print(f"   📝 有字段描述的文件: {len(files_with_descriptions)}")
    print(f"   ✅ 完全完整的文件: {len(files_complete)}")
    
    if files_with_descriptions:
        print(f"\n📝 包含字段描述的文件:")
        for result in files_with_descriptions:
            print(f"   - {result['file_path']} ({result['both_percentage']:.1f}% 完整)")

if __name__ == "__main__":
    main() 