//
//  RecipeImageTool.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import Foundation
import FoundationModels

struct RecipeImageTool: Tool {
	
	
	let name: String = "RecipeImage Database"
	let description: String = "Searches a local database for images of a given recipe."
	
	@Generable
	struct Arguments {
		@Guide(description: "The recipe to search for ")
		var recipeName: String
		
		@Guide(description: "The number of results to return", .range(1...6))
		var limit: Int
	}
	
	
	
	func call(arguments: Arguments) async throws -> ToolOutput {
		var recipesImageURL: [RecipeImage] =  []
		
		
		recipesImageURL = RecipeImage.samples

		let formatedURLs: [String] = recipesImageURL.map { image in
			"ImageURL for '\(arguments.recipeName)': \(image.category) Link: \(image.imageURL.absoluteString)"
		}
		
		print("Used Tool: \(name)\n")
		
		
		return ToolOutput(GeneratedContent(properties: [
			"imageURLs": formatedURLs
		]))
	}
	
}

struct RecipeImage: Codable, Identifiable {
	var id: UUID = UUID()
	let imageURL: URL
	let title: String
	let category: String
	let countryOfOrigin: String
}

extension RecipeImage {
	static let samples: [RecipeImage] = [
		.init(
			imageURL: URL(string: "https://i.redd.it/m1gsqzhtrph41.jpg")!,
			title: "Shoyu Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://i.redd.it/r598zpcf6x321.jpg")!,
			title: "Shio Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://dishingouthealth.com/wp-content/uploads/2022/01/SpicyMisoRamen_Square.jpg")!,
			title: "Miso Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://www.foodandwine.com/thmb/0AXGLeY6dYnY8sEXFqxBa8opDrs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Tonkotsu-Ramen-FT-BLOG1122-8fe6c12d609a4fd4ab246bea3aae140e.jpg")!,
			title: "Tonkotsu Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://sudachirecipes.com/wp-content/uploads/2022/11/tsukemen-7.jpg")!,
			title: "Tsukemen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://example.com/ramen_vegan.jpg")!,
			title: "https://www.rainbownourishments.com/wp-content/uploads/2021/05/easy-vegan-ramen-3..-720x900.jpg",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://i.redd.it/5s7ryksc0u411.jpg")!,
			title: "Spicy Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://blog.sakura.co/wp-content/uploads/2021/10/shutterstock_389877100-1.jpg")!,
			title: "Kyushu Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://www.thefoodlens.com/uploads/2017/01/SANTOUKA-RAMEN_BRIAN-SAMUELS_SEPT-2016-9925.jpg")!,
			title: "Hokkaido Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		),
		.init(
			imageURL: URL(string: "https://media.timeout.com/images/105591139/1372/1029/image.jpg")!,
			title: "Tokyo Ramen",
			category: "Food",
			countryOfOrigin: "Japan"
		)
	]
}
