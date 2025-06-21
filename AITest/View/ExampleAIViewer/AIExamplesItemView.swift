//
//  AIExamplesItemView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct AIExamplesItemView: View {
	
	var title: String
	var icon: String
	var color: Color
	var navigationDestination: AnyView
	
	
	@Environment(\.colorScheme) var colorScheme
	
    var body: some View {
		NavigationLink {
			navigationDestination
		} label: {
			HStack(spacing: 10) {
				Image(systemName: icon)
					.frame(width: 24, height: 24)
					.foregroundStyle(.white.gradient)
					.font(.title3)

					.background(
						RoundedRectangle(cornerRadius: 8)
							.foregroundStyle(color.gradient)
							.frame(width: 32, height: 32)

					)
				
				Text(title)
					.font(
						.system(.headline, design: .rounded, weight: .regular)
					)
			}
		}

    }
}

#Preview {
	NavigationStack {
		Form {
			ForEach(1..<20) { _ in
				AIExamplesItemView(title: "Test Name", icon: "person.fill", color: .red, navigationDestination: AnyView(Text("Hello World")))
			}
		}
	}
}
