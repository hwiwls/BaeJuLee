//
//  CalculateDate.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/19/24.
//

import Foundation

extension Date {
//    func setKoLocale() -> Date? {
//           let dateFormatter = DateFormatter()
//           let convertDate = toStringKST(dateFormat: "yyyy년 MM월 dd일")
//           
//           return dateFormatter.date(from: convertDate)
//       }
       
//       func toString( dateFormat format: String) -> String {
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = format
//           dateFormatter.timeZone = TimeZone.autoupdatingCurrent
//           dateFormatter.locale = Locale.current
//           
//           let current = Calendar.current
//           
//           return current.isDateInToday(self) ? dateFormatter.string(from: self)  + " (오늘)" : dateFormatter.string(from: self)
//       }
//       
//       func toStringTime( dateFormat format: String) -> String {
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = format
//           dateFormatter.timeZone = TimeZone.autoupdatingCurrent
//           dateFormatter.locale = Locale.current
//           
//           return dateFormatter.string(from: self)
//       }
//       
//       func toStringKST( dateFormat format: String ) -> String {
//           return self.toString(dateFormat: format)
//       }
    
    func toStringKST(dateFormat format: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFormatter.locale = Locale(identifier: "ko_KR")
            return dateFormatter.string(from: self)
        }
       
       func toStringUTC(_ timezone: Int ) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "a h:m"
           dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
           return dateFormatter.string(from: self)
       }
    
        // 한국 시간대 기준으로 현재 날짜가 속한 주의 시작일(일요일)과 종료일(토요일)을 반환합니다.
        func koreanWeekStartAndEnd() -> (start: Date, end: Date) {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
            calendar.locale = Locale(identifier: "ko_KR")
            calendar.firstWeekday = 1 // 일요일을 주의 첫 번째 날로 설정

            // 현재 날짜가 속한 주의 시작일을 찾습니다.
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
            
            print("startOfWeek: \(startOfWeek)")
            print("endOfWeek: \(endOfWeek)")

            return (startOfWeek, endOfWeek)
        }
    
    func endOfDayKST() -> Date {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
            
            // 다음 날의 시작 (한국 시간 기준 자정)
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: self) else {
                return self // 적절한 처리가 필요
            }
            
            let startOfNextDay = calendar.startOfDay(for: nextDay)
            let endOfToday = startOfNextDay.addingTimeInterval(-1) // 다음 날 자정 1초 전
            
            return endOfToday
        }
}


extension Date {
    func weekRangeInCurrentTimeZone() -> (currentWeekStart: String, lastWeekStart: String, lastWeekEnd: String) {
        var calendar = Calendar.current
                calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
                calendar.firstWeekday = 1 // 일요일을 주의 첫 번째 날로 설정
                
                let components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
                let startOfWeek = calendar.date(from: components)!
                
                let startOfDay = calendar.startOfDay(for: startOfWeek)
                
                let lastWeekStart = calendar.date(byAdding: .day, value: -7, to: startOfDay)!
                let lastWeekEnd = calendar.date(byAdding: .second, value: -1, to: startOfDay)!
        print("startOfDay: \(startOfDay)")
        print("lastWeekStart: \(lastWeekStart)")
        print("lastWeekEnd: \(lastWeekEnd)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간대로 설정
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국 로케일로 설정

        let startOfDayString = dateFormatter.string(from: startOfDay)
        let lastWeekStartString = dateFormatter.string(from: lastWeekStart)
        let lastWeekEndString = dateFormatter.string(from: lastWeekEnd)

        print("startOfDay: \(startOfDayString)") // 한국 시간대 기준 문자열
        print("lastWeekStart: \(lastWeekStartString)") // 한국 시간대 기준 문자열
        print("lastWeekEnd: \(lastWeekEndString)")
        
        return (startOfDayString, lastWeekStartString, lastWeekEndString)
    }
}
