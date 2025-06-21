//
//  GenerateAnswerButtonView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct GenerateAnswerButtonView: View {
	
	var onPress: () -> Void
	
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Button {
					onPress()
				} label: {
					Label("Generate", systemImage: "sparkles")
						.labelStyle(.iconTint(.orange))
				}
				.padding()
				.buttonStyle(.plain)
			}
			.glassEffect(.regular.interactive(), in: .capsule)
			.font(
				.system(
					.headline,
					design: .monospaced,
					weight: .bold
				)
			)
		}
    }
}

#Preview {
	GenerateAnswerButtonView {
		print("Generate")
	}
}
