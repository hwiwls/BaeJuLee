//
//  CalculateDate.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/19/24.
//

import Foundation

extension Date {
    func startOfWeek(using calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        var adjustedCalendar = calendar
        adjustedCalendar.timeZone = TimeZone(identifier: "Asia/Seoul")!

        // 현재 날짜로부터 해당 주의 첫째 날(일요일)을 찾습니다.
        let components = adjustedCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        let startOfWeek = adjustedCalendar.date(from: components)!
        return adjustedCalendar.startOfDay(for: startOfWeek)
    }
    
    func endOfWeek(using calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        let startOfWeek = self.startOfWeek(using: calendar)
        var adjustedCalendar = calendar
        adjustedCalendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        // 시작일로부터 6일을 더해 해당 주의 마지막 날(토요일)을 구합니다.
        let endOfWeek = adjustedCalendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        return adjustedCalendar.startOfDay(for: endOfWeek)
    }
}
