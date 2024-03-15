//
//  File.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import Foundation
import RealmSwift

final class MealRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var mealRegDate: Date
    @Persisted var mealTime: Int // 0: 아침, 1: 점심, 2: 저녁, 3: 간식
    @Persisted var mealType: Int // 0: 집밥, 1: 외식, 2: 배달
    @Persisted var mealPrice: Double
    @Persisted var mealName: String
    
    convenience init(mealRegDate: Date, mealTime: Int, mealType: Int, mealPrice: Double, mealName: String) {
        self.init()
        self.mealRegDate = mealRegDate
        self.mealTime = mealTime
        self.mealType = mealType
        self.mealPrice = mealPrice
        self.mealName = mealName
    }
}
