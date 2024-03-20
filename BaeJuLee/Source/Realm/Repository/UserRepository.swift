//
//  UserRepository.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/13/24.
//

import Foundation
import RealmSwift

class UserRepository {
    private var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func createUser(onboardingData: OnboardingDataModel, goalOrderCnt: Int) {
        let user = UserRealmModel()
        user.onboardingData = onboardingData
        user.onboardingData?.targetDeliveryCount = goalOrderCnt
//        user.userRegDate = currentDateTimeInKorea()
        user.userRegDate = Date()
        
        do {
            try realm.write {
                realm.add(user)
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateUserOnboardingCompletion() {
        if let user = realm.objects(UserRealmModel.self).first {
            do {
                try realm.write {
                    user.hasCompletedOnboarding = true
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func checkUserOnboardingCompletion() -> Bool {
        if let user = realm.objects(UserRealmModel.self).first {
            return user.hasCompletedOnboarding
        }
        return false
    }
}
