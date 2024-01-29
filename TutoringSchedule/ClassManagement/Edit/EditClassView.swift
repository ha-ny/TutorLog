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
        view.backgroundColor = .bdLine
        return view
    }()

    let classNameTextField = {
        let view = TextFieldView(title: "* \("placeOfClassName".localized)", placeholder: "placeOfClassName".localized)
        view.textField.tag = 0
        view.textField.returnKeyType = .next
        
        let labelText = "\("placeOfClassName".localized) *"
        let attributedString = NSMutableAttributedString(string: labelText)

        if let range = labelText.range(of: "*") {
            let nsRange = NSRange(range, in: labelText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.bdRed, range: nsRange)
        }
        view.label.attributedText = attributedString
        return view
    }()
    
    let tutoringPlaceTextField = {
        let view = TextFieldView(title: "placeOfTutoringPlace".localized, placeholder: "placeOfTutoringPlace".localized)
        view.textField.tag = 1
        view.textField.returnKeyType = .done
        return view
    }()

    private let startDateLabel = {
        let view = UILabel()
        view.text = "placeOfStartDate".localized
        view.font = .customFont(sytle: .bold, ofSize: 14)
        view.textColor = .bdBlack
        return view
    }()
    
    lazy var startDateButton = {
        let view = UIButton()
        view.titleLabel?.font = .customFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.setTitle(Date.convertToString(format: "fullDateFormat".localized, date: Date()), for: .normal)
        view.setTitleColor(.bdBlack, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.bdLine.cgColor
        return view
    }()
    
    private let endDateLabel = {
        let view = UILabel()
        view.text = "placeOfEndDate".localized
        view.font = .customFont(sytle: .bold, ofSize: 14)
        view.textColor = .bdBlack
        return view
    }()
    
    lazy var endDateButton = {
        let view = UIButton()
        view.titleLabel?.font = .customFont(ofSize: 14)
        view.layer.cornerRadius = 8
        view.setTitle(Date.convertToString(format: "fullDateFormat".localized, date: Date()), for: .normal)
        view.setTitleColor(.bdBlack, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.bdLine.cgColor
        return view
    }()

    let dayTitleLabel = {
        let view = UILabel()
        view.textColor = .bdBlack
        view.font = .customFont(sytle: .bold, ofSize: 15)
        
        let labelText = "\("placeOfDay".localized) *"
        let attributedString = NSMutableAttributedString(string: labelText)

        if let range = labelText.range(of: "*") {
            let nsRange = NSRange(range, in: labelText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.bdRed, range: nsRange)
        }
        view.attributedText = attributedString
        
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
        view.textColor = .bdBlack
        view.font = .customFont(sytle: .bold, ofSize: 15)
        return view
    }()
    
    let studentButton = {
        let view = UIButton()
        view.setImage(.edit, for: .normal)
        view.setImage(.edit, for: .highlighted)
        view.contentMode = .scaleAspectFit
        return view
    }()

    let scrollView = UIScrollView()
    let saveButton = TextButtonView(title: "저장")
    
    let lineView1 = {
       let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()
    
    let lineView2 = {
       let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()
    
    let lineView3 = {
       let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()

    override func setConfigure() {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        for (index, item) in [sunButton, monButton, tueButton, wedButton, thuButton, friButton, satButton].enumerated() {
            item.setTitle(dateFormatter.shortWeekdaySymbols[index], for: .normal)
            item.snp.makeConstraints {
                $0.height.equalTo(item.snp.width)
            }
        }
        
        [lineView, classNameTextField, tutoringPlaceTextField, startDateLabel, startDateButton, endDateLabel, endDateButton, stackView, dayTitleLabel, studentTitleLabel, studentButton, scrollView, saveButton, lineView1, lineView2, lineView3].forEach {
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
            make.top.equalTo(lineView.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        tutoringPlaceTextField.snp.makeConstraints { make in
            make.top.equalTo(classNameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }

        lineView1.snp.makeConstraints {
            $0.top.equalTo(tutoringPlaceTextField.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        startDateLabel.snp.makeConstraints {
            $0.top.equalTo(lineView1.snp.bottom).offset(12)
            $0.width.equalTo(self.snp.width).multipliedBy(0.4)
            $0.left.equalTo(self).inset(24)
        }
        
        startDateButton.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(4)
            $0.width.equalTo(self.snp.width).multipliedBy(0.4)
            $0.leading.equalTo(self).inset(24)
            $0.height.equalTo(44)
        }
        
        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.top)
            $0.width.equalTo(self.snp.width).multipliedBy(0.4)
            $0.right.equalTo(self).inset(24)
        }
        
        endDateButton.snp.makeConstraints {
            $0.top.equalTo(endDateLabel.snp.bottom).offset(4)
            $0.width.equalTo(self.snp.width).multipliedBy(0.4)
            $0.trailing.equalTo(self).inset(24)
            $0.height.equalTo(44)
        }
        
        lineView2.snp.makeConstraints {
            $0.top.equalTo(endDateButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        dayTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(self).inset(24)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(dayTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self).inset(24)
        }
        
        lineView3.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        studentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(12)
            make.left.equalTo(self).offset(24)
        }
        
        studentButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.right.equalTo(self).inset(24)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(studentTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(self).offset(24)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
