//
//  LabelStyle+IconTintLabelStyle.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import Foundation
import SwiftUI

extension LabelStyle where Self == IconTintLabelStyle {
	static func iconTint(_ color: Color) -> Self {
		.init(color: color)
	}
}

struct IconTintLabelStyle: LabelStyle {
	let color: Color
	
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon.foregroundStyle(color)
			configuration.title
		}
	}
}
