//
//  EditClassView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/08.
//

import UIKit

class EditClassView: BaseView {

    let lineView = {
       let view = UILabel()
        view.backgroundColor = .systemGray5
        return view
    }()

    lazy var classNameTextField = {
        let view = UITextField().hoshi(title: "* \("placeOfClassName".localized)")
        view.tag = 0
        view.returnKeyType = .continue
        view.delegate = self
        return view
    }()
    
    lazy var tutoringPlaceTextField = {
        let view = UITextField().hoshi(title: "placeOfTutoringPlace".localized)
        view.tag = 1
        view.returnKeyType = .done
        view.delegate = self
        return view
    }()
    
    let startDatePicker = {
       let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.backgroundColor = .white
        view.locale = Locale.current
        return view
    }()
    
    let endDatePicker = {
       let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.backgroundColor = .white
        view.locale = Locale.current
        return view
    }()
    
    lazy var startDateTextField = {
        let view = UITextField().hoshi(title: "placeOfStartDate".localized)
        view.text = Date.convertToString(format: "fullDateFormat".localized, date: Date())
        view.tag = 1001
        view.delegate = self
        view.tintColor = .clear
        view.inputView = startDatePicker
        return view
    }()
    
    lazy var endDateTextField = {
        let view = UITextField().hoshi(title: "placeOfEndDate".localized)
        view.text = Date.convertToString(format: "fullDateFormat".localized, date: Date())
        view.tag = 1002
        view.delegate = self
        view.tintColor = .clear
        view.inputView = endDatePicker
        return view
    }()
    
    let dayTitleLabel = {
        let view = UILabel()
        view.text = "* \("placeOfDay".localized)"
        view.textColor = .darkGray
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let sunButton = {
        let view = UIButton().days()
        view.tag = 0
        return view
    }()
    
    let monButton = {
        let view = UIButton().days()
        view.tag = 1
        return view
    }()
    
    let tueButton = {
        let view = UIButton().days()
        view.tag = 2
        return view
    }()
    
    let wedButton = {
        let view = UIButton().days()
        view.tag = 3
        return view
    }()
    
    let thuButton = {
        let view = UIButton().days()
        view.tag = 4
        return view
    }()
    
    let friButton = {
        let view = UIButton().days()
        view.tag = 5
        return view
    }()
    
    let satButton = {
        let view = UIButton().days()
        view.tag = 6
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sunButton, monButton, tueButton, wedButton, thuButton, friButton, satButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    let studentTitleLabel = {
        let view = UILabel()
        view.text = "studentTitleLabel".localized
        view.textColor = .darkGray
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let studentButton = {
        let view = UIButton().days()
        view.setTitle("studentButton".localized, for: .normal)
        return view
    }()
    
    let scrollView = UIScrollView()

    override func setConfigure() {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        for (index, item) in [sunButton, monButton, tueButton, wedButton, thuButton, friButton, satButton].enumerated() {
            item.setTitle(dateFormatter.shortWeekdaySymbols[index], for: .normal)
        }
        
        [lineView, classNameTextField, tutoringPlaceTextField, startDateTextField, endDateTextField, stackView, dayTitleLabel, studentTitleLabel, studentButton, scrollView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraint() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(0.7)
        }

        classNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        
        tutoringPlaceTextField.snp.makeConstraints { make in
            make.top.equalTo(classNameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
            
        startDateTextField.snp.makeConstraints { make in
            make.top.equalTo(tutoringPlaceTextField.snp.bottom).offset(16)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
            make.height.equalTo(60)
            make.left.equalTo(self).inset(24)
        }
        
        endDateTextField.snp.makeConstraints { make in
            make.top.equalTo(tutoringPlaceTextField.snp.bottom).offset(16)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
            make.height.equalTo(60)
            make.right.equalTo(self).inset(24)
        }
        
        dayTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(endDateTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(self).inset(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(dayTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self).inset(24)
        }
        
        studentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.left.equalTo(self).offset(24)
        }
        
        studentButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.right.equalTo(self).inset(24)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(studentTitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self).offset(24)
            make.height.equalTo(90)
        }
    }
}

extension EditClassView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = textField.superview?.viewWithTag(textField.tag + 1) {
            textField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag > 1000{
            return false // Date textField 입력 불가
        }
        
        return true
    }
}
