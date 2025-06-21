//
//  PerformanceMetricType.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//
import Foundation

enum PerformanceMetricType: String, CaseIterable, Identifiable {
    case aiResponse
    case recipie
	
    var id: String { rawValue }
    
    var userDefaultsKey: String {
        switch self {
        case .aiResponse: 
			return "executionTimes"
		case .recipie:
			return "recipiePerformanceTimes"
		}
    }
    
    var navigationTitle: String {
        switch self {
        case .aiResponse: 
			return "AI Response Times"
		case .recipie:
			return "Recipie Performance Times"
		}
    }
    
    var unitName: String {
        switch self {
        case .aiResponse: 
			return "s"
		case .recipie:
			return "s"
		}
    }
}
