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
        let view = UITextField().hoshi(title: "* 수업명")
        view.tag = 0
        view.returnKeyType = .continue
        view.delegate = self
        return view
    }()
    
    lazy var tutoringPlaceTextField = {
        let view = UITextField().hoshi(title: "수업 장소")
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
        view.locale = Locale(identifier: "ko-KR")
        return view
    }()
    
    let endDatePicker = {
       let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.backgroundColor = .white
        view.locale = Locale(identifier: "ko-KR")
        return view
    }()
    
    lazy var startDateTextField = {
        let view = UITextField().hoshi(title: "시작일")
        view.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: Date())
        view.tag = 1001
        view.delegate = self
        view.tintColor = .clear
        view.inputView = startDatePicker
        return view
    }()
    
    lazy var endDateTextField = {
        let view = UITextField().hoshi(title: "종료일")
        view.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: Date())
        view.tag = 1002
        view.delegate = self
        view.tintColor = .clear
        view.inputView = endDatePicker
        return view
    }()
    
    let dayTitleLabel = {
        let view = UILabel()
        view.text = "* 요일 선택"
        view.textColor = .darkGray
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let sunButton = {
        let view = UIButton().days(title: "일")
        view.tag = Days.sun.rawValue
        return view
    }()
    
    let monButton = {
        let view = UIButton().days(title: "월")
        view.tag = Days.mon.rawValue
        return view
    }()
    
    let tueButton = {
        let view = UIButton().days(title: "화")
        view.tag = Days.tue.rawValue
        return view
    }()
    
    let wedButton = {
        let view = UIButton().days(title: "수")
        view.tag = Days.wed.rawValue
        return view
    }()
    
    let thuButton = {
        let view = UIButton().days(title: "목")
        view.tag = Days.thu.rawValue
        return view
    }()
    
    let friButton = {
        let view = UIButton().days(title: "금")
        view.tag = Days.fri.rawValue
        return view
    }()
    
    let satButton = {
        let view = UIButton().days(title: "토")
        view.tag = Days.sat.rawValue
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
        view.text = "학생 선택"
        view.textColor = .darkGray
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let studentButton = {
        let view = UIButton().days(title: " 데이터 가져오기 ")
        return view
    }()
    
    let scrollView = UIScrollView()

    override func setConfigure() {
        
        [lineView, classNameTextField, tutoringPlaceTextField, startDateTextField, endDateTextField, stackView, dayTitleLabel, studentTitleLabel, studentButton, scrollView].forEach {
            addSubview($0)
        }
        
        [sunButton, monButton, tueButton, wedButton, thuButton, friButton, satButton] .forEach {
            stackView.addArrangedSubview($0)
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
            return false // 입력 불가
        }
        
        return true
    }
}
