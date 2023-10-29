//
//  Extension+Date.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import Foundation

extension Date {
    static func convertToString(format: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func betweenDate(date: Date) -> (start: Date, end: Date) {
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(24 * 60 * 60 - 1) // 1초 = 60, 1시간 = 60 * 60, 하루 24시간, - 1분
        return (start, end)
    }
}

    
