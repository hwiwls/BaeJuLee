//
//  OverviewViewModel.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/21/24.
//

import Foundation
import RealmSwift

class OverviewViewModel {
    var realmNotificationToken: NotificationToken?
    
    var savings: Observable<String> = Observable("")
    
    // 배달 횟수와 목표 배달 횟수
    var inputthisWeekDeliveryCount: Observable<Int> = Observable(0)
    var inputtargetDeliveryCount: Observable<Int> = Observable(10) // 예시 목표값
    
    // 프로그레스와 텍스트 업데이트를 위한 Observable
    var outputdeliveryProgress: Observable<Float> = Observable(0)
    var outputdeliveryCountText: Observable<String> = Observable("0/10 회")

    init() {
        calculateSavings()
        setupRealmNotification()
    }

    func setupRealmNotification() {
        let realm = try! Realm()
        realmNotificationToken = realm.objects(MealRealmModel.self).observe { [weak self] (changes) in
            switch changes {
            case .initial, .update(_, _, _, _):
                self?.calculateSavings()
            case .error(let error):
                print("An error occurred: \(error)")
            }
        }
    }

    deinit {
        realmNotificationToken?.invalidate()
    }
    
    func calculateWeekRange(from referenceDate: Date) -> (currentWeekStart: Date, lastWeekStart: Date, lastWeekEnd: Date) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1 // 주의 첫 번째 날을 일요일로 설정
        
        // 현재 주의 시작일 계산
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: referenceDate)
        guard let currentWeekStart = calendar.date(from: components) else {
            fatalError("Failed to calculate the start of the current week.")
        }
        
        let startOfDay = calendar.startOfDay(for: currentWeekStart)
        
        // 지난 주의 시작일 계산
        guard let lastWeekStart = calendar.date(byAdding: .day, value: -7, to: startOfDay) else {
            fatalError("Failed to calculate the start of the last week.")
        }
        
        // 지난 주의 끝을 계산 (현재 주의 시작 직전 순간)
        guard let lastWeekEnd = calendar.date(byAdding: .second, value: -1, to: startOfDay) else {
            fatalError("Failed to calculate the end of the last week.")
        }
        
        print("startOfday: \(startOfDay), lastWeekStart: \(lastWeekStart), lastWeekEnd: \(lastWeekEnd)")
        
        return (startOfDay, lastWeekStart, lastWeekEnd)
    }
    
    
    func calculateSavings() {
        let realm = try! Realm()
        let currentDate = Date()
        let (currentWeekStart, lastWeekStart, lastWeekEnd) = calculateWeekRange(from: currentDate)

        guard let user = realm.objects(UserRealmModel.self).first else { return }

        // 이번 주와 지난 주의 배달음식 지출을 계산하는 로직
        let thisWeekDeliverySpend: Double = realm.objects(MealRealmModel.self)
            .filter("mealType == '배달' AND mealRegDate >= %@ AND mealRegDate < %@", currentWeekStart, currentDate)
            .sum(ofProperty: "mealPrice")

        let lastWeekDeliverySpend: Double
        if user.userRegDate >= currentWeekStart {
            lastWeekDeliverySpend = user.onboardingData?.initialDeliveryCostLastWeek ?? 0
        } else {
            lastWeekDeliverySpend = realm.objects(MealRealmModel.self)
                .filter("mealType == '배달' AND mealRegDate >= %@ AND mealRegDate <= %@", lastWeekStart, lastWeekEnd)
                .sum(ofProperty: "mealPrice")
        }

        let savingValue = max(0, lastWeekDeliverySpend - thisWeekDeliverySpend)
        print("lastWeekDeliverySpend: \(lastWeekDeliverySpend), thisWeekDeliverySpend: \(thisWeekDeliverySpend)")
        
        let savingValueInt = Int(savingValue)
            
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let formattedSavingValue = numberFormatter.string(from: NSNumber(value: savingValueInt)) {
            print("절약 금액: \(formattedSavingValue)원")
            self.savings.value = "지난 주 대비\n\(formattedSavingValue)원 절약했어요!"
        }
        
        // 이번 주 배달 횟수 계산
        let thisWeekDeliveryCount: Int = realm.objects(MealRealmModel.self)
            .filter("mealType == %@ AND mealRegDate >= %@ AND mealRegDate < %@", "배달", currentWeekStart, currentDate)
            .count

        // 사용자의 목표 배달 횟수 가져오기
        let targetDeliveryCount = user.onboardingData?.targetDeliveryCount ?? 10

        // 프로그레스 및 텍스트 업데이트
        let progress = Float(thisWeekDeliveryCount) / Float(targetDeliveryCount)
        self.outputdeliveryProgress.value = progress
        
        let deliveryCountText = "\(thisWeekDeliveryCount)/\(targetDeliveryCount) 회"
        self.outputdeliveryCountText.value = deliveryCountText
    }
    
}

