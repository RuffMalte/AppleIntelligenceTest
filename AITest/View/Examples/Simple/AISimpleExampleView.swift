//
//  AISimpleExampleView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI
import FoundationModels
import Charts


struct AISimpleExampleView: View {
	
	@State private var intructions: String = """
		Suggest related topics. Keep them concise (three to seven words) and make sure they build naturally from the person's topic.
		"""
	
	@State private var prompt: String = "Baking Bread"
		
	
	@State private var answer: String?
	@State private var isAnswerLoading: Bool = false
	
	
	@State private var isShowingChart: Bool = false
    var body: some View {
		Form {
			Section("Prompt input (User)") {
				TextEditor(text: $prompt)
					.frame(height: 100)
					.lineLimit(3)
				
			}
			
			Section("AI instructions (Model)") {
				TextEditor(text: $intructions)
					.frame(height: 100)
			}
			
			
			if let answer = answer, !isAnswerLoading {
				Section("AI Answer") {
					Text(answer)
				}
			} else if isAnswerLoading {
				HStack {
					Spacer()
					AIProgressView()
					Spacer()
				}
				.listRowBackground(Color.clear)
			}
			
			
		}
		.overlay {
			GenerateAnswerButtonView {
				Task {
					await PerformanceMeasurer.measureAndSave(
						metricType: .aiResponse,
						task: {
							
							
							let session = LanguageModelSession(
								instructions: intructions
							)
							
							return try? await session.respond(to: prompt).content
							
							
						},
						onStart: {
							withAnimation {
								answer = nil
								isAnswerLoading = true
							}
						},
						onComplete: { result in
							withAnimation(.interactiveSpring) {
								isAnswerLoading = false
								answer = result
							}
						}
					)
				}
			}
		}
		.navigationTitle("Simple Input")
		.sheet(isPresented: $isShowingChart) {
				ExecutionTimeChartView(
					userDefaultsKey: PerformanceMetricType.aiResponse.userDefaultsKey,
					navigationTitle: PerformanceMetricType.aiResponse.navigationTitle,
					unitName: PerformanceMetricType.aiResponse.unitName
				)
				.presentationDragIndicator(.visible)
				.presentationDetents([.medium ,.large])
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					isShowingChart.toggle()
				} label: {
					Label("Charts", systemImage: "chart.bar.fill")
						.labelStyle(.iconOnly)
				}
			}
		}
	}
}

#Preview {
    AISimpleExampleView()
}
