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
        navigationItem.title = "studentEditViewTitle".localized

        mainView.saveButton.button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        mainView.addressTextField.textField.addTarget(self, action: #selector(didTapView), for: .editingDidEndOnExit)

        mainView.nameTextField.textField.delegate = self
        mainView.studentPhoneNumTextField.textField.delegate = self
        mainView.parentPhoneNumTextField.textField.delegate = self
        mainView.addressTextField.textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nameTextField.textField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    private func dataSetting(_ data: StudentTable) {
        mainView.nameTextField.textField.text = data.name
        mainView.studentPhoneNumTextField.textField.text = data.studentPhoneNum
        mainView.parentPhoneNumTextField.textField.text = data.parentPhoneNum
        mainView.addressTextField.textField.text = data.address
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        let name = (mainView.nameTextField.textField.text ?? "").trimmingCharacters(in: .whitespaces)
        let studentPhoneNum = (mainView.studentPhoneNumTextField.textField.text ?? "").trimmingCharacters(in: .whitespaces)
        let parentPhoneNum = (mainView.parentPhoneNumTextField.textField.text ?? "").trimmingCharacters(in: .whitespaces)
        let address = (mainView.addressTextField.textField.text ?? "").trimmingCharacters(in: .whitespaces)

        guard !name.isEmpty else {
            mainView.nameTextField.textField.text = nil
            mainView.nameTextField.becomeFirstResponder()
            let description = AlertMessageType.missingName.description
            view.makeToast(description.message, duration: 1.5, position: .top, style: CustomToast.setting())
            
            return //필수체크
        }
               
        func isInt(text: String) -> Bool {
            let intArray = text.map { Int(String($0)) }
            return (intArray as? [Int]) != nil
        }

        if !studentPhoneNum.isEmpty {
            guard isInt(text: studentPhoneNum) else {
                mainView.studentPhoneNumTextField.becomeFirstResponder()
                let description = AlertMessageType.invalidNumberFormat.description
                view.makeToast(description.message, duration: 1.5, position: .top)

                return
            }
        }
        
        if !parentPhoneNum.isEmpty {
            guard isInt(text: parentPhoneNum) else {
                mainView.parentPhoneNumTextField.becomeFirstResponder()
                let description = AlertMessageType.invalidNumberFormat.description
                view.makeToast(description.message, duration: 1.5, position: .top)
                return
            }
        }
                
        let newData = StudentTable(name: name, studentPhoneNum: studentPhoneNum, parentPhoneNum: parentPhoneNum, address: address)
        
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
        guard !string.isEmpty, var text = textField.text else { return true }
        text = text + string
        
        //모아쓰기가 아닌 방식(숫자, 영어 등..)
        if let textInputMode = textField.textInputMode, textInputMode.primaryLanguage == "en-US"{
            if text.count > 20 {
                return returnAndSendAlert()
            }
        } else {
            if text.count > 21 {
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
 
