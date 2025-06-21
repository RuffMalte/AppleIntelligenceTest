//
//  RecipeModel.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import SwiftUI
import FoundationModels

@Generable
enum RecipeDifficulty: String, Codable, Equatable {
	case easy
	case medium
	case hard
	
	var description: String {
		switch self {
		case .easy:
			return "Easy"
		case .medium:
			return "Medium"
		case .hard:
			return "Hard"
		}
	}
	
	var color: Color {
		switch self {
		case .easy:
			return .green
		case .medium:
			return .yellow
		case .hard:
			return .red
		}
	}
}

@Generable()
enum MealType: String, Codable, Equatable {
	case breakfast
	case lunch
	case dinner
}

@Generable()
struct RecipeOriginModel: Codable {
	@Guide(description: "Country of Origins Flag")
	var countryFlag: String
	
	var countryName: String
}

@Generable
struct RecipeModel: Codable {
	
	var name: String
	
	@Guide(
		description: "Image URL strings that match the recipe, only have valid URLS from the internet, no local paths, no example URLs, no URLs that lead to broken images, just valid URLs",
		.count(5)
	)
	var imageURLsAsStrings: [String]
	
	@Guide(description: "A short description of the recipe")
	var description: String
	
	@Guide(description: "Total time needed to prepare the recipe, including cooking time, in seconds")
	var duration: TimeInterval
	
	@Guide(description: "Total time needed to cook the recipe, in seconds")
	var cookingTime: TimeInterval

	@Guide(description: "Total time needed to prepare the recipe, in seconds")
	var prepTime: TimeInterval
	
	var difficulty: RecipeDifficulty
	var mealType: MealType
	
	
	var countryOfOrigin: RecipeOriginModel
	
	@Guide(description: "How many people the recipe is for, this can be then used to scale the ingredients")
	var ingredientsForPerson: Int
	
	var ingredients: [RecipeIngredientModel]
	
	@Guide(description: "Please provide the steps in the order they should be done")
	var steps: [String]
}


@Generable
struct RecipeIngredientModel: Codable, Identifiable {
	var id: String = UUID().uuidString
	var name: String
	var quantity: String
	
	var extraInformation: String?
}


extension RecipeModel {
	
	static let japaneseCurry: RecipeModel = RecipeModel(
		name: "Japanese Curry ",
		imageURLsAsStrings: [
			"https://i.redd.it/m1gsqzhtrph41.jpg",
			"https://i.redd.it/r598zpcf6x321.jpg",
			"https://dishingouthealth.com/wp-content/uploads/2022/01/SpicyMisoRamen_Square.jpg",
			"https://www.foodandwine.com/thmb/0AXGLeY6dYnY8sEXFqxBa8opDrs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Tonkotsu-Ramen-FT-BLOG1122-8fe6c12d609a4fd4ab246bea3aae140e.jpg",
			"https://sudachirecipes.com/wp-content/uploads/2022/11/tsukemen-7.jpg",
			"https://example.com/ramen_vegan.jpg",
			"https://i.redd.it/5s7ryksc0u411.jpg",
			"https://blog.sakura.co/wp-content/uploads/2021/10/shutterstock_389877100-1.jpg",
			"https://www.thefoodlens.com/uploads/2017/01/SANTOUKA-RAMEN_BRIAN-SAMUELS_SEPT-2016-9925.jpg",
			"https://media.timeout.com/images/105591139/1372/1029/image.jpg"
		],
		description: "A comforting and flavorful Japanese curry perfect for dinner.",
		duration: 180 * 60, // 180 minutes in seconds
		cookingTime: 90 * 60, // 90 minutes in seconds
		prepTime: 30 * 60, // 30 minutes in seconds
		difficulty: .easy,
		mealType: .dinner,
		countryOfOrigin: RecipeOriginModel(
			countryFlag: "🇯🇵",
			countryName: "Japan"
		),
		ingredientsForPerson: 4,
		ingredients: [
			RecipeIngredientModel(
				name: "Chicken thighs",
				quantity: "500g",
				extraInformation: "Skin-on, boneless"
			),
			RecipeIngredientModel(
				name: "Yellow curry powder",
				quantity: "2 tablespoons",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Onion",
				quantity: "2, thinly sliced",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Carrot",
				quantity: "2, julienned",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Potato",
				quantity: "3, peeled and cubed",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Canned coconut milk",
				quantity: "800ml",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Cornstarch",
				quantity: "1 tablespoon",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Water",
				quantity: "1 cup",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Vegetable oil",
				quantity: "2 tablespoons",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Eggs",
				quantity: "4",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Rice",
				quantity: "2 cups",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Salt",
				quantity: "to taste",
				extraInformation: nil
			),
			RecipeIngredientModel(
				name: "Pepper",
				quantity: "to taste",
				extraInformation: nil
			)
		],
		steps: [
			"1. **Prepare Ingredients**: Slice onions and carrots, cube potatoes, and gather all ingredients.",
			"2. **Cook Potatoes**: In a large pot, bring water to a boil. Add cubed potatoes and cook until tender, about 10 minutes.",
			"3. **Make Curry Base**: In a separate pan, heat vegetable oil over medium heat. Add sliced onions and curry powder, cooking until onions are soft.",
			"4. **Add Vegetables**: Stir in julienned carrots and potatoes, cooking for another 5 minutes.",
			"5. **Combine with Coconut Milk**: Pour in coconut milk, stirring well. Allow to simmer for 10 minutes.",
			"6. **Thicken Sauce**: Dissolve cornstarch in a little water, then add to the curry to thicken.",
			"7. **Prepare Eggs**: Beat eggs in a bowl, season with salt and pepper.",
			"8. **Cook Eggs**: In a separate pan, fry eggs sunny-side up.",
			"9. **Serve**: Plate rice and top with chicken thighs, curry sauce, and eggs."
		]
	)

}
