//
//  Extension+UITextField.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import UIKit
import TextFieldEffects

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
