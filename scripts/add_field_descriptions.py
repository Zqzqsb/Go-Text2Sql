#!/usr/bin/env python3
import json
import argparse
import os
import time
import yaml
import requests
from concurrent.futures import ThreadPoolExecutor, as_completed

class LLMClient:
    def __init__(self, config_path):
        """初始化LLM客户端"""
        with open(config_path, 'r') as f:
            config = yaml.safe_load(f)
        
        self.model = config['llm']['model']
        self.temperature = config['llm']['temperature']
        self.max_tokens = config['llm']['max_tokens']
        self.api_key = config['llm']['openai']['api_key']
        self.base_url = config['llm']['openai']['base_url']
        
        print(f"LLM配置已加载: 模型={self.model}, API={self.base_url}")
    
    def call_llm(self, prompt):
        """调用LLM API"""
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self.api_key}"
        }
        
        data = {
            "model": self.model,
            "messages": [{"role": "user", "content": prompt}],
            "temperature": self.temperature,
            "max_tokens": self.max_tokens
        }
        
        try:
            response = requests.post(
                f"{self.base_url}/chat/completions", 
                headers=headers,
                json=data
            )
            
            if response.status_code == 200:
                result = response.json()
                return result['choices'][0]['message']['content'].strip()
            else:
                print(f"API调用失败: HTTP {response.status_code}")
                print(f"错误信息: {response.text}")
                return None
        except Exception as e:
            print(f"API调用异常: {e}")
            return None

def generate_field_description(fields, llm_client):
    """仅基于字段列表生成自然语言描述"""
    if not fields:
        return "没有需要返回的字段。"
    
    prompt = f"""
作为一个SQL专家，请仅根据以下字段列表生成一段简洁的自然语言描述。

字段列表: {', '.join(fields)}

请分析这些字段的结构和可能的含义，生成一段简短描述，说明这些字段可能包含什么信息。
描述应该简洁明了，不超过2-3句话。从"该查询需要返回"开始你的回答。
不要猜测查询的目的或具体业务场景，只描述这些字段的普遍含义。
注意: 不要透露具体的字段信息, 仅仅返回关于他们的自然语言描述，比如需要 员工的标识，员工的入职时间，而不是 e.id , e.itime.
"""
    
    # 调用LLM API获取描述
    description = llm_client.call_llm(prompt)
    
    # API调用失败，提供默认描述
    if not description:
        return f"该查询需要返回以下字段: {', '.join(fields)}。"
    
    return description

def process_file(file_path, config_path, output_path=None, max_workers=5, batch_size=10):
    """处理单个JSON文件，为每个查询添加字段描述"""
    print(f"处理文件: {file_path}")
    
    try:
        # 加载数据
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 初始化LLM客户端
        llm_client = LLMClient(config_path)
        
        # 计算需要处理的项目数量
        total_items = len(data)
        items_with_fields = [item for item in data if 'result_fields' in item]
        items_without_fields = [item for item in data if 'result_fields' not in item]
        
        print(f"总记录数: {total_items}")
        print(f"已有result_fields的记录数: {len(items_with_fields)}")
        print(f"没有result_fields的记录数: {len(items_without_fields)}")
        
        # 如果没有已处理的字段，先使用add_result_fields.py
        if len(items_with_fields) == 0:
            print("没有找到result_fields，请先运行add_result_fields.py处理数据集")
            return False
        
        # 分批处理，避免过多API调用
        for i in range(0, len(items_with_fields), batch_size):
            batch = items_with_fields[i:i+batch_size]
            print(f"处理批次 {i//batch_size + 1}/{(len(items_with_fields)-1)//batch_size + 1}, 项目数: {len(batch)}")
            
            with ThreadPoolExecutor(max_workers=max_workers) as executor:
                futures = {}
                
                for item in batch:
                    if 'result_fields' in item:
                        # 提交任务到线程池 - 只使用result_fields
                        future = executor.submit(
                            generate_field_description, 
                            item['result_fields'],
                            llm_client
                        )
                        futures[future] = item
                
                # 处理完成的结果
                for future in as_completed(futures):
                    item = futures[future]
                    try:
                        description = future.result()
                        item['result_fields_description'] = description
                        print(f"已处理字段: {', '.join(item['result_fields'][:2])}...")
                    except Exception as e:
                        print(f"处理异常: {e}")
                
            # 每批休息几秒，避免API限制
            if i + batch_size < len(items_with_fields):
                print("休息1秒...")
                time.sleep(1)
        
        # 添加之前没有result_fields的项目回到数据中
        data = items_with_fields + items_without_fields
        
        # 保存结果
        if output_path is None:
            output_path = file_path.replace('.json', '_with_descriptions.json')
            
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        print(f"处理完成，结果已保存至: {output_path}")
        return True
    
    except Exception as e:
        print(f"处理文件时出错: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='为SQL数据集字段添加自然语言描述')
    parser.add_argument('file', help='要处理的JSON文件路径')
    parser.add_argument('--config', '-c', required=True, help='LLM配置文件路径')
    parser.add_argument('--output', '-o', help='输出文件路径，默认为原文件名加_with_descriptions')
    parser.add_argument('--batch-size', '-b', type=int, default=10, help='批处理大小')
    parser.add_argument('--workers', '-w', type=int, default=3, help='线程池大小')
    
    args = parser.parse_args()
    
    process_file(args.file, args.config, args.output, args.workers, args.batch_size)

if __name__ == "__main__":
    main()
