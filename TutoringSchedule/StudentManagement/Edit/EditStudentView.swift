//
//  EditStudentView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/08.
//

import UIKit

protocol saveSucsessDelegate {
    func saveSucsess()
}

class EditStudentView: BaseView {
    
    let lineView = {
       let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()
    
    lazy var nameTextField = {
        let view = TextFieldView(title: "\("placeOfName".localized) *", placeholder: "placeOfName".localized)
        view.textField.tag = 0
        view.textField.returnKeyType = .next
        
        let labelText = "\("placeOfName".localized) *"
        let attributedString = NSMutableAttributedString(string: labelText)

        if let range = labelText.range(of: "*") {
            let nsRange = NSRange(range, in: labelText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.bdRed, range: nsRange)
        }
        view.label.attributedText = attributedString
        return view
    }()
    
    lazy var studentPhoneNumTextField = {
        let view = TextFieldView(title: "placeOfStudentPhoneNum".localized, placeholder: "placeOfStudentPhoneNum".localized)
        view.textField.tag = 1
        view.textField.keyboardType = .numberPad
        return view
    }()
 
    lazy var parentPhoneNumTextField = {
        let view = TextFieldView(title: "placeOfParentPhoneNum".localized, placeholder: "placeOfParentPhoneNum".localized)
        view.textField.tag = 2
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    lazy var addressTextField = {
        let view = TextFieldView(title: "placeOfAddress".localized, placeholder: "placeOfAddress".localized)
        view.textField.tag = 3
        view.textField.returnKeyType = .done
        return view
    }()
    
    lazy var saveButton = TextButtonView(title: "저장")

    override func setConfigure() {
        addSubview(lineView)
        addSubview(nameTextField)
        addSubview(studentPhoneNumTextField)
        addSubview(parentPhoneNumTextField)
        addSubview(addressTextField)
        addSubview(saveButton)
    }
    
    override func setConstraint() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(0.7)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(28)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        studentPhoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }

        parentPhoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(studentPhoneNumTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(parentPhoneNumTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
