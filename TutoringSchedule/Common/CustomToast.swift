//
//  CustomToast.swift
//  TutoringSchedule
//
//  Created by 김하은 on 11/19/23.
//

import Foundation
import Toast

class CustomToast {
    static func setting() -> ToastStyle {
        var style = ToastStyle()
        style.backgroundColor = .systemGray6
        style.messageColor = .signatureColor
        style.messageFont = .boldSystemFont(ofSize: 13)
        return style
    }
}
