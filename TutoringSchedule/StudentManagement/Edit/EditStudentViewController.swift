//
//  EditStudentViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/11.
//

import UIKit

class EditStudentViewController: UIViewController {
    
    //VC 기본 세팅
    var editType: EditType?
    var delegate: saveSucsessDelegate?
    
    //editType .update시 기본 세팅
    var data: StudentTable?
    
    private let mainView = EditStudentView()
    private let realmRepository = RealmRepository()
    
    convenience init(editType: EditType, delegate: saveSucsessDelegate) {
        self.init()
        self.editType = editType
        self.delegate = delegate
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "학생정보"
        
        let backItem = UIBarButtonItem(image: UIImage(systemName: "lessthan.circle.fill"), style: .plain, target: self, action: #selector(backButtonTapped))
        backItem.width = 70
        backItem.tintColor = .black
        navigationItem.leftBarButtonItem = backItem
        
        let saveItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        saveItem.width = 100
        saveItem.tintColor = .black
        navigationItem.rightBarButtonItem = saveItem

        mainView.memoTextField.addTarget(self, action: #selector(didTapView), for: .editingDidEndOnExit)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        dataSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nameTextField.becomeFirstResponder()
    }

    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    private func dataSetting() {
        guard let data else { return }
        
        mainView.nameTextField.text = data.name
        mainView.studentPhoneNumTextField.text = data.studentPhoneNum
        mainView.parentPhoneNumTextField.text = data.parentPhoneNum
        mainView.addressTextField.text = data.address
        mainView.memoTextField.text = data.memo
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {

        guard let name = mainView.nameTextField.text, !name.isEmpty else {
            let alert = UIAlertController().customMessageAlert(message: "이름 입력은 필수입니다")
            present(alert, animated: true)
            return //필수체크
        }
               
        var studentPhoneNum: String
        
        if let studentPhoneNumText = mainView.studentPhoneNumTextField.text, !studentPhoneNumText.isEmpty{
            if isInt(text: studentPhoneNumText) {
                studentPhoneNum = studentPhoneNumText
            }else {
                mainView.studentPhoneNumTextField.becomeFirstResponder()
                let alert = UIAlertController().customMessageAlert(message: "번호는 숫자만 입력해주세요")
                present(alert, animated: true)
                return
            }
        }else {
            studentPhoneNum = ""
        }
         
        var parentPhoneNum: String
        
        if let parentPhoneNumText = mainView.parentPhoneNumTextField.text, !parentPhoneNumText.isEmpty {
            if isInt(text: parentPhoneNumText) {
                parentPhoneNum = parentPhoneNumText
            }else {
                mainView.parentPhoneNumTextField.becomeFirstResponder()
                let alert = UIAlertController().customMessageAlert(message: "번호는 숫자만 입력해주세요")
                present(alert, animated: true)
                return
            }
        }else {
            parentPhoneNum = ""
        }
        
        let address = mainView.addressTextField.text ?? ""
        let memo = mainView.memoTextField.text ?? ""
        
        let newData = StudentTable(name: name, studentPhoneNum: studentPhoneNum, parentPhoneNum: parentPhoneNum, address: address, memo: memo)
        
        switch editType {
        case .create: realmRepository.create(data: newData)
        case .update:
            guard let data else { return }
            
            let originId = data._id
            newData._id = originId
            realmRepository.update(data: newData)
        case .none:
            let alert = UIAlertController().customMessageAlert(message: "오류가 발생했습니다.\n다시 실행해주세요")
            present(alert, animated: true)
            return
        }
    
        delegate?.saveSucsess()
        navigationController?.popViewController(animated: true)
    }
    
    func isInt(text: String) -> Bool {
        return Int(text) ?? -1 != -1 ? true : false
    }
}

