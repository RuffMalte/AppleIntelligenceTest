//
//  PerformanceMeasurer.swift
//  AITest
//
//  Created by Malte Ruff on 21.06.25.
//


import Foundation

struct PerformanceMeasurer {
    static func measureAndSave<Result>(
        metricType: PerformanceMetricType,
        task: @escaping () async throws -> Result,
        onStart: @escaping () -> Void,
        onComplete: @escaping (Result) -> Void
    ) async {
        // 1. Prepare state
        onStart()
        
        // 2. Measure execution
        let clock = ContinuousClock()
        var result: Result!
        let elapsed = await clock.measure {
            result = try? await task()
        }
        
        // 3. Convert and save time
        let seconds = elapsed.toSeconds()
        saveTime(metricType: metricType, seconds: seconds)
        
        // 4. Handle result
        onComplete(result)
        
        print("⏱️ Execution time: \(elapsed) | Saved: \(seconds)s")
    }
    
    private static func saveTime(metricType: PerformanceMetricType, seconds: Double) {
        var savedTimes = UserDefaults.standard.array(forKey: metricType.userDefaultsKey) as? [Double] ?? []
        savedTimes.append(seconds)
        UserDefaults.standard.set(savedTimes, forKey: metricType.userDefaultsKey)
    }
}

extension Duration {
    func toSeconds() -> Double {
        Double(self.components.seconds) + 
        (Double(self.components.attoseconds) / 1_000_000_000_000_000_000)
    }
}
