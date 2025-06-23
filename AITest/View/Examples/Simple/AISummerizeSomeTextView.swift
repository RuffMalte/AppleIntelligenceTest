//
//  AISummerizeSomeTextView.swift
//  AITest
//
//  Created by Malte Ruff on 22.06.25.
//

import SwiftUI
import WebKit
import FoundationModels

struct AISummerizeSomeTextView: View {
	
	@State private var intructions: String = """
  Summarize the given text into concise points, without an introduction, like ‘Here are summarized points...'
  """
		
	
	@State private var answer: String?
	@State private var isAnswerLoading: Bool = false
	
	
	@State private var isShowingChart: Bool = false
	
	
	@State private var prompt: String = """
	  Das [netzfactor] Konzept
	  Ein Projekt ist ein Projekt! Sie möchten mit uns eine komplexe Software entwickeln? Ihr Netzwerk ist langsam und Sie möchten dem Fehler auf den Grund gehen? [netzfactor] weiß wie!
	  
	  
	  
	  Für uns steht das Erstgespräch im Vordergrund! Wir verstehen, wo bei Ihnen der Schuh drückt.
	  
	  In der Angebotsphase erhalten Sie klare Fakten! Sie werden sehen, dass wir Sie verstanden haben.
	  
	  In der Umsetzung arbeiten wir aus unserem Büro heraus oder bei und mit Ihnen vor Ort. Ein "Schulterblick" hilft Ihnen und uns, die Fortschritte zum erfolgreichen Projektziel zu überblicken. 
	  
	  Die Zielgerade! Bei der Auslieferung erfolgt die Schulung für den Tagesbetrieb. In der Echtlaufunterstützung erkennen wir, wo es ggf. noch klemmt und beraten Sie oder optimieren die erarbeitete Lösung. Das kann durch Schulungen, Wartungen oder fortlaufende Betreuung erfolgen. Wir lassen Sie nach dem Projekt nicht alleine. Wir freuen uns auf Sie.
	  
	  Einmal [netzfactor] - immer [netzfactor]? 
	  
	  Viele Kunden haben es wieder getan und schätzen die gute Arbeitsatmosphäre und das gute Miteinander im Projekt. 
	  
	  Wir freuen uns auf Sie! Nehmen Sie noch heute Kontakt auf und überzeugen Sie sich von unseren Leistungen.
	  
	  [netzfactor]
	"""
	
    var body: some View {
		Form {
			Section("Prompt") {
				WebView(url: URL(string: "https://www.netzfactor.de/konzept.html")!)
					.frame(height: 300)

			}
			.listRowInsets(.all, 0)
			
			Section("Intructions") {
				TextEditor(text: $intructions)
					.frame(height: 50)
			}
			
			if let answer = answer, !isAnswerLoading {
				let steps = answer
					.components(separatedBy: "\n")
					.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
				
				Section("AI Summary") {
					ForEach(Array(steps.enumerated()), id: \.element) { index, step in
						let attributedString = (try? AttributedString(markdown: step)) ?? AttributedString(step)
						HStack(alignment: .top) {
							Text("\(index + 1).")
								.bold()
								.frame(width: 20)
							Text(attributedString)
						}
					}
				}
			} else if isAnswerLoading {
				HStack {
					Spacer()
					AIProgressView(systemName: PerformanceMetricType.summary.icon)
					Spacer()
				}
				.listRowBackground(Color.clear)
			}
			
			
		}
		.navigationTitle(PerformanceMetricType.summary.navigationTitle)
		.overlay {
			GenerateAnswerButtonView(text: "Summerize", systemImage: "text.append") {
				Task {
					await PerformanceMeasurer.measureAndSave(
						metricType: .summary,
						task: {
							do {
								print(
									"Amount of chars: " + prompt.count.description
								)
								
								let str = prompt
								let pattern = "\\w+"
								let regex = try! NSRegularExpression(pattern: pattern)
								let matches = regex.matches(in: str, range: NSRange(str.startIndex..<str.endIndex, in: str))
								print(
									"Amount of words: " + matches.count.description
								)
								
								let session = LanguageModelSession(
									instructions: intructions
								)
								
								let options = GenerationOptions(
									sampling: .greedy,
									temperature: 2,
									maximumResponseTokens: 9999999
								)
								
								let response = try await session.respond(
									to: prompt,
									generating: String.self,
									options: options
								)
								
								return response.content
							} catch let error as LanguageModelSession.GenerationError {
								print(error.localizedDescription)
							} catch {
								print(error.localizedDescription)
							}
							return ""
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
								print(result)
							}
						}
					)
				}
			}
		}
		.sheet(isPresented: $isShowingChart) {
			ExecutionTimeChartView(
				userDefaultsKey: PerformanceMetricType.summary.userDefaultsKey,
				navigationTitle: PerformanceMetricType.summary.navigationTitle,
				unitName: PerformanceMetricType.summary.unitName
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
    AISummerizeSomeTextView()
}
