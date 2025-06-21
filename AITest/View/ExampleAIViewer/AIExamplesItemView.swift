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
			HStack {
				Image(systemName: icon)
					.foregroundStyle(.white.gradient)
					.font(.title3)
					.padding(5)
					.background(
						RoundedRectangle(cornerRadius: 8)
							.foregroundStyle(color.gradient)
					)
					.frame(width: 24, height: 24)
				
				Text(title)
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
