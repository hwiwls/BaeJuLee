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
    @Persisted var mealTime: String
    @Persisted var mealType: String
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
