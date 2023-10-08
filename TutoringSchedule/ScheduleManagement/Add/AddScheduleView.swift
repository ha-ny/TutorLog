//
//  AddScheduleView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/08.
//

import UIKit

class AddScheduleView: BaseView {

    let titleLabel = {
        let view = UILabel()
        view.text = "일정 등록"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let classNameTextField = {
        let view = UITextField().hoshi(title: "*과외명")
        return view
    }()
    
    let tutoringPlaceTextField = {
        let view = UITextField().hoshi(title: "과외 장소")
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
        view.delegate = self
        view.tintColor = .clear
        view.inputView = startDatePicker
        return view
    }()
    
    lazy var endDateTextField = {
        let view = UITextField().hoshi(title: "종료일")
        view.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: Date())
        view.delegate = self
        view.tintColor = .clear
        view.inputView = endDatePicker
        return view
    }()
    
    let dayTitleLabel = {
        let view = UILabel()
        view.text = "*요일 선택"
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
        addSubview(titleLabel)
        addSubview(classNameTextField)
        addSubview(tutoringPlaceTextField)
        addSubview(startDateTextField)
        addSubview(endDateTextField)
        addSubview(stackView)
        addSubview(dayTitleLabel)
        addSubview(studentTitleLabel)
        addSubview(studentButton)
        addSubview(scrollView)
        
        [sunButton, monButton, tueButton, wedButton, thuButton, friButton, satButton] .forEach({ button in
            self.stackView.addArrangedSubview(button)
        })
    }
    
    override func setConstraint() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalTo(self).inset(24)
        }
        
        classNameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
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

extension AddScheduleView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return false // 입력 불가
    }
}
