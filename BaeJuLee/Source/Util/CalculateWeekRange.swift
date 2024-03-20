//
//  CalculateDate.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/19/24.
//

import Foundation

extension Date {
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
}
