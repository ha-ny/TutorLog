//
//  UIButton+Extension.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import UIKit

//일정등록: 요일 버튼
extension UIButton {
    func days() -> UIButton {
        let view = UIButton()
        view.setTitleColor(.bdBlack, for: .normal)
        view.layer.backgroundColor = UIColor.bdLine.cgColor
        view.layer.cornerRadius = 6
        view.titleLabel?.font = .customFont(sytle: .bold, ofSize: 13)
        return view
    }
}
