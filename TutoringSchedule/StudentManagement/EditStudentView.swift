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

    lazy var nameTextField = {
        let view = UITextField().hoshi(title: "* 이름")
        view.tag = 0
        view.returnKeyType = .continue
        view.delegate = self
        return view
    }()
    
    lazy var studentPhoneNumTextField = {
        let view = UITextField().hoshi(title: "학생 연락처")
        view.tag = 1
        view.returnKeyType = .continue
        view.keyboardType = .numberPad
        view.delegate = self
        return view
    }()
 
    lazy var parentPhoneNumTextField = {
        let view = UITextField().hoshi(title: "학부모 연락처")
        view.tag = 2
        view.returnKeyType = .continue
        view.keyboardType = .numberPad
        view.delegate = self
        return view
    }()
    
    lazy var addressTextField = {
        let view = UITextField().hoshi(title: "주소")
        view.tag = 3
        view.returnKeyType = .continue
        view.delegate = self
        return view
    }()
    
    lazy var memoTextField = {
        let view = UITextField().hoshi(title: "메모")
        view.returnKeyType = .done
        view.tag = 4
        return view
    }()

    override func setConfigure() {
        addSubview(nameTextField)
        addSubview(studentPhoneNumTextField)
        addSubview(parentPhoneNumTextField)
        addSubview(addressTextField)
        addSubview(memoTextField)
    }
    
    override func setConstraint() {
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(22)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.height.equalTo(60)
        }
        
        studentPhoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.height.equalTo(60)
        }

        parentPhoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(studentPhoneNumTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.height.equalTo(60)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(parentPhoneNumTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.height.equalTo(60)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.height.equalTo(60)
        }
    }
}

extension EditStudentView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = textField.superview?.viewWithTag(textField.tag + 1) {
            textField.becomeFirstResponder()
        }
        
        return true
    }
}
