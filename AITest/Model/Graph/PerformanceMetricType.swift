//
//  PerformanceMetricType.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//
import Foundation

enum PerformanceMetricType: String, CaseIterable, Identifiable {
    case aiResponse
    case recipe
	case recipeWithTool
	case summary
	
    var id: String { rawValue }
    
    var userDefaultsKey: String {
        switch self {
        case .aiResponse: 
			return "executionTimes"
		case .recipe:
			return "recipePerformanceTimes"
		case .recipeWithTool:
			return "recipeWithToolPerformanceTimes"
		case .summary:
			return "summary"
		}
    }
    
    var navigationTitle: String {
        switch self {
        case .aiResponse: 
			return "Simple AI Response"
		case .recipe:
			return "Recipe Generation"
		case .recipeWithTool:
			return "Recipe with Tool"
		case .summary:
			return "Text summarization"
		}
    }
    
    var unitName: String {
        switch self {
        case .aiResponse: 
			return "s"
		case .recipe:
			return "s"
		case .recipeWithTool:
			return "s"
		case .summary:
			return "s"
		}
    }
	
	var icon: String {
		switch self {
		case .aiResponse:
			return "1.square"
		case .recipe:
			return "carrot.fill"
		case .recipeWithTool:
			return "hammer.fill"
		case .summary:
			return "text.append"
		}
	}
}
