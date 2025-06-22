//
//  AIExamplesListView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct AIExamplesListView: View {
    var body: some View {
		List {
			Section("Simple") {
				
				AIExamplesItemView(
					title: PerformanceMetricType.aiResponse.navigationTitle,
					icon: PerformanceMetricType.aiResponse.icon,
					color: .blue,
					navigationDestination: AnyView(
						AISimpleExampleView()
					)
				)
				
				AIExamplesItemView(
					title: PerformanceMetricType.summary.navigationTitle,
					icon: PerformanceMetricType.summary.icon,
					color: PerformanceMetricType.summary.color,
					navigationDestination: AnyView(
						AISummerizeSomeTextView()
					)
				)
				
				
				
			}
			
			Section("Structured data") {
				AIExamplesItemView(
					title: PerformanceMetricType.recipe.navigationTitle,
					icon: PerformanceMetricType.recipe.icon,
					color: .red,
					navigationDestination: AnyView(
						AIStructuredDataRecipeExampleView()
					)
				)
			}
			
			Section("Tools") {
				AIExamplesItemView(
					title: PerformanceMetricType.recipeWithTool.navigationTitle,
					icon: PerformanceMetricType.recipeWithTool.icon,
					color: .orange,
					navigationDestination: AnyView(
						AIToolRecipeExampleView()
					)
				)
				
				
			}
			
			
			Section("Image") {
				AIExamplesItemView(
					title: "Image Playground",
					icon: "apple.image.playground.fill",
					color: .black,
					navigationDestination: AnyView(
						AIImagePlaygroundExampleView()
					)
				)
			}
		}
		
		
    }
}

#Preview {
    AIExamplesListView()
}
