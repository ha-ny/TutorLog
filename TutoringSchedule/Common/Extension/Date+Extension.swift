//
//  Date+Extension.swift
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
    
    static func stringToDate(format: String, date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return date == "24:0" ? dateFormatter.date(from: "00:00") : dateFormatter.date(from: date)
    }
}

    
