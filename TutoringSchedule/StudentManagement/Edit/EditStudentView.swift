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
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var nameTextField = {
        let view = UITextField().hoshi(title: "* \("placeOfName".localized)")
        view.tag = 0
        view.returnKeyType = .continue
        return view
    }()
    
    lazy var studentPhoneNumTextField = {
        let view = UITextField().hoshi(title: "placeOfStudentPhoneNum".localized)
        view.tag = 1
        view.keyboardType = .numberPad
        return view
    }()
 
    lazy var parentPhoneNumTextField = {
        let view = UITextField().hoshi(title: "placeOfParentPhoneNum".localized)
        view.tag = 2
        view.keyboardType = .numberPad
        return view
    }()
    
    lazy var addressTextField = {
        let view = UITextField().hoshi(title: "placeOfAddress".localized)
        view.tag = 3
        view.returnKeyType = .continue
        return view
    }()
    
    lazy var memoTextField = {
        let view = UITextField().hoshi(title: "placeOfMemo".localized)
        view.returnKeyType = .done
        view.tag = 4
        return view
    }()

    override func setConfigure() {
        addSubview(lineView)
        addSubview(nameTextField)
        addSubview(studentPhoneNumTextField)
        addSubview(parentPhoneNumTextField)
        addSubview(addressTextField)
        addSubview(memoTextField)
    }
    
    override func setConstraint() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(0.7)
        }
        
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
