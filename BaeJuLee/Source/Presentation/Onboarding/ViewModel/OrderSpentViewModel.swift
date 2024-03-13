//
//  OrderSpentViewModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import Foundation

final class OrderSpentViewModel {
    var orderSpentText: Observable<String?> = Observable(nil)
    
    var isCompleteButtonEnabled: Observable<Bool> = Observable(false)
    
    init() {
        orderSpentText.bind { [weak self] text in
            self?.isCompleteButtonEnabled.value = !(text?.isEmpty ?? true)
        }
    }
}
