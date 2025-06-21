//
//  ContentView.swift
//  AITest
//
//  Created by Malte Ruff on 19.06.25.
//

import SwiftUI

struct ContentView: View {
	

	
	@State private var response: String?
	
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
							Button {
								print("Hello")
							} label: {
								Label("Hello", systemImage: "person.fill")
							}
							Button {
								print("Hello")
							} label: {
								Label("Hello", systemImage: "person.fill")
							}
							Button {
								print("Hello")
							} label: {
								Label("Hello", systemImage: "person.fill")
							}
							
						} label: {
							Label("Hello", systemImage: "person.fill")
						}

						
						Button {
							print("Hello")
						} label: {
							Label("Hello", systemImage: "internaldrive.fill")
						}
						Button {
							print("Hello")
						} label: {
							Label("Hello", systemImage: "sun.max")
						}
					}
					.padding(10)
				}
			})
			.navigationTitle("AI Examples")
//
//			Button {
//				Task {
//					do {
//						if let model = try? SystemLanguageModel.default.isAvailable {
//							print("Model available: \(model)")
//						} else {
//							print("Model missing") // Triggers error 5000
//						}
//						
//						let instruction = "You are a Japanese-speaking AI assistant. Your goal is to help Japanese students with their homework. You can ask questions about grammar, vocabulary, or any other topic related to Japanese language learning."
//						let session = LanguageModelSession(model: .default, instructions: instruction)
//						let options = GenerationOptions(temperature: 0, maximumResponseTokens: 2000)
//						
////						print(SystemLanguageModel.default.supportedLanguages)
//						
//						let prompt = "What is the meaning of the word 漢字 in Japanese?"
//						let response = try await session.respond(to: Prompt(prompt), generating: GrammarModel.self, options: options)
//						print(response)
//						self.response = response.content.name
//					} catch {
//						
//					}
//				}
//			} label: {
//				Label("Ask", systemImage: "questionmark.circle")
//			}
//			.padding()
//			.glassEffect(.regular)
//			
//			if let rep = response {
//				Text(rep)
//			}
//			
//			
//			GenerativeView()
//				.glassEffect(.regular)
        }
    }
}

#Preview {
    ContentView()
}




