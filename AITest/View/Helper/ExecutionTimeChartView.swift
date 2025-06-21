import SwiftUI
import Charts

struct ExecutionTimeChartView: View {
	let userDefaultsKey: String
	let navigationTitle: String
	let unitName: String
	
	@State private var executionTimes: [Double] = []
	
	// Computed properties for statistics
	private var minTime: Double? { executionTimes.min() }
	private var maxTime: Double? { executionTimes.max() }
	private var avgTime: Double? {
		guard !executionTimes.isEmpty else { return nil }
		return executionTimes.reduce(0, +) / Double(executionTimes.count)
	}
	
	// Initialize with custom parameters
	init(
		userDefaultsKey: String,
		navigationTitle: String = "Performance Metrics",
		unitName: String = "s"
	) {
		self.userDefaultsKey = userDefaultsKey
		self.navigationTitle = navigationTitle
		self.unitName = unitName
	}
	
	var body: some View {
		NavigationStack {
			VStack {
				if executionTimes.isEmpty {
					ContentUnavailableView(
						"No Performance Data",
						systemImage: "chart.bar",
						description: Text("Run some tests to collect execution time metrics")
					)
					.padding()
				} else {
					Chart {
						ForEach(Array(executionTimes.enumerated()), id: \.offset) { index, time in
							BarMark(
								x: .value("Run", index + 1),
								y: .value("Time (\(unitName))", time)
							)
							.foregroundStyle(time == minTime ? .green : time == maxTime ? .red : .blue)
						}
						
						if let avg = avgTime {
							RuleMark(y: .value("Average", avg))
								.foregroundStyle(.orange)
								.lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
								.annotation(position: .top, alignment: .leading) {
									Text("Avg: \(String(format: "%.4f", avg))\(unitName)")
										.font(.system(.caption2, design: .monospaced, weight: .light))
										.padding(4)
										.background(.orange.opacity(0.9))
										.cornerRadius(4)
								}
						}
					}
					.chartYAxis {
						AxisMarks(position: .leading)
					}
					.frame(height: 200)
					.padding()
					
					List {
						// Statistics section
						Section(
							"Performance Statistics (\(executionTimes.count.description))"
						) {
							StatisticRowView(
								title: "Minimum",
								value: minTime,
								unit: unitName,
								icon: "arrow.down",
								color: .green
							)
							StatisticRowView(
								title: "Maximum",
								value: maxTime,
								unit: unitName,
								icon: "arrow.up",
								color: .red
							)
							StatisticRowView(
								title: "Average",
								value: avgTime,
								unit: unitName,
								icon: "chart.bar.fill",
								color: .orange
							)
						}
						
						// Detailed measurements
						Section("All Measurements") {
							ForEach(Array(executionTimes.enumerated()), id: \.offset) { index, time in
								HStack {
									Text("Run \(index + 1)")
									Spacer()
									Text(String(format: "%.4f \(unitName)", time))
										.font(.system(.body, design: .monospaced))
								}
								.foregroundStyle(time == minTime ? .green : time == maxTime ? .red : .primary)
							}
						}
					}
					.listStyle(.insetGrouped)
				}
			}
			.navigationTitle(navigationTitle)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						UserDefaults.standard.removeObject(forKey: userDefaultsKey)
						executionTimes = []
					} label: {
						Label("Clear", systemImage: "trash")
					}
					.glassEffect(.regular.interactive(), in: .capsule)
					.disabled(executionTimes.isEmpty)
				}
			}
			.onAppear {
				loadExecutionTimes()
			}
		}
	}
	
	private func loadExecutionTimes() {
		executionTimes = UserDefaults.standard.array(forKey: userDefaultsKey) as? [Double] ?? []
	}
}

// Helper view for statistics rows
struct StatisticRowView: View {
	let title: String
	let value: Double?
	let unit: String
	let icon: String
	let color: Color
	
	var body: some View {
		HStack {
			Label(title, systemImage: icon)
				.foregroundStyle(color)
				.bold()
			Spacer()
			if let value = value {
				Text(String(format: "%.4f \(unit)", value))
					.font(.system(.body, design: .monospaced))
			} else {
				Text("N/A")
			}
		}
	}
}
