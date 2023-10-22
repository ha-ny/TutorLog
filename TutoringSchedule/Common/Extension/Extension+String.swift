//
//  Extension+String.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import Foundation

//다국어 지원
extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
