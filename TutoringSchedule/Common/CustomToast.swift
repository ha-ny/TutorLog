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
        style.backgroundColor = .bdLine
        style.messageColor = .bdBlue
        style.messageFont = .customFont(sytle: .bold, ofSize: 13)
        return style
    }
}
