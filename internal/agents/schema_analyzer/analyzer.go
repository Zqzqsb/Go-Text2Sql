package schema_analyzer

import (
	"context"
	"fmt"
	"strings"

	"github.com/zqzqsb/gosql/internal/agents/base"
	"github.com/zqzqsb/gosql/internal/schema"
)

// SchemaAnalyzer 是一个分析数据库模式的Agent
type SchemaAnalyzer struct {
	// 缓存分析过的表结构信息
	analyzedSchemas map[string]*SchemaAnalysis
}

// SchemaAnalysis 包含对数据库模式的分析结果
type SchemaAnalysis struct {
	// 表的重要度评分 (0-1)
	TableImportance map[string]float64
	// 字段的重要度评分 (0-1)
	FieldImportance map[string]map[string]float64
	// 表之间的关系
	TableRelations []TableRelation
	// 字段的业务含义描述
	FieldDescriptions map[string]map[string]string
	// 常用查询模式
	CommonQueryPatterns []string
}

// TableRelation 描述两个表之间的关系
type TableRelation struct {
	SourceTable      string
	SourceField      string
	TargetTable      string
	TargetField      string
	RelationType     string // "one-to-one", "one-to-many", "many-to-many"
	RelationStrength float64 // 关系强度 (0-1)
}

// NewSchemaAnalyzer 创建新的模式分析器
func NewSchemaAnalyzer() *SchemaAnalyzer {
	return &SchemaAnalyzer{
		analyzedSchemas: make(map[string]*SchemaAnalysis),
	}
}

// Execute 实现Agent接口，执行模式分析
func (a *SchemaAnalyzer) Execute(ctx context.Context, input interface{}) base.AgentResult {
	// 将输入转换为数据库模式
	dbSchema, ok := input.(*schema.DatabaseSchema)
	if !ok {
		return base.AgentResult{
			Success: false,
			Error:   "输入必须是*schema.DatabaseSchema类型",
		}
	}

	// 检查是否已缓存该模式的分析结果
	schemaKey := a.generateSchemaKey(dbSchema)
	if analysis, exists := a.analyzedSchemas[schemaKey]; exists {
		return base.AgentResult{
			Success:  true,
			Data:     analysis,
			Metadata: map[string]interface{}{"source": "cache"},
		}
	}

	// 执行模式分析
	analysis, err := a.analyzeSchema(dbSchema)
	if err != nil {
		return base.AgentResult{
			Success: false,
			Error:   err.Error(),
		}
	}

	// 缓存分析结果
	a.analyzedSchemas[schemaKey] = analysis

	return base.AgentResult{
		Success:  true,
		Data:     analysis,
		Metadata: map[string]interface{}{"source": "fresh_analysis"},
	}
}

// GetName 返回Agent的名称
func (a *SchemaAnalyzer) GetName() string {
	return "schema_analyzer"
}

// GetDescription 返回Agent的描述
func (a *SchemaAnalyzer) GetDescription() string {
	return "分析数据库模式结构，提取表和字段的重要度、关系和业务含义"
}

// CanHandle 判断是否能处理输入
func (a *SchemaAnalyzer) CanHandle(input interface{}) bool {
	_, ok := input.(*schema.DatabaseSchema)
	return ok
}

// generateSchemaKey 为数据库模式生成唯一键，用于缓存
func (a *SchemaAnalyzer) generateSchemaKey(dbSchema *schema.DatabaseSchema) string {
	var tableKeys []string
	for _, table := range dbSchema.Tables {
		tableKeys = append(tableKeys, table.Name)
	}
	// 简单的键生成方式，实际使用中可能需要更复杂的指纹算法
	return strings.Join(tableKeys, "_")
}

// analyzeSchema 分析数据库模式
func (a *SchemaAnalyzer) analyzeSchema(dbSchema *schema.DatabaseSchema) (*SchemaAnalysis, error) {
	analysis := &SchemaAnalysis{
		TableImportance:    make(map[string]float64),
		FieldImportance:    make(map[string]map[string]float64),
		TableRelations:     []TableRelation{},
		FieldDescriptions:  make(map[string]map[string]string),
		CommonQueryPatterns: []string{},
	}

	// 分析表的重要度
	a.analyzeTableImportance(dbSchema, analysis)

	// 分析字段的重要度
	a.analyzeFieldImportance(dbSchema, analysis)

	// 分析表间关系
	a.analyzeTableRelations(dbSchema, analysis)

	// 分析字段业务描述
	a.analyzeFieldDescriptions(dbSchema, analysis)

	// 生成常用查询模式
	a.generateCommonQueryPatterns(dbSchema, analysis)

	return analysis, nil
}

