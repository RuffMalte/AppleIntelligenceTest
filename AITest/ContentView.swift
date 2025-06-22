//
//  ContentView.swift
//  AITest
//
//  Created by Malte Ruff on 19.06.25.
//

import SwiftUI

struct ContentView: View {
	
	@State private var isShowingSheet: Bool = false
	@State private var selectedExample: PerformanceMetricType = PerformanceMetricType.aiResponse
	
	@State private var isShowingComparisonSheet: Bool = false
    var body: some View {
        NavigationStack {
			Form {
				AIExamplesListView()
			}
			.overlay {
				VStack {
					Spacer()
					GenerativeView()
						.font(
							.system(
								.headline,
								design: .monospaced,
								weight: .bold
							)
						)
						.padding()
						.glassEffect(.regular.interactive(), in: .capsule)
				}
			}
			.toolbar(content: {
				ToolbarItem(placement: .primaryAction) {
					HStack(spacing: 20) {
						Menu {
							ForEach(PerformanceMetricType.allCases) { metric in
								Button {
									selectedExample = metric
									isShowingSheet.toggle()
								} label: {
									Label(metric.navigationTitle, systemImage: metric.icon)
								}
							}
						} label: {
							Label("Calculation Times", systemImage: "chart.bar.fill")
						}
						
						
						Button {
							isShowingComparisonSheet.toggle()
						} label: {
							Label("Comparison", systemImage: "ruler.fill")
						}
					}
					.padding(10)
				}
			})
			.navigationTitle("AI Examples")
			.sheet(isPresented: $isShowingSheet) {
				ExecutionTimeChartView(
					userDefaultsKey: selectedExample.userDefaultsKey,
					navigationTitle: selectedExample.navigationTitle,
					unitName: selectedExample.unitName
				)
				.presentationDragIndicator(.visible)
				.presentationDetents([.large, .medium])
			}
			.sheet(isPresented: $isShowingComparisonSheet) {
				PerformanceComparisonView()
					.presentationDragIndicator(.visible)
			}

        }
    }
}

#Preview {
    ContentView()
}




