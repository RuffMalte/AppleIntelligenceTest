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
					title: "Simple",
					icon: "1.square",
					color: .blue,
					navigationDestination: AnyView(
						AISimpleExampleView()
					)
				)
				
			}
			
			Section("Structured data") {
				AIExamplesItemView(
					title: "Structured data",
					icon: "swiftdata",
					color: .red,
					navigationDestination: AnyView(
						AIStructuredDataExampleView()
					)
				)
			}
			
			
		}
		
		
    }
}

#Preview {
    AIExamplesListView()
}