// analyzeTableImportance 分析表的重要度
func (a *SchemaAnalyzer) analyzeTableImportance(dbSchema *schema.DatabaseSchema, analysis *SchemaAnalysis) {
	// 基于表的字段数量、关键字段和引用关系计算表的重要度
	for _, table := range dbSchema.Tables {
		// 基础重要度分数
		importance := 0.5

		// 包含ID或timestamp字段的表通常更重要
		for _, column := range table.Columns {
			if strings.Contains(strings.ToLower(column.Name), "id") ||
				strings.Contains(strings.ToLower(column.Name), "time") ||
				strings.Contains(strings.ToLower(column.Name), "date") {
				importance += 0.1
			}
		}

		// 字段越多通常表示表越重要
		fieldCount := len(table.Columns)
		importance += float64(fieldCount) * 0.01

		// 正规化确保不超过1.0
		if importance > 1.0 {
			importance = 1.0
		}

		analysis.TableImportance[table.Name] = importance
	}
}

// analyzeFieldImportance 分析字段的重要度
func (a *SchemaAnalyzer) analyzeFieldImportance(dbSchema *schema.DatabaseSchema, analysis *SchemaAnalysis) {
	for _, table := range dbSchema.Tables {
		fieldImp := make(map[string]float64)
		
		for _, column := range table.Columns {
			// 基础重要度
			importance := 0.3
			
			// 主键和外键更重要
			if column.IsPrimary {
				importance += 0.4
			}
			
			if column.IsForeign {
				importance += 0.3
			}
			
			// 名称中包含特定关键词的字段通常更重要
			lowerName := strings.ToLower(column.Name)
			if strings.Contains(lowerName, "id") {
				importance += 0.2
			} else if strings.Contains(lowerName, "name") || 
				  strings.Contains(lowerName, "title") {
				importance += 0.25
			} else if strings.Contains(lowerName, "date") || 
					strings.Contains(lowerName, "time") {
				importance += 0.15
			} else if strings.Contains(lowerName, "status") ||
					strings.Contains(lowerName, "state") {
				importance += 0.2
			}
			
			// 正规化
			if importance > 1.0 {
				importance = 1.0
			}
			
			fieldImp[column.Name] = importance
		}
		
		analysis.FieldImportance[table.Name] = fieldImp
	}
}

// analyzeTableRelations 分析表间关系
func (a *SchemaAnalyzer) analyzeTableRelations(dbSchema *schema.DatabaseSchema, analysis *SchemaAnalysis) {
	// 通过外键关系识别表间关系
	for _, fk := range dbSchema.ForeignKeys {
		// 确定关系类型
		relationType := "one-to-many" // 默认关系类型
		
		// 简单的关系强度计算
		strength := 0.7 // 默认强度
		
		// 通过命名约定推断更准确的关系类型
		if strings.Contains(strings.ToLower(fk.SourceColumn), "many") {
			relationType = "many-to-many"
			strength = 0.8
		}
		
		// 检查是否可能是一对一关系
		isSourcePrimary := false
		isTargetPrimary := false
		
		// 查找源字段是否是主键
		for _, table := range dbSchema.Tables {
			if table.Name == fk.SourceTable {
				for _, column := range table.Columns {
					if column.Name == fk.SourceColumn && column.IsPrimary {
						isSourcePrimary = true
						break
					}
				}
				break
			}
		}
		
		// 查找目标字段是否是主键
		for _, table := range dbSchema.Tables {
			if table.Name == fk.TargetTable {
				for _, column := range table.Columns {
					if column.Name == fk.TargetColumn && column.IsPrimary {
						isTargetPrimary = true
						break
					}
				}
				break
			}
		}
		
		// 如果源字段和目标字段都是主键，可能是一对一关系
		if isSourcePrimary && isTargetPrimary {
			relationType = "one-to-one"
			strength = 0.9
		}
		
		relation := TableRelation{
			SourceTable:      fk.SourceTable,
			SourceField:      fk.SourceColumn,
			TargetTable:      fk.TargetTable,
			TargetField:      fk.TargetColumn,
			RelationType:     relationType,
			RelationStrength: strength,
		}
		
		analysis.TableRelations = append(analysis.TableRelations, relation)
	}
}

