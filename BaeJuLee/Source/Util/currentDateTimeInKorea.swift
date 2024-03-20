//
//  currentDateTimeInKorea.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/19/24.
//

import Foundation

func currentDateTimeInKorea() -> Date {
    let timeZoneOffset = TimeZone(identifier: "Asia/Seoul")!.secondsFromGMT()
    let currentDate = Date()
    guard let kstDate = Calendar.current.date(byAdding: .second, value: timeZoneOffset, to: currentDate) else {
        fatalError("error")
    }
    return kstDate
}
