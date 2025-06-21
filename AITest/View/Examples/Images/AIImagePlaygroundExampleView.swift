//
//  AIImagePlaygroundExampleView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI
import ImagePlayground

struct AIImagePlaygroundExampleView: View {
	
	@State private var imageURL: URL?

	@State private var isShowingImagePlaygroundSheet: Bool = false
	
	@Environment(\.supportsImagePlayground) private var supportsImagePlayground

    var body: some View {
		Form {
			GeometryReader { reader in
				Section {
					if let imageURL = imageURL {
						AsyncImage(url: imageURL) { image in
							image
								.resizable()
								.scaledToFill()
						} placeholder: {
							Text("(No image)")
						}
						
					} else {
						ContentUnavailableView(
							"No Image yet",
							systemImage: "photo.badge.exclamationmark.fill",
							description: Text("Use the blue button below")
						)
						
					}
				}
			}
			.listRowInsets(.all, 0)
			.frame(height: 350)
		}
		.overlay {
			VStack {
				Spacer()
				
				HStack {
					Label {
						Text(supportsImagePlayground.description.capitalized)
					} icon: {
						Image(systemName: "apple.image.playground.fill")
							.font(.largeTitle)
					}

					Divider()
						.frame(height: 30)
						.padding(.horizontal)
					Button {
						isShowingImagePlaygroundSheet.toggle()
					} label: {
						HStack {
							
							Image(systemName: "apple.image.playground.fill")
								.font(.largeTitle)
							
						}
					}
				}
				.font(
					.system(
						.headline,
						design: .monospaced,
						weight: .bold
					)
				)
				.padding()
				.glassEffect(.regular.interactive(), in: .capsule)
			}
		}
		.navigationTitle("Image Playground")
		.imagePlaygroundSheet(
			isPresented: $isShowingImagePlaygroundSheet,
			concept: "") { url in
				if let imageURL {
					try? FileManager.default.removeItem(at: imageURL)
				}
				
				let newImageURL = URL.documentsDirectory.appending(path: "\(UUID()).png")
				try? FileManager.default.moveItem(at: url, to: newImageURL)
				imageURL = newImageURL
			}
    }
}

#Preview {
    AIImagePlaygroundExampleView()
}
