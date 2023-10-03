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

//배경색
extension UIColor {
    static let backgroundColor = UIColor.white
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



//view.backgroundColor = UIColor(rgb: 0x123456)
//Extension UIColor {
//   convenience init(rgb: Int) {
//       self.init(
//           red: (rgb >> 16) & 0xFF,
//           green: (rgb >> 8) & 0xFF,
//           blue: rgb & 0xFF
//       )
//   }
//}
