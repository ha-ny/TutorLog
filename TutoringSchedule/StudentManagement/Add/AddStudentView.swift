//
//  AddStudentView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/08.
//

import UIKit

class AddStudentView: BaseView {

    let nameTextField = {
        let view = UITextField().hoshi(title: "* 이름")
        return view
    }()
    
    let studentPhoneNumTextField = {
        let view = UITextField().hoshi(title: "학생 연락처")
        return view
    }()
    
    let parentPhoneNumTextField = {
        let view = UITextField().hoshi(title: "학부모 연락처")
        return view
    }()
    
    let addressTextField = {
        let view = UITextField().hoshi(title: "주소")
        return view
    }()
    
    let memoTextView = {
        let view = UITextField().hoshi(title: "메모")
        return view
    }()
    
    let addScheduleButton = {
        let view = UIButton()
        view.setTitle("일정 등록", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.layer.backgroundColor = UIColor.systemGray6.cgColor
        view.setTitleColor(UIColor.darkGray, for: .normal)
        return view
    }()

    override func setConfigure() {
        addSubview(nameTextField)
        addSubview(studentPhoneNumTextField)
        addSubview(parentPhoneNumTextField)
        addSubview(addressTextField)
        addSubview(memoTextView)
        addSubview(addScheduleButton)
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
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.height.equalTo(60)
        }
        
        addScheduleButton.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(45)
            make.size.equalTo(CGSize(width: 80, height: 28))
        }
    }
}
