package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"sort"
)

// Reporter 处理分析结果的报告和统计
type Reporter struct {
	OutputDir string
}

// NewReporter 创建报告生成器
func NewReporter(outputDir string) *Reporter {
	return &Reporter{
		OutputDir: outputDir,
	}
}

// SaveAnalysisResult 保存单个分析结果到文件
func (r *Reporter) SaveAnalysisResult(result *AnalysisResult, originalFilePath string) error {
	// 确保不修改原始文件，而是创建新的分析结果文件
	analysisPath := originalFilePath + ".analysis"
	
	// 序列化结果
	resultJSON, err := json.MarshalIndent(result, "", "  ")
	if err != nil {
		return fmt.Errorf("序列化分析结果失败: %v", err)
	}
	
	// 写入文件
	if err := os.WriteFile(analysisPath, resultJSON, 0644); err != nil {
		return fmt.Errorf("写入分析结果文件失败: %v", err)
	}
	
	return nil
}

// GenerateSummaryReport 生成汇总报告
func (r *Reporter) GenerateSummaryReport(stats *ErrorStatistics, totalFiles int) error {
	// 创建报告目录
	reportDir := filepath.Join(r.OutputDir, "analysis_reports")
	if err := os.MkdirAll(reportDir, 0755); err != nil {
		return fmt.Errorf("创建报告目录失败: %v", err)
	}
	
	// 创建汇总报告文件
	reportPath := filepath.Join(reportDir, "summary_report.json")
	
	// 计算正确率
	correctRate := float64(stats.CorrectCount+stats.EquivalentCount) / float64(totalFiles) * 100
	
	// 按错误类型排序错误计数
	sort.Slice(stats.ErrorCounts, func(i, j int) bool {
		return stats.ErrorCounts[i].Count > stats.ErrorCounts[j].Count
	})
	
	// 创建报告数据
	report := map[string]interface{}{
		"total_files":       totalFiles,
		"correct_count":     stats.CorrectCount,
		"equivalent_count":  stats.EquivalentCount,
		"ambiguous_count":   stats.AmbiguousCount,
		"error_count":       totalFiles - stats.CorrectCount - stats.EquivalentCount - stats.AmbiguousCount,
		"correct_rate":      correctRate,
		"error_statistics": map[string]interface{}{
			"syntax_error_count":     stats.SyntaxErrorCount,
			"projection_error_count": stats.ProjectionErrorCount,
			"data_error_count":       stats.DataErrorCount,
			"order_error_count":      stats.OrderErrorCount,
			"join_error_count":       stats.JoinErrorCount,
			"condition_error_count":  stats.ConditionErrorCount,
			"other_error_count":      stats.OtherErrorCount,
		},
		"error_counts": stats.ErrorCounts,
	}
	
	// 序列化报告
	reportJSON, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		return fmt.Errorf("序列化报告失败: %v", err)
	}
	
	// 写入报告文件
	if err := os.WriteFile(reportPath, reportJSON, 0644); err != nil {
		return fmt.Errorf("写入报告文件失败: %v", err)
	}
	
	return nil
}

