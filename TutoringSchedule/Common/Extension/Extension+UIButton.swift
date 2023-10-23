//
//  Extension+UIButton.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import UIKit

//일정등록: 요일 버튼
extension UIButton {
    
    func days() -> UIButton {
        let view = UIButton()
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }
}
