//
//  AddMealViewModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/16/24.
//

import Foundation
import RealmSwift

class AddMealViewModel {
    var inputDateSelected: Observable<Date?> = Observable(nil)
    
    var outputFormattedDate: Observable<String?> = Observable(nil)
    
    var inputMealTimeSelected: Observable<AddMealViewController.MealTime?> = Observable(nil)
    var inputMealTypeSelected: Observable<AddMealViewController.MealType?> = Observable(nil)
    var inputMealPriceEntered: Observable<Bool> = Observable(false)

    var outputIsCompleteButtonEnabled: Observable<Bool> = Observable(false)
    
    init() {
        inputDateSelected.bind { [weak self] date in
            guard let strongSelf = self, let date = date else { return }
            strongSelf.updateFormattedDate(date: date)
        }
        
        inputMealTimeSelected.bind { [weak self] _ in
            self?.updateCompleteButtonState()
        }
        
        inputMealTypeSelected.bind { [weak self] _ in
            self?.updateCompleteButtonState()
        }
        
        inputMealPriceEntered.bind { [weak self] _ in
            self?.updateCompleteButtonState()
        }
    }
    
    private func updateFormattedDate(date: Date) {
        let formattedDate = DateFormatterUtility.shared.string(from: date, withFormat: "yyyy년 MM월 dd일")
        outputFormattedDate.value = formattedDate
    }
    
    private func updateCompleteButtonState() {
        let isBothSelected = inputMealTimeSelected.value != nil && inputMealTypeSelected.value != nil && inputMealPriceEntered.value
        outputIsCompleteButtonEnabled.value = isBothSelected
    }
    
    func saveMealData(mealName: String?, mealPrice: String?) {
        guard let mealTime = inputMealTimeSelected.value?.rawValue,
              let mealType = inputMealTypeSelected.value?.rawValue,
              let mealPrice = Double(mealPrice ?? "0") else {
            return
        }
        
        let meal = MealRealmModel(mealRegDate: Date(), mealTime: mealTime, mealType: mealType, mealPrice: mealPrice, mealName: mealName ?? "")
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(meal)
        }
    }
}
