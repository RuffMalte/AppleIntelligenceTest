//
//  PerformanceComparisonView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//


import SwiftUI
import Charts

struct PerformanceComparisonView: View {
    @State private var metricData: [AggregatedMetric] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    comparisonChart
                    statisticsSection
                    metricDetailsSection
                }
                .padding()
            }
            .navigationTitle("AI Performance Comparison")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadMetricData()
            }
        }
    }
    
    private var comparisonChart: some View {
        VStack(alignment: .leading) {
            Text("Response Time Comparison")
                .font(.headline)
                .padding(.bottom, 5)
            
            Chart(metricData) { metric in
                BarMark(
                    x: .value("Metric", metric.type.navigationTitle),
                    y: .value("Time (s)", metric.average),
                    width: .ratio(0.6)
                )
                .foregroundStyle(by: .value("Type", metric.type.navigationTitle))
                .annotation(position: .top) {
                    Text(String(format: "%.3fs", metric.average))
                        .font(.caption)
                }
                
                RuleMark(
                    y: .value("Min", metric.min)
                )
                .foregroundStyle(metric.type.color.opacity(0.7))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                
                RuleMark(
                    y: .value("Max", metric.max)
                )
                .foregroundStyle(metric.type.color.opacity(0.7))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 200)
            .chartLegend(.hidden)
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
    
    private var statisticsSection: some View {
        VStack(alignment: .leading) {
            Text("Performance Summary")
                .font(.headline)
                .padding(.bottom, 5)
            
            Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                GridRow {
                    Text("Metric")
                        .bold()
                    Text("Avg")
                        .bold()
                    Text("Min")
                        .bold()
                    Text("Max")
                        .bold()
                    Text("Runs")
                        .bold()
                }
                .padding(.bottom, 5)
                
                ForEach(metricData) { metric in
                    GridRow {
                        HStack {
                            Image(systemName: metric.type.icon)
                                .foregroundStyle(metric.type.color)
//                            Text(metric.type.navigationTitle)
                        }
                        Text(String(format: "%.3fs", metric.average))
                        Text(String(format: "%.3fs", metric.min))
                        Text(String(format: "%.3fs", metric.max))
                        Text("\(metric.count)")
                    }
                    
                    Divider()
                }
            }
            .font(.callout)
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
    
    private var metricDetailsSection: some View {
        VStack(alignment: .leading) {
            Text("Detailed Metrics")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(metricData) { metric in
                DisclosureGroup {
                    VStack(alignment: .leading) {
                        Text("\(metric.type.navigationTitle) Details")
                            .font(.subheadline)
                            .padding(.bottom, 5)
                        
                        Chart(metric.times.enumerated().map { (index, time) in 
                            (run: index + 1, time: time)
                        }, id: \.run) { item in
                            LineMark(
                                x: .value("Run", item.run),
                                y: .value("Time (s)", item.time)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(metric.type.color.gradient)
                            
                            PointMark(
                                x: .value("Run", item.run),
                                y: .value("Time (s)", item.time)
                            )
                            .foregroundStyle(metric.type.color)
                            .symbolSize(50)
                        }
                        .frame(height: 150)
                        
                        HStack {
                            Spacer()
                            Button("Clear Data") {
                                clearData(for: metric.type)
                            }
                            .buttonStyle(.bordered)
                            .tint(.red)
                            Spacer()
                        }
                        .padding(.top)
                    }
                } label: {
                    HStack {
                        Image(systemName: metric.type.icon)
                            .foregroundStyle(metric.type.color)
                        Text(metric.type.navigationTitle)
                        Spacer()
                        Text("\(metric.count) runs")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
    
    private func loadMetricData() {
        metricData = PerformanceMetricType.allCases.map { type in
            let times = UserDefaults.standard.array(forKey: type.userDefaultsKey) as? [Double] ?? []
            return AggregatedMetric(type: type, times: times)
        }
    }
    
    private func clearData(for type: PerformanceMetricType) {
        UserDefaults.standard.removeObject(forKey: type.userDefaultsKey)
        loadMetricData()
    }
}

// Data model for aggregated metrics
struct AggregatedMetric: Identifiable {
    let type: PerformanceMetricType
    let times: [Double]
    
    var id: String { type.rawValue }
    
    var count: Int { times.count }
    var min: Double { times.min() ?? 0 }
    var max: Double { times.max() ?? 0 }
    var average: Double {
        guard !times.isEmpty else { return 0 }
        return times.reduce(0, +) / Double(times.count)
    }
}

// Add color to your metric type enum
extension PerformanceMetricType {
    var color: Color {
        switch self {
        case .aiResponse: return .blue
        case .recipe: return .green
        case .recipeWithTool: return .orange
        }
    }
}
