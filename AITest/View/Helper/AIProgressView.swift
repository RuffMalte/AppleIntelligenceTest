//
//  AIProgressView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct AIProgressView: View {
    var body: some View {
		Image(systemName: "sparkles")
			.font(.largeTitle)
			.padding()
			.foregroundStyle(.orange.gradient)
			.symbolEffect(.bounce.up.byLayer, options: .repeat(.periodic(delay: 0.0)))
    }
}

#Preview {
    AIProgressView()
}
