//
//  AIStructuredDataExampleView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI
import FoundationModels

struct AIStructuredDataRecipieExampleView: View {
	@State private var intructions: String = "You are a professional recipe generator. When a user provides a list of available ingredients, dietary restrictions, preferred cuisine, or specific meal type (e.g., breakfast, dinner, dessert), generate a unique, easy-to-follow recipe that uses those ingredients as much as possible. Clearly list all required ingredients with quantities, followed by step-by-step cooking instructions. If the user specifies dietary needs (e.g., vegan, gluten-free), ensure the recipe complies. If the user is vague, ask clarifying questions to improve your output. Suggest creative flavor pairings and offer substitution ideas if an ingredient is missing. Keep instructions concise and beginner-friendly, and include estimated preparation and cooking times."
	
	@State private var prompt: String = "Create a Japanese Curry"
	
	@State private var answer: RecipeModel?
	@State private var isAnswerLoading: Bool = false
	
	
	@State private var isShowingChart: Bool = false
	
    var body: some View {
		Form {
			Section {
					//TODO: add json of model
			}
			
			
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
				RecipieItemHeaderView(recipe: answer)

				RecipieItemIngredientsView(recipe: answer)
				
				RecipieItemStepsView(recipe: answer)
				
				
			} else if isAnswerLoading {
				HStack {
					Spacer()
					AIProgressView()
					Spacer()
				}
				.listRowBackground(Color.clear)
			}
			
			
			
		}
		.navigationTitle("Recipe Generator")
		.overlay {
			GenerateAnswerButtonView {
				Task {
					await PerformanceMeasurer.measureAndSave(
						metricType: .recipie,
						task: {
							
							
							let session = LanguageModelSession(
								instructions: intructions
							)
							
							
							let response = try await session.respond(
								to: prompt,
								generating: RecipeModel.self
							)
							
							
							return response.content
							
							
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
								
								let encoder = JSONEncoder()
								encoder.outputFormatting = .prettyPrinted
								
								if let jsonData = try? encoder.encode(answer),
								   let jsonString = String(data: jsonData, encoding: .utf8) {
									print(jsonString)
								}
								
							}
						}
					)
				}
				
			}
		}
		.sheet(isPresented: $isShowingChart) {
			ExecutionTimeChartView(
				userDefaultsKey: PerformanceMetricType.recipie.userDefaultsKey,
				navigationTitle: PerformanceMetricType.recipie.navigationTitle,
				unitName: PerformanceMetricType.recipie.unitName
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
    AIStructuredDataRecipieExampleView()
}
