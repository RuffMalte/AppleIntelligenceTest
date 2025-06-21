//
//  UserDefaults.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//

import Foundation

struct ExecutionTimeStore {
	static let key = "executionTimes"
	
	static func save(_ time: Double) {
		var times = load()
		times.append(time)
		UserDefaults.standard.set(times, forKey: key)
	}
	
	static func load() -> [Double] {
		UserDefaults.standard.array(forKey: key) as? [Double] ?? []
	}
	
	static func clear() {
		UserDefaults.standard.removeObject(forKey: key)
	}
}




func measureTime(for closure: () -> Void) {
	let start = CFAbsoluteTimeGetCurrent()
	closure()
	let diff = CFAbsoluteTimeGetCurrent() - start
	print("Took \(diff) seconds")
}
