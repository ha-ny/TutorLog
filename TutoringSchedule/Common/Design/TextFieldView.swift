//
//  TextFieldView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 1/25/24.
//

import UIKit

final class TextFieldView: BaseView {
    
    lazy var label = {
       let view = UILabel()
        view.font = .customFont(sytle: .bold, ofSize: 15)
        view.textColor = .bdBlack
        return view
    }()
    
    lazy var textField = {
       let view = UITextField()
        view.font = .customFont(ofSize: 14)
        view.textColor = .bdBlack
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.tintColor = .bdBlue
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        view.leftViewMode = .always
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.bdLine.cgColor
        return view
    }()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        label.text = title
        textField.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConfigure() {
        addSubview(label)
        addSubview(textField)
    }
    
    override func setConstraint() {
        self.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        label.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(4)
            $0.height.equalTo(20)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(4)
            
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}
