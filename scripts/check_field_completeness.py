#!/usr/bin/env python3
"""
检查数据文件中 result_fields 和 result_fields_description 字段的完整性
"""

import json
import sys
from pathlib import Path

def check_field_completeness(file_path):
    """检查JSON文件中字段的完整性"""
    print(f"正在检查文件: {file_path}")
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        print(f"❌ 读取文件失败: {e}")
        return
    
    if not isinstance(data, list):
        print("❌ 文件格式错误: 期望JSON数组")
        return
    
    total_count = len(data)
    missing_result_fields = []
    missing_result_fields_description = []
    empty_result_fields = []
    empty_result_fields_description = []
    
    print(f"📊 总条目数: {total_count}")
    print("🔍 正在检查每个条目...")
    
    for i, item in enumerate(data):
        if not isinstance(item, dict):
            print(f"⚠️  条目 {i} 不是字典类型")
            continue
            
        # 检查 result_fields 字段
        if 'result_fields' not in item:
            missing_result_fields.append(i)
        elif not item['result_fields']:  # 空数组或None
            empty_result_fields.append(i)
        
        # 检查 result_fields_description 字段
        if 'result_fields_description' not in item:
            missing_result_fields_description.append(i)
        elif not item['result_fields_description']:  # 空字符串或None
            empty_result_fields_description.append(i)
    
    # 输出统计结果
    print("\n" + "="*60)
    print("📈 完整性统计报告")
    print("="*60)
    
    # result_fields 统计
    missing_rf_count = len(missing_result_fields)
    empty_rf_count = len(empty_result_fields)
    complete_rf_count = total_count - missing_rf_count - empty_rf_count
    
    print(f"\n🏷️  result_fields 字段:")
    print(f"   ✅ 完整: {complete_rf_count}/{total_count} ({complete_rf_count/total_count*100:.1f}%)")
    print(f"   ❌ 缺失: {missing_rf_count}")
    print(f"   ⚠️  为空: {empty_rf_count}")
    
    # result_fields_description 统计
    missing_rfd_count = len(missing_result_fields_description)
    empty_rfd_count = len(empty_result_fields_description)
    complete_rfd_count = total_count - missing_rfd_count - empty_rfd_count
    
    print(f"\n📝 result_fields_description 字段:")
    print(f"   ✅ 完整: {complete_rfd_count}/{total_count} ({complete_rfd_count/total_count*100:.1f}%)")
    print(f"   ❌ 缺失: {missing_rfd_count}")
    print(f"   ⚠️  为空: {empty_rfd_count}")
    
    # 同时完整的统计
    both_complete = 0
    for i, item in enumerate(data):
        if (i not in missing_result_fields and 
            i not in empty_result_fields and
            i not in missing_result_fields_description and 
            i not in empty_result_fields_description):
            both_complete += 1
    
    print(f"\n🎯 两个字段都完整: {both_complete}/{total_count} ({both_complete/total_count*100:.1f}%)")
    
    # 详细的问题条目
    if missing_result_fields:
        print(f"\n❌ 缺失 result_fields 的条目索引 (前10个): {missing_result_fields[:10]}")
        if len(missing_result_fields) > 10:
            print(f"   ... 还有 {len(missing_result_fields)-10} 个")
    
    if missing_result_fields_description:
        print(f"\n❌ 缺失 result_fields_description 的条目索引 (前10个): {missing_result_fields_description[:10]}")
        if len(missing_result_fields_description) > 10:
            print(f"   ... 还有 {len(missing_result_fields_description)-10} 个")
    
    if empty_result_fields:
        print(f"\n⚠️  result_fields 为空的条目索引 (前10个): {empty_result_fields[:10]}")
        if len(empty_result_fields) > 10:
            print(f"   ... 还有 {len(empty_result_fields)-10} 个")
    
    if empty_result_fields_description:
        print(f"\n⚠️  result_fields_description 为空的条目索引 (前10个): {empty_result_fields_description[:10]}")
        if len(empty_result_fields_description) > 10:
            print(f"   ... 还有 {len(empty_result_fields_description)-10} 个")
    
    # 生成待修复的条目列表
    need_repair = set()
    need_repair.update(missing_result_fields)
    need_repair.update(missing_result_fields_description)
    need_repair.update(empty_result_fields)
    need_repair.update(empty_result_fields_description)
    
    if need_repair:
        print(f"\n🔧 需要修复的条目总数: {len(need_repair)}")
        repair_file = file_path.replace('.json', '_repair_list.txt')
        with open(repair_file, 'w') as f:
            for idx in sorted(need_repair):
                f.write(f"{idx}\n")
        print(f"📄 已生成修复列表文件: {repair_file}")
    
    return {
        'total': total_count,
        'result_fields_complete': complete_rf_count,
        'result_fields_description_complete': complete_rfd_count,
        'both_complete': both_complete,
        'need_repair': sorted(need_repair)
    }

def main():
    # 检查多个文件
    files_to_check = [
        "data/ccspider_pg/dev_with_fields_with_descriptions.json",
        "data/ccspider_pg/dev_with_fields.json",
    ]
    
    for file_path in files_to_check:
        if Path(file_path).exists():
            print(f"\n{'='*80}")
            result = check_field_completeness(file_path)
            print(f"{'='*80}")
        else:
            print(f"⚠️  文件不存在: {file_path}")

if __name__ == "__main__":
    main() 