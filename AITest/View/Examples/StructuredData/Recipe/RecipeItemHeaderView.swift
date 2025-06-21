//
//  RecipeItemHeaderView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct RecipeItemHeaderView: View {
	
	let recipe: RecipeModel
	
    var body: some View {
		Section {
			VStack(spacing: 20) {
				VStack(alignment: .leading, spacing: 20) {
					VStack(spacing: 10) {
						Text(recipe.name)
							.font(.system(.title, design: .rounded, weight: .bold))
						
						Text(recipe.description)
							.font(
								.system(.subheadline, design: .rounded, weight: .light)
							)
							.foregroundStyle(.secondary)
					}
					LazyVGrid(columns: [
						GridItem(.flexible()),
						GridItem(.flexible()),
						GridItem(.flexible())
					]) {
						Text(recipe.mealType.rawValue.capitalized)
						Text(recipe.countryOfOrigin.countryFlag)
						Text(recipe.difficulty.description)
							.padding(.horizontal)
							.padding(.vertical, 3)
							.foregroundStyle(.white)
							.background {
								RoundedRectangle(cornerRadius: 4)
									.foregroundStyle(recipe.difficulty.color)
							}
					}
					.font(.system(.headline, design: .rounded, weight: .bold))
					.lineLimit(1)
				}
				.multilineTextAlignment(.leading)
				
				Divider()
				
				LazyVGrid(columns: [
					GridItem(.flexible()),
					GridItem(.flexible()),
					GridItem(.flexible())
				]) {
					Label(
						Duration.seconds(recipe.duration).formatted(.units()),
						systemImage: "clock.fill"
					)
					Label(
						Duration.seconds(recipe.cookingTime).formatted(.units()),
						systemImage: "oven.fill"
					)
					Label(
						Duration.seconds(recipe.prepTime).formatted(.units()),
						systemImage: "carrot.fill"
					)
					
				}
				.font(.system(.subheadline, design: .monospaced, weight: .regular))
				
				
				
				
				
				
			}
		} header: {
			Text("AI Answer")
		}
    }
}

#Preview {
	Form {
		RecipeItemHeaderView(recipe: .japaneseCurry)
		
	}
}
