//
//  EditStudentViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/11.
//

import UIKit

class EditStudentViewController: UIViewController {
        
    var delegate: saveSucsessDelegate?

    private let mainView = EditStudentView()
    private let viewModel = EditStudentViewModel()
    
    init(editType: EditType<StudentTable>, delegate: saveSucsessDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        viewModel.state.bind { [weak self] eventType in
            guard let self else { return }
            
            if case .settingData(let data) = eventType {
                dataSetting(data)
            } else if case .saveData = eventType {
                delegate.saveSucsess()
                navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.editType = editType
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "studentEditViewTitle".localized
        
        let backItem = UIBarButtonItem(image: UIImage(systemName: "lessthan.circle.fill"), style: .plain, target: self, action: #selector(backButtonTapped))
        backItem.width = 70
        backItem.tintColor = .black
        navigationItem.leftBarButtonItem = backItem
        
        let saveItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        saveItem.width = 100
        saveItem.tintColor = .black
        navigationItem.rightBarButtonItem = saveItem

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        mainView.memoTextField.addTarget(self, action: #selector(didTapView), for: .editingDidEndOnExit)

        mainView.nameTextField.delegate = self
        mainView.studentPhoneNumTextField.delegate = self
        mainView.parentPhoneNumTextField.delegate = self
        mainView.addressTextField.delegate = self
        mainView.memoTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nameTextField.becomeFirstResponder()
    }

    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    private func dataSetting(_ data: StudentTable) {

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
            let description = AlertMessageType.missingName.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return //필수체크
        }
               
        var studentPhoneNum: String
        
        func isInt(text: String) -> Bool {
            return Int(text) ?? -1 != -1 ? true : false
        }
        
        if let studentPhoneNumText = mainView.studentPhoneNumTextField.text, !studentPhoneNumText.isEmpty{
            if isInt(text: studentPhoneNumText) {
                studentPhoneNum = studentPhoneNumText
            }else {
                mainView.studentPhoneNumTextField.becomeFirstResponder()
                let description = AlertMessageType.invalidNumberFormat.description
                UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
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
                let description = AlertMessageType.invalidNumberFormat.description
                UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
                return
            }
        }else {
            parentPhoneNum = ""
        }
        
        let address = mainView.addressTextField.text ?? ""
        let memo = mainView.memoTextField.text ?? ""
        
        let newData = StudentTable(name: name, studentPhoneNum: studentPhoneNum, parentPhoneNum: parentPhoneNum, address: address, memo: memo)
        
        errorHandling {
            try viewModel.saveData(newData: newData)
        }
    }
}

extension EditStudentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = textField.superview?.viewWithTag(textField.tag + 1) {
            textField.becomeFirstResponder()
        }
        
        return true
    }
}
