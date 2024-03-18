//
//  DateFormatterUtility.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/16/24.
//

import Foundation

struct DateFormatterUtility {
    static let shared = DateFormatterUtility()

    private init() {}

    func string(from date: Date, withFormat format: String, localeIdentifier: String = "ko_KR") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: localeIdentifier)
        return formatter.string(from: date)
    }
}
