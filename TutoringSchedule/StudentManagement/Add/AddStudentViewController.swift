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

protocol SaveSucsessDelegate {
    func saveSucsess()
}

class AddStudentViewController: UIViewController {
    
    let mainView = AddStudentView()
    let realmModel = RealmModel.shared
    var delegate: SaveSucsessDelegate?
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "학생 등록"
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        navigationItem.rightBarButtonItem = addItem
        
        mainView.addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    @objc func addScheduleButtonTapped() {
        let vc = AddScheduleViewController()
        self.present(vc, animated: true)
    }
    
    
    @objc func saveButtonTapped() {
        //번호 -, 공백 빼고 숫자로만 받을 수 있도록
        let name = mainView.nameTextField.text ?? ""
        let studentPhoneNum = mainView.studentPhoneNumTextField.text ?? ""
        let parentPhoneNum = mainView.parentPhoneNumTextField.text ?? ""
        let address = mainView.addressTextField.text ?? ""
        let memo = mainView.memoTextView.text ?? ""
        
        let data = StudentTable(name: name, studentPhoneNum: studentPhoneNum, parentPhoneNum: parentPhoneNum, address: address, memo: memo)
        realmModel.create(data: data)
        delegate?.saveSucsess()
        navigationController?.popViewController(animated: true)
    }
}
