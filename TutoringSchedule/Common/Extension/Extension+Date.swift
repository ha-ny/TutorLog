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
}

    
