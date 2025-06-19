#!/usr/bin/env python3
import json
import argparse
import os
import time
import yaml
import requests
import psycopg2
import sqlite3
from concurrent.futures import ThreadPoolExecutor, as_completed

class DatabaseExecutor:
    def __init__(self, db_config):
        """初始化数据库连接"""
        self.db_type = db_config.get('type', 'postgresql')
        self.config = db_config
        
    def get_sql_fields(self, sql_query, db_id):
        """执行SQL查询并获取字段名列表"""
        try:
            if self.db_type == 'postgresql':
                return self._get_postgres_fields(sql_query, db_id)
            elif self.db_type == 'sqlite':
                return self._get_sqlite_fields(sql_query, db_id)
            else:
                raise ValueError(f"不支持的数据库类型: {self.db_type}")
        except Exception as e:
            print(f"执行SQL失败 (db_id: {db_id}): {e}")
            return None
    
    def _get_postgres_fields(self, sql_query, db_id):
        """从PostgreSQL获取字段"""
        # 清理SQL查询 - 移除末尾分号
        sql_query = sql_query.strip().rstrip(';')
        
        # 构造连接字符串
        conn_str = f"host={self.config['host']} port={self.config['port']} " \
                  f"dbname={db_id} user={self.config['user']} password={self.config['password']}"
        
        conn = psycopg2.connect(conn_str)
        try:
            cursor = conn.cursor()
            # 只获取字段信息，不执行完整查询
            limit_query = f"SELECT * FROM ({sql_query}) AS subquery LIMIT 0"
            cursor.execute(limit_query)
            
            # 获取字段名
            field_names = [desc[0] for desc in cursor.description]
            return field_names
        finally:
            conn.close()
    
    def _get_sqlite_fields(self, sql_query, db_id):
        """从SQLite获取字段"""
        # 清理SQL查询 - 移除末尾分号
        sql_query = sql_query.strip().rstrip(';')
        
        # 假设SQLite数据库文件在data目录下
        db_path = os.path.join(self.config.get('data_dir', 'data'), f"{db_id}.db")
        
        conn = sqlite3.connect(db_path)
        try:
            cursor = conn.cursor()
            # 只获取字段信息
            limit_query = f"SELECT * FROM ({sql_query}) LIMIT 0"
            cursor.execute(limit_query)
            
            # 获取字段名
            field_names = [desc[0] for desc in cursor.description]
            return field_names
        finally:
            conn.close()

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
                return None
        except Exception as e:
            print(f"API调用异常: {e}")
            return None

def generate_field_description_from_actual_fields(fields, question, llm_client):
    """基于实际执行得到的字段生成描述"""
    if not fields:
        return "该查询没有返回任何字段。"
    
    prompt = f"""
你是一个SQL专家。给定以下信息：

查询问题: {question}
实际SQL执行后的字段列表: {', '.join(fields)}

请生成一段简洁的字段描述，说明这些字段包含什么信息。要求：
1. 从"该查询需要返回"开始
2. 不要透露具体的字段名，而是描述字段的含义
3. 结合查询问题的背景，但主要基于字段列表
4. 保持简洁，2-3句话即可

示例：
- 如果字段是 ["customer_name", "total_amount", "order_count"]
- 应该描述为："该查询需要返回客户的名称、总金额以及订单数量。这些字段提供了客户的基本信息和购买统计。"
"""
    
    description = llm_client.call_llm(prompt)
    if not description:
        return f"该查询需要返回以下字段信息：{', '.join(fields)}。"
    
    return description

def process_dataset(file_path, db_config_path, llm_config_path, output_path=None, 
                   max_workers=3, batch_size=5):
    """处理数据集，为每个查询生成准确的字段描述"""
    print(f"处理文件: {file_path}")
    
    try:
        # 加载配置
        with open(db_config_path, 'r') as f:
            db_config = yaml.safe_load(f)
        
        # 加载数据
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 初始化执行器和LLM客户端
        db_executor = DatabaseExecutor(db_config['database'])
        llm_client = LLMClient(llm_config_path)
        
        print(f"总记录数: {len(data)}")
        
        # 统计执行成功的数量
        success_count = 0
        fail_count = 0
        
        # 分批处理
        for i in range(0, len(data), batch_size):
            batch = data[i:i+batch_size]
            print(f"处理批次 {i//batch_size + 1}/{(len(data)-1)//batch_size + 1}")
            
            with ThreadPoolExecutor(max_workers=max_workers) as executor:
                futures = {}
                
                for item in batch:
                    if 'query' in item and 'db_id' in item:
                        # 提交SQL执行任务
                        future = executor.submit(
                            db_executor.get_sql_fields,
                            item['query'],
                            item['db_id']
                        )
                        futures[future] = item
                
                # 处理执行结果
                for future in as_completed(futures):
                    item = futures[future]
                    try:
                        actual_fields = future.result()
                        if actual_fields is not None:
                            # 更新result_fields为实际字段
                            item['result_fields'] = actual_fields
                            
                            # 生成字段描述
                            description = generate_field_description_from_actual_fields(
                                actual_fields, 
                                item.get('question', ''),
                                llm_client
                            )
                            item['result_fields_description'] = description
                            success_count += 1
                            print(f"✓ 成功处理: {len(actual_fields)} 个字段")
                        else:
                            fail_count += 1
                            print(f"✗ 执行失败: {item.get('db_id', 'unknown')}")
                    except Exception as e:
                        fail_count += 1
                        print(f"✗ 处理异常: {e}")
            
            # 批次间休息
            if i + batch_size < len(data):
                time.sleep(1)
        
        print(f"\n处理完成: 成功 {success_count}, 失败 {fail_count}")
        
        # 保存结果
        if output_path is None:
            output_path = file_path.replace('.json', '_accurate_fields.json')
            
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        print(f"结果已保存至: {output_path}")
        return True
    
    except Exception as e:
        print(f"处理失败: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description='通过执行gold SQL生成准确的字段描述')
    parser.add_argument('file', help='要处理的JSON数据集文件')
    parser.add_argument('--db-config', '-d', required=True, help='数据库配置文件')
    parser.add_argument('--llm-config', '-l', required=True, help='LLM配置文件')
    parser.add_argument('--output', '-o', help='输出文件路径')
    parser.add_argument('--batch-size', '-b', type=int, default=5, help='批处理大小')
    parser.add_argument('--workers', '-w', type=int, default=3, help='线程池大小')
    
    args = parser.parse_args()
    
    process_dataset(
        args.file, 
        args.db_config, 
        args.llm_config, 
        args.output,
        args.workers, 
        args.batch_size
    )

if __name__ == "__main__":
    main() 