// analyzeFieldDescriptions 分析字段业务描述
func (a *SchemaAnalyzer) analyzeFieldDescriptions(dbSchema *schema.DatabaseSchema, analysis *SchemaAnalysis) {
	for _, table := range dbSchema.Tables {
		fieldDesc := make(map[string]string)
		
		for _, column := range table.Columns {
			// 基于字段名称生成基本描述
			description := a.generateFieldDescription(table.Name, column.Name, column)
			fieldDesc[column.Name] = description
		}
		
		analysis.FieldDescriptions[table.Name] = fieldDesc
	}
}

// generateFieldDescription 根据字段名称和属性生成描述
func (a *SchemaAnalyzer) generateFieldDescription(tableName, fieldName string, column schema.Column) string {
	lowerName := strings.ToLower(fieldName)
	
	// 基于常见命名模式生成描述
	if column.IsPrimary {
		return fmt.Sprintf("%s表的唯一标识符", tableName)
	} else if column.IsForeign {
		// 寻找对应的外键关系
		return fmt.Sprintf("关联到其他表的外键字段（%s）", tableName)
	} else if strings.Contains(lowerName, "name") {
		return fmt.Sprintf("%s的名称", tableName)
	} else if strings.Contains(lowerName, "date") || strings.Contains(lowerName, "time") {
		if strings.Contains(lowerName, "create") {
			return fmt.Sprintf("%s的创建时间", tableName)
		} else if strings.Contains(lowerName, "update") {
			return fmt.Sprintf("%s的更新时间", tableName)
		} else {
			return fmt.Sprintf("与%s相关的时间信息", tableName)
		}
	} else if strings.Contains(lowerName, "status") || strings.Contains(lowerName, "state") {
		return fmt.Sprintf("%s的当前状态", tableName)
	} else if strings.Contains(lowerName, "description") || strings.Contains(lowerName, "desc") {
		return fmt.Sprintf("%s的详细描述", tableName)
	} else if strings.Contains(lowerName, "count") || strings.Contains(lowerName, "number") {
		return fmt.Sprintf("%s的数量", tableName)
	} else if strings.Contains(lowerName, "price") || strings.Contains(lowerName, "cost") {
		return fmt.Sprintf("%s的价格信息", tableName)
	}
	
	// 默认描述
	return fmt.Sprintf("%s的%s属性", tableName, fieldName)
}

// generateCommonQueryPatterns 生成常用查询模式
func (a *SchemaAnalyzer) generateCommonQueryPatterns(dbSchema *schema.DatabaseSchema, analysis *SchemaAnalysis) {
	// 基于表结构和关系生成常见查询模式
	for _, table := range dbSchema.Tables {
		// 基本查询模式：获取所有记录
		pattern := fmt.Sprintf("SELECT * FROM %s", table.Name)
		analysis.CommonQueryPatterns = append(analysis.CommonQueryPatterns, pattern)
		
		// 基于主键的查询模式
		for _, column := range table.Columns {
			if column.IsPrimary {
				pattern = fmt.Sprintf("SELECT * FROM %s WHERE %s = ?", table.Name, column.Name)
				analysis.CommonQueryPatterns = append(analysis.CommonQueryPatterns, pattern)
				break
			}
		}
		
		// 基于关系的联表查询模式
		for _, relation := range analysis.TableRelations {
			if relation.SourceTable == table.Name {
				pattern = fmt.Sprintf(
					"SELECT %s.*, %s.* FROM %s JOIN %s ON %s.%s = %s.%s",
					table.Name, relation.TargetTable,
					table.Name, relation.TargetTable,
					table.Name, relation.SourceField,
					relation.TargetTable, relation.TargetField,
				)
				analysis.CommonQueryPatterns = append(analysis.CommonQueryPatterns, pattern)
			}
		}
	}
}
