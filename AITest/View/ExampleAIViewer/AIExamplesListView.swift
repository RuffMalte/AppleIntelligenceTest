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
					icon: "1.square",
					color: .blue,
					navigationDestination: AnyView(
						AISimpleExampleView()
					)
				)
				
			}
			
			Section("Structured data") {
				AIExamplesItemView(
					title: PerformanceMetricType.recipe.navigationTitle,
					icon: "carrot.fill",
					color: .red,
					navigationDestination: AnyView(
						AIStructuredDataRecipeExampleView()
					)
				)
			}
			
			Section("Tools") {
				AIExamplesItemView(
					title: PerformanceMetricType.recipeWithTool.navigationTitle,
					icon: "apple.image.playground.fill",
					color: .orange,
					navigationDestination: AnyView(
						AIToolRecipeExampleView()
					)
				)
				
				
			}
		}
		
		
    }
}

#Preview {
    AIExamplesListView()
}
