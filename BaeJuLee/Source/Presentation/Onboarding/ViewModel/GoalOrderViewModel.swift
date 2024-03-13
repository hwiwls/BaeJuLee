//
//  GoalOrderViewModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import Foundation

final class GoalOrderViewModel {
    var goalOrderCntText: Observable<String?> = Observable(nil)
    var isCompleteButtonEnabled: Observable<Bool> = Observable(false)
    
    private let repository = UserRepository()
    
    init() {
        goalOrderCntText.bind { [weak self] text in
            self?.isCompleteButtonEnabled.value = !(text?.isEmpty ?? true)
        }
    }
}
