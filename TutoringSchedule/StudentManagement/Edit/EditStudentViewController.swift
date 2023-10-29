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

        let saveItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        saveItem.width = 100
        saveItem.tintColor = .signatureColor
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
        let name = (mainView.nameTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        let studentPhoneNum = (mainView.studentPhoneNumTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        let parentPhoneNum = (mainView.parentPhoneNumTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        let address = (mainView.addressTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        let memo = (mainView.memoTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        
        
        guard !name.isEmpty else {
            mainView.nameTextField.text = nil
            mainView.nameTextField.becomeFirstResponder()
            
            let description = AlertMessageType.missingName.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return //필수체크
        }
               
        func isInt(text: String) -> Bool {
            return Int(text) ?? -1 != -1 ? true : false
        }

        if !studentPhoneNum.isEmpty {
            guard isInt(text: studentPhoneNum) else {
                mainView.studentPhoneNumTextField.becomeFirstResponder()
                let description = AlertMessageType.invalidNumberFormat.description
                UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
                return
            }
        }
        
        if !parentPhoneNum.isEmpty {
            guard isInt(text: studentPhoneNum) else {
                mainView.studentPhoneNumTextField.becomeFirstResponder()
                let description = AlertMessageType.invalidNumberFormat.description
                UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
                return
            }
        }
                
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty, let text = textField.text else { return true }
        
        //모아쓰기가 아닌 방식(숫자, 영어 등..)
        if let textInputMode = textField.textInputMode, textInputMode.primaryLanguage == "en-US"{
            if text.count > 19 {
                return returnAndSendAlert()
            }
        } else {
            if text.count > 20 {
                textField.text?.removeLast()
                return returnAndSendAlert()
            }
        }

       return true
    }
    
    func returnAndSendAlert() -> Bool {
        let description = AlertMessageType.characterLimit.description
        UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
        return false
    }
}
 
