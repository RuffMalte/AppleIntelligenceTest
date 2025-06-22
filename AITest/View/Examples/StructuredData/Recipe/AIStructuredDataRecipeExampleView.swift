//
//  AIStructuredDataExampleView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI
import FoundationModels

struct AIStructuredDataRecipeExampleView: View {
	@State private var intructions: String = "You are a professional recipe generator. When a user provides a list of available ingredients, dietary restrictions, preferred cuisine, or specific meal type (e.g., breakfast, dinner, dessert), generate a unique, easy-to-follow recipe that uses those ingredients as much as possible. Clearly list all required ingredients with quantities, followed by step-by-step cooking instructions. If the user specifies dietary needs (e.g., vegan, gluten-free), ensure the recipe complies. If the user is vague, ask clarifying questions to improve your output. Suggest creative flavor pairings and offer substitution ideas if an ingredient is missing. Keep instructions concise and beginner-friendly, and include estimated preparation and cooking times."
	
	@State private var prompt: String = "Create a Japanese Ramen recipe"
	
	@State var answer: RecipeModel?
	
	var encoder: JSONEncoder {
		let enc = JSONEncoder()
		enc.outputFormatting = [.prettyPrinted]
		return enc
	}
	
	
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
				RecipeItemHeaderView(recipe: answer)

				RecipeItemIngredientsView(recipe: answer)
				
				RecipeItemStepsView(recipe: answer)
				
				if let jsonData = try? encoder.encode(answer),
				   let jsonString = String(data: jsonData, encoding: .utf8) {
					Section {
						NavigationLink {
							Form {
								Section {
									Text(jsonString)
								}
							}
						} label: {
							Label("JSON Design", systemImage: "swift")
						}
					}
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
		.navigationTitle(PerformanceMetricType.recipe.navigationTitle)
		.overlay {
			GenerateAnswerButtonView {
				Task {
					await PerformanceMeasurer.measureAndSave(
						metricType: .recipe,
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
				userDefaultsKey: PerformanceMetricType.recipe.userDefaultsKey,
				navigationTitle: PerformanceMetricType.recipe.navigationTitle,
				unitName: PerformanceMetricType.recipe.unitName
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
	AIStructuredDataRecipeExampleView(answer: .japaneseCurry)
}
