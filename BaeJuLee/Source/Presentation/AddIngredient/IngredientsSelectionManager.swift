//
//  IngredientsSelectionManager.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/23/24.
//

//import Foundation
//
//class SelectedIngredientsManager {
//    static let shared = SelectedIngredientsManager()
//
//    private(set) var selectedIngredients: Set<String> = []
//    let maxSelectionLimit = 10
//
//    private init() {}
//
//    func toggleIngredient(_ ingredient: String) -> Bool {
//        if selectedIngredients.contains(ingredient) {
//            selectedIngredients.remove(ingredient)
//            return true
//        } else if selectedIngredients.count < maxSelectionLimit {
//            selectedIngredients.insert(ingredient)
//            return true
//        }
//        return false
//    }
//
//    func isSelected(_ ingredient: String) -> Bool {
//        return selectedIngredients.contains(ingredient)
//    }
//}

import UIKit


class SelectedIngredientsManager {
    static let shared = SelectedIngredientsManager()
    
    private var _selectedIngredients: [String] = [] {
        didSet {
            NotificationCenter.default.post(name: .selectedIngredientsChanged, object: nil)
        }
    }
    var selectedIngredients: Set<String> {
        get { Set(_selectedIngredients) }
        set { _selectedIngredients = Array(newValue) }
    }
    
    let maxSelectionLimit = 10

    private init() {}

    func toggleIngredient(_ ingredient: String) -> Bool {
        if _selectedIngredients.contains(ingredient) {
            _selectedIngredients.removeAll { $0 == ingredient }
            return true
        } else if _selectedIngredients.count < maxSelectionLimit {
            _selectedIngredients.append(ingredient)
            return true
        }
        return false
    }

    func isSelected(_ ingredient: String) -> Bool {
        return _selectedIngredients.contains(ingredient)
    }
}

extension Notification.Name {
    static let selectedIngredientsChanged = Notification.Name("selectedIngredientsChanged")
}
