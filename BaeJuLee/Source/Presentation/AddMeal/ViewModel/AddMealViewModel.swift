//
//  AddMealViewModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/16/24.
//

import Foundation

class AddMealViewModel {
    var inputDateSelected: Observable<Date?> = Observable(nil)
    
    var outputFormattedDate: Observable<String?> = Observable(nil)
    
    init() {
        inputDateSelected.bind { [weak self] date in
            guard let strongSelf = self, let date = date else { return }
            strongSelf.updateFormattedDate(date: date)
        }
    }
    
    private func updateFormattedDate(date: Date) {
        let formattedDate = DateFormatterUtility.shared.string(from: date, withFormat: "yyyy년 MM월 dd일")
        outputFormattedDate.value = formattedDate
    }
}
