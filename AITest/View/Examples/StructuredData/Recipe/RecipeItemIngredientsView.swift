//
//  RecipeItemIngredientsView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct RecipeItemIngredientsView: View {
	
	let recipe: RecipeModel
	
    var body: some View {
		Section {
			VStack(alignment: .leading, spacing: 10) {
				Text("Ingredients")
					.font(.system(.title, design: .rounded, weight: .bold))
				
				Text("^[For \(recipe.ingredientsForPerson) People](inflect: true)")
			}
			
			ForEach(recipe.ingredients) { ingredient in
				LazyVGrid(columns: [
					GridItem(.flexible()),
					GridItem(.flexible())
					
				], alignment: .listRowSeparatorLeading) {
					HStack {
						Spacer()
						Text(ingredient.name)
					}
					.font(
						.system(.callout, design: .rounded, weight: .bold)
					)
					.padding(.trailing, 4)
					
					HStack {
						VStack(alignment: .leading) {
							Text(ingredient.quantity)
							
							if let extraInformation = ingredient.extraInformation, !extraInformation.isEmpty {
								Text(extraInformation)
									.font(
										.system(
											.footnote,
											design: .rounded,
											weight: .regular
										)
									)
									.foregroundStyle(.secondary)
							}
							
						}
						Spacer()
					}
					.font(
						.system(
							.subheadline,
							design: .monospaced,
							weight: .regular
						)
					)
					
					
					
				}
				
				
			}
		}
    }
}

#Preview {
	Form {
		RecipeItemIngredientsView(recipe: .japaneseCurry)
	}
}
