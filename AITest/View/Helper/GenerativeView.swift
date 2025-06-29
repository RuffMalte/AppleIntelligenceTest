//
//  GenerativeView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI
import FoundationModels

@available(macOS 26.0, *)
struct GenerativeView: View {
	// Create a reference to the system language model.
	private var model = SystemLanguageModel.default
	
	
	var body: some View {
		switch model.availability {
		case .available:
			Label("Available", systemImage: "apple.intelligence")
				.labelStyle(.iconTint(.orange))
			
		case .unavailable(.deviceNotEligible):
			Label("Device not eligible", systemImage: "iphone.badge.exclamationmark")
				.labelStyle(.iconTint(.orange))
			
		case .unavailable(.appleIntelligenceNotEnabled):
			Label("Unavailable", systemImage: "xmark.circle.fill")
				.labelStyle(.iconTint(.orange))
			
		case .unavailable(.modelNotReady):
			Label("Model not ready", systemImage: "square.3.stack.3d.slash")
				.labelStyle(.iconTint(.orange))
			
		case .unavailable(_):
			Text("Unknown")
				.labelStyle(.iconTint(.orange))
		}
	}
}

#Preview {
	GenerativeView()
}
