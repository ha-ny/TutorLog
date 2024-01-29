//
//  Component.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/24.
//

import UIKit

extension UIColor {
    static let bgPrimary = UIColor(named: "bgPrimary")!
    static let bdLine = UIColor(named: "bdLine")!
    
    //text
    static let bdBlack = UIColor(named: "bdBlack")!
    static let bdBlue = UIColor(named: "bdBlue")!
    static let bdRed = UIColor(named: "bdRed")!

    static let pkBlue = UIColor(named: "pkBlue")!
    static let pkBlue2 = UIColor(named: "pkBlue2")!
    static let pkBlue3 = UIColor(named: "pkBlue3")!
}

extension UIImage {
    static let down = UIImage(named: "down")!
    static let edit = UIImage(named: "edit")!
    static let addList = UIImage(named: "addList")!
    static let left = UIImage(named: "left")!
    
    //tab
    static let calender = UIImage(named: "calender")!
    static let tapCalender = UIImage(named: "tapCalender")!
    static let classList = UIImage(named: "classList")!
    static let tapClassList = UIImage(named: "tapClassList")!
    static let student = UIImage(named: "student")!
    static let tapStudent = UIImage(named: "tapStudent")!
}

extension UIFont {
    enum FontStyle {
        case normal
        case bold
    }

    static func customFont(sytle: FontStyle = .normal, ofSize: CGFloat) -> UIFont {
        switch sytle {
        case .normal: return UIFont(name: "Pretendard-Medium", size: ofSize)!
        case .bold: return UIFont(name: "Pretendard-SemiBold", size: ofSize)!
        }
    }
}
