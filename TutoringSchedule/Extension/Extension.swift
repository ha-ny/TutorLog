//
//  Extension.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import TextFieldEffects

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
        dateFormatter.locale = Locale(identifier: "ko_kr") // 한국의 시간을 지정해준다.
        dateFormatter.timeZone = TimeZone(abbreviation: "KST") // 한국의 시간대로 지정한다.
        return dateFormatter.string(from: date) // Date to String
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
        view.placeholderFontScale = 0.7
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

