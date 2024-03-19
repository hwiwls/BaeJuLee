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
    var inputMealDateSelected: Observable<Date> = Observable(Date())

    var outputIsCompleteButtonEnabled: Observable<Bool> = Observable(false)
    
    init() {
        inputDateSelected.bind { [weak self] date in
            guard let date = date else { return }
            self?.updateFormattedDate(date: date)
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
        
        inputMealDateSelected.bind { [weak self] _ in
            self?.updateCompleteButtonState()
        }
    }
    
    private func updateFormattedDate(date: Date) {
        let formattedDate = DateFormatterUtility.shared.string(from: date, withFormat: "yyyy년 MM월 dd일")
            outputFormattedDate.value = formattedDate
    }
    
    private func updateCompleteButtonState() {
        let isPriceEntered = inputMealPriceEntered.value
        outputIsCompleteButtonEnabled.value = isPriceEntered
    }
    
    func userDidSelectDate(date: Date) {
        inputDateSelected.value = date
    }
    
    func saveMealData(mealName: String?, mealPrice: String?) {
        guard let mealTime = inputMealTimeSelected.value?.rawValue,
              let mealType = inputMealTypeSelected.value?.rawValue,
              let mealPrice = Double(mealPrice ?? "0"),
              let user = try! Realm().objects(UserRealmModel.self).first else {
            print("Error")
            return
        }
        
        let meal = MealRealmModel(mealRegDate: inputMealDateSelected.value, mealTime: mealTime, mealType: mealType, mealPrice: mealPrice, mealName: mealName ?? "")
        let realm = try! Realm()
        try! realm.write {
            user.meals.append(meal)
        }
    }
}
