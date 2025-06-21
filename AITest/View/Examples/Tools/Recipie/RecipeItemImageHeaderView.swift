//
//  RecipeItemImageHeaderView.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI

struct RecipeItemImageHeaderView: View {
	
	let recipe: RecipeModel
	
    var body: some View {
		Section {
			GeometryReader { reader in
				TabView {
					ForEach(
						recipe.imageURLsAsStrings,
						id: \.self
					) { stringURL in
						if let url = URL(string: stringURL) {
							AsyncImage(url: url) { phase in
								switch phase {
								case .empty:
									VStack {
										Spacer()
										AIProgressView()
										Spacer()
									}
									.frame(
										width: reader.size.width,
										height: reader.size.height
									)
									.background(Color.white)
								case .success(let image):
									image
										.resizable()
										.scaledToFill()
										.frame(
											width: reader.size.width,
											height: reader.size.height
										)
										.clipped()
								case .failure:
									VStack {
										Spacer()
										ContentUnavailableView {
											Image(systemName: "xmark.circle")
												.font(.largeTitle)
										} description: {
											VStack {
												Text("Couldn't load Image")
													.font(.caption)
													.foregroundStyle(.secondary)
												
												Text(stringURL)
													.foregroundStyle(.red)
													.font(.callout)
											}
										} actions: {
											Button {
												
											} label: {
												
											}

										}

										
										Spacer()
									}
									
								@unknown default:
									EmptyView()
								}
							}
						}
						
					}
					.tabViewStyle(.page(indexDisplayMode: .always))
				}
				.tabViewStyle(.page(indexDisplayMode: .always))
			}
			.frame(height: 300)
			.listRowInsets(.all, 0)
		} header: {
			Text("Fetch from (API)")
		} footer: {
			Text("Currently this is fetched from local Models")
		}
    }
}

#Preview {
	Form {
		RecipeItemImageHeaderView(recipe: .japaneseCurry)
	}
}
