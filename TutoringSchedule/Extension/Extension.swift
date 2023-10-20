//
//  Extension.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import TextFieldEffects

extension NSNotification.Name {
    static let calendarReload = Notification.Name("calendarReload")
}

//다국어 지원
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

// Date -> String
extension Date {
    func convertToString(format: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func betweenDate(date: Date) -> (start: Date, end: Date) {
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(24 * 60 * 60 - 1) // 1초 = 60, 1시간 = 60 * 60, 하루 24시간, - 1분
        return (start, end)
    }
}

//HoshiTextField
extension UITextField {
    func hoshi(title: String) -> UITextField {
        let view = HoshiTextField()
        view.placeholder = title
        view.font = .boldSystemFont(ofSize: 14)
        view.textColor = .black
        view.placeholderColor = .gray
        view.placeholderFontScale = 0.9
        view.borderInactiveColor = .lightGray
        view.borderActiveColor = .darkGray
        return view
    }
}

//일정등록: 요일 버튼
extension UIButton {
    func days(title: String) -> UIButton {
        let view = UIButton()
        view.setTitle(title, for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }
}

extension UIAlertController {
    func customMessageAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        return alert
    }
}

