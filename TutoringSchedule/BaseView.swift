//
//  BaseView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConfigure() { }
    func setConstraint() { }
}
