//
//  OnboardingDataModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/13/24.
//

import Foundation
import RealmSwift

// 처음 앱을 시작하면 이전 주에 대한 절약 금액이 없어서 따로 저장
class OnboardingDataModel: EmbeddedObject {
    @Persisted var initialDeliveryCountLastWeek: Int
    @Persisted var initialDeliveryCostLastWeek: Double
    @Persisted var targetDeliveryCount: Int
    
    convenience init(initialDeliveryCountLastWeek: Int, initialDeliveryCostLastWeek: Double, targetDeliveryCount: Int) {
        self.init()
        self.initialDeliveryCountLastWeek = initialDeliveryCountLastWeek
        self.initialDeliveryCostLastWeek = initialDeliveryCostLastWeek
        self.targetDeliveryCount = targetDeliveryCount
    }
}
