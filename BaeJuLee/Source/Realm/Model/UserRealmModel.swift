//
//  UserRealmModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import RealmSwift

final class UserRealmModel: Object {
    @Persisted(primaryKey: true) var userid: ObjectId
    @Persisted var onboardingData: OnboardingDataModel?
    @Persisted var meals: List<MealRealmModel>
    @Persisted var lastWeekDeliveryCount: Int // 지난주 배달 횟수
    @Persisted var lastWeekDeliverySpend: Double // 지난주 배달 음식 지출
    @Persisted var targetDeliveryCount: Int // 목표 배달 횟수
    @Persisted var hasCompletedOnboarding: Bool = false
    
    convenience init(lastWeekDeliveryCount: Int, lastWeekDeliverySpend: Double, targetDeliveryCount: Int) {
        self.init()
        self.lastWeekDeliveryCount = lastWeekDeliveryCount
        self.lastWeekDeliverySpend = lastWeekDeliverySpend
        self.targetDeliveryCount = targetDeliveryCount
    }
}
