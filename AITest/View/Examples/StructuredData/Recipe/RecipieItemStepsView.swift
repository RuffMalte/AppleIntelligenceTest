//
//  RecipieItemStepsView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct RecipieItemStepsView: View {
	
	let recipe: RecipeModel
	
    var body: some View {
        
		Section {
			Text("Steps")
				.font(.system(.title, design: .rounded, weight: .bold))
			
			VStack(alignment: .leading, spacing: 10) {
				ForEach(Array(recipe.steps.enumerated()), id: \.element) { index, step in
					let attributedString = (try? AttributedString(markdown: step)) ?? AttributedString(step)
					
					HStack(alignment: .top) {
						Text("\(index + 1).")
							.bold()
							.frame(width: 20)
						Text(attributedString)
					}
				}
				
			}
			
		}
		
    }
}

#Preview {
	Form {
		RecipieItemStepsView(recipe: .japaneseCurry)
	}
}
