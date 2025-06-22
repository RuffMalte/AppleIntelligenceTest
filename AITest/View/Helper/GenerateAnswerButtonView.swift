//
//  GenerateAnswerButtonView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct GenerateAnswerButtonView: View {
	
	var text: String = "Generate"
	var systemImage: String = "apple.intelligence"
	
	var onPress: () -> Void
	
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Button {
					onPress()
				} label: {
					Label(text, systemImage: systemImage)
						.labelStyle(.iconTint(.orange))
						.padding()
						.glassEffect(.regular.interactive(), in: .capsule)
						.font(
							.system(
								.headline,
								design: .monospaced,
								weight: .bold
							)
						)
				}
				.buttonStyle(.plain)

			}
		}
    }
}

#Preview {
	GenerateAnswerButtonView {
		print("Generate")
	}
}
