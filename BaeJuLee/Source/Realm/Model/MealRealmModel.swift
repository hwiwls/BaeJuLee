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
    @Persisted var mealTime: String // 아침, 점심, 저녁, 간식
    @Persisted var mealType: String // 배달음식, 집밥
    @Persisted var mealPrice: Double
    @Persisted var mealName: String
    
    convenience init(mealRegDate: Date, mealTime: String, mealType: String, mealPrice: Double, mealName: String) {
        self.init()
        self.mealRegDate = mealRegDate
        self.mealTime = mealTime
        self.mealType = mealType
        self.mealPrice = mealPrice
        self.mealName = mealName
    }
}
