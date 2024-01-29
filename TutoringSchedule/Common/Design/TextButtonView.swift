//
//  TextButtonView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 1/25/24.
//

import UIKit

final class TextButtonView: BaseView {
    
    lazy var button = {
        let view = UIButton()
        view.titleLabel?.font = .customFont(sytle: .bold, ofSize: 15)
        view.layer.cornerRadius = 8
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .bdBlue
        return view
    }()

    init(title: String) {
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConfigure() {
        addSubview(button)
    }
    
    override func setConstraint() {
        self.snp.makeConstraints {
            $0.height.equalTo(68)
        }
        
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(44)
        }
    }
}
