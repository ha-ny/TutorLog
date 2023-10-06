//
//  AddStudentViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import RealmSwift
import SnapKit
import TextFieldEffects

/////Users/hany/Library/Developer/CoreSimulator/Devices/502D4491-E960-4248-8FEE-E1BAE9CC425A/data/Containers/Data/Application/005E0E6F-8335-4EC1-9189-2095C2B5745A/Documents/default.realm

class AddStudentViewController: UIViewController {
    
    let realmFile = RealmFile()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "학생 등록"
        view.backgroundColor = .backgroundColor
        let addItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        navigationItem.rightBarButtonItem = addItem
        
        setConfigure()
        setConstraint()
    }
    
    @objc func saveButtonTapped() {
        
        let name = nameTextField.text!
        let studentPhoneNum = studentPhoneNumTextField.text! //번호 -, 공백 빼고 숫자로만 받을 수 있도록
        let parentPhoneNum = parentPhoneNumTextField.text! //번호 -, 공백 빼고 숫자로만 받을 수 있도록
        let address = addressTextField.text!
        let memo = memoTextView.text!
        
        let data = StudentTable(name: name, studentPhoneNum: studentPhoneNum, parentPhoneNum: parentPhoneNum, address: address, memo: memo)
        realmFile.createData(data: data)
        navigationController?.popViewController(animated: true)
    }
    
    func setConfigure() {
        view.addSubview(nameTextField)
        view.addSubview(studentPhoneNumTextField)
        view.addSubview(parentPhoneNumTextField)
        view.addSubview(addressTextField)
        view.addSubview(memoTextView)
        view.addSubview(addScheduleButton)
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    @objc func addScheduleButtonTapped() {
        let vc = AddScheduleViewController()
        present(vc, animated: true)
    }
    
    func setConstraint() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
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