// PrintSummary 打印分析结果摘要
func (r *Reporter) PrintSummary(stats *ErrorStatistics, totalFiles int) {
	// 计算正确率
	correctRate := float64(stats.CorrectCount+stats.EquivalentCount) / float64(totalFiles) * 100
	
	// 彩色标题
	fmt.Printf("\n%s%s======================================%s\n", Bold, ColorCyan, ColorReset)
	fmt.Printf("%s%s             SQL分析结果摘要             %s\n", Bold, ColorCyan, ColorReset)
	fmt.Printf("%s%s======================================%s\n\n", Bold, ColorCyan, ColorReset)
	
	// 基本统计信息
	fmt.Printf("%s总查询数:%s %d\n", Bold, ColorReset, totalFiles)
	
	// 正确率信息，根据百分比设置颜色
	rateColor := ColorRed
	if correctRate >= 80 {
		rateColor = ColorGreen
	} else if correctRate >= 60 {
		rateColor = ColorYellow
	} else if correctRate >= 40 {
		rateColor = ColorBlue
	}
	
	fmt.Printf("%s正确数量:%s %s%d%s (精确匹配: %s%d%s, 语义等价: %s%d%s)\n", 
		Bold, ColorReset, ColorGreen, stats.CorrectCount+stats.EquivalentCount, ColorReset, 
		ColorGreen, stats.CorrectCount, ColorReset, 
		ColorGreen, stats.EquivalentCount, ColorReset)
	
	fmt.Printf("%s模糊查询:%s %s%d%s\n", Bold, ColorReset, ColorYellow, stats.AmbiguousCount, ColorReset)
	
	errorCount := totalFiles - stats.CorrectCount - stats.EquivalentCount - stats.AmbiguousCount
	fmt.Printf("%s错误数量:%s %s%d%s\n", Bold, ColorReset, ColorRed, errorCount, ColorReset)
	
	fmt.Printf("%s总体正确率:%s %s%.2f%%%s\n\n", Bold, ColorReset, rateColor, correctRate, ColorReset)
	
	// 错误类型统计 - 按频率排序
	fmt.Printf("%s%s错误类型统计(按频率排序)%s\n", Bold, ColorRed, ColorReset)
	fmt.Printf("%s--------------------------------------%s\n", Bold, ColorReset)
	
	// 按错误类型排序错误计数
	sort.Slice(stats.ErrorCounts, func(i, j int) bool {
		return stats.ErrorCounts[i].Count > stats.ErrorCounts[j].Count
	})
	
	// 打印错误类型统计，使用表格式式
	fmt.Printf("%s%-20s %10s %15s%s\n", Bold, "错误类型", "数量", "百分比", ColorReset)
	fmt.Printf("%s----------------------------------------%s\n", Bold, ColorReset)
	
	// 设置每种错误类型的颜色
	getErrorColor := func(errorType string) string {
		switch errorType {
		case "参考答案有语法错误":
			return ColorYellow
		case "投影错误":
			return ColorPurple
		case "行数错误":
			return ColorBlue
		case "数据不一致错误":
			return ColorCyan
		case "模糊查询":
			return ColorYellow
		default:
			return ColorRed
		}
	}
	
	for _, ec := range stats.ErrorCounts {
		percentage := float64(ec.Count) / float64(totalFiles) * 100
		errorColor := getErrorColor(ec.Type)
		fmt.Printf("%-20s %s%10d%s %15.2f%%\n", 
			ec.Type, errorColor, ec.Count, ColorReset, percentage)
	}
	
	// 详细错误统计
	fmt.Printf("\n%s%s详细错误分类统计%s\n", Bold, ColorBlue, ColorReset)
	fmt.Printf("%s--------------------------------------%s\n", Bold, ColorReset)
	
	// 打印详细错误统计，使用表格式式
	fmt.Printf("%s%-20s %10s %15s%s\n", Bold, "错误类型", "数量", "百分比", ColorReset)
	fmt.Printf("%s----------------------------------------%s\n", Bold, ColorReset)
	
	// 添加单个错误类型的打印函数
	printErrorType := func(name string, count int, color string) {
		percent := float64(count) / float64(totalFiles) * 100
		fmt.Printf("%-20s %s%10d%s %15.2f%%\n", name, color, count, ColorReset, percent)
	}
	
	printErrorType("语法错误", stats.SyntaxErrorCount, ColorYellow)
	printErrorType("投影错误", stats.ProjectionErrorCount, ColorPurple)
	printErrorType("数据不一致", stats.DataErrorCount, ColorCyan)
	printErrorType("行数错误", stats.DataErrorCount, ColorBlue)
	printErrorType("排序错误", stats.OrderErrorCount, ColorRed)
	printErrorType("表连接错误", stats.JoinErrorCount, ColorRed)
	printErrorType("查询条件错误", stats.ConditionErrorCount, ColorRed)
	printErrorType("其他错误", stats.OtherErrorCount, ColorRed)
	
	// 报告保存路径
	reportPath := filepath.Join(r.OutputDir, "analysis_reports", "summary_report.json")
	fmt.Printf("\n%s报告已保存到:%s %s%s%s\n", 
		Bold, ColorReset, ColorGreen, reportPath, ColorReset)
}
