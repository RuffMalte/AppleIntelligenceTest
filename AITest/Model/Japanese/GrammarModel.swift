//
//  GrammarModel.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//


import SwiftUI
import FoundationModels


@Generable
struct GrammarModel: Codable {
	
	
	var name: String
	
	@Guide(description: "Write a Description")
	var description: String
	
	
	@Guide(description: "All Grammer Components")
	var grammarComponent: [GrammarComponent]
	
}

@Generable
struct GrammarComponent: Codable {
	var kanji: String
	var romanji: String
	var hiragana: String
	var katakana: String
	var english: String
	
	
	var otherUsese: [String]
	
	
	
}

