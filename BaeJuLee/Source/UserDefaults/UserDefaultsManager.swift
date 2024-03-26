//
//  UserDefaultsManager.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/27/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    private let recommendationCountKey = "RecommendationCount"
    private let lastRequestDateKey = "LastRequestDate"
    
    private init() {}
    
    func incrementRecommendationCount() {
        let count = getRecommendationCount()
        defaults.set(count + 1, forKey: recommendationCountKey)
    }
    
    func getRecommendationCount() -> Int {
        return defaults.integer(forKey: recommendationCountKey)
    }
    
    func resetRecommendationCountIfNeeded() {
        let currentDate = Calendar.current.startOfDay(for: Date())
        guard let lastRequestDate = defaults.object(forKey: lastRequestDateKey) as? Date else {
            resetCountForNewDay(currentDate: currentDate)
            return
        }
        
        if !Calendar.current.isDate(lastRequestDate, inSameDayAs: currentDate) {
            resetCountForNewDay(currentDate: currentDate)
        }
    }
    
    private func resetCountForNewDay(currentDate: Date) {
        defaults.set(0, forKey: recommendationCountKey)
        defaults.set(currentDate, forKey: lastRequestDateKey)
    }
}

