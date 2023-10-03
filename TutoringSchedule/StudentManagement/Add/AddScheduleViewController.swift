//
//  AddScheduleViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import SnapKit

class AddScheduleViewController: UIViewController {

    var timeByDay: TimebyDay?
    
    let titleLabel = {
        let view = UILabel()
        view.text = "일정 등록"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let subjectTextField = {
        let view = UITextField().hoshi(title: "과외명")
        return view
    }()
    
    let tutoringPlaceTextField = {
        let view = UITextField().hoshi(title: "과외 장소")
        return view
    }()
    
    let repeatTextField = {
        let view = UITextField()
        view.layer.borderWidth = 0.7
        view.keyboardType = .numberPad
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.textColor = .gray
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 13)
        view.text = "1"
        return view
    }()
    
    let repeatLabel = {
        let view = UILabel()
        view.text = "주 간격으로 반복"
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let sunButton = {
        let view = UIButton()
        view.setTitle("일", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let monButton = {
        let view = UIButton()
        view.setTitle("월", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let tueButton = {
        let view = UIButton()
        view.setTitle("화", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let wedButton = {
        let view = UIButton()
        view.setTitle("수", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let thuButton = {
        let view = UIButton()
        view.setTitle("목", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let friButton = {
        let view = UIButton()
        view.setTitle("금", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let satButton = {
        let view = UIButton()
        view.setTitle("토", for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .normal)
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        view.addSubview(titleLabel)
        view.addSubview(subjectTextField)
        view.addSubview(tutoringPlaceTextField)
        view.addSubview(repeatTextField)
        view.addSubview(repeatLabel)
        
        view.addSubview(sunButton)
        view.addSubview(monButton)
        view.addSubview(tueButton)
        view.addSubview(wedButton)
        view.addSubview(thuButton)
        view.addSubview(friButton)
        view.addSubview(satButton)
        sunButton.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
    }
    
    @objc func dayButtonTapped(_ sender: UIButton) {

        //pickerView 뷰 따로 만들어서 시작, 종료 받은 후 저장
        timeByDay?.sun = Time(start: (10,00), end: (12,00))

        let vc = picker()
           let nav = UINavigationController(rootViewController: vc)
           // 1
           nav.modalPresentationStyle = .pageSheet

           
           // 2
           if let sheet = nav.sheetPresentationController {

               // 3
               sheet.detents = [.custom(resolver: { _ in
                   return 340
               })]
               
               sheet.preferredCornerRadius = 30


           }
        
        
        let ok = UIBarButtonItem(title: "완료", primaryAction: .init(handler: { _ in
            if let sheet = nav.sheetPresentationController {
                sender.backgroundColor = .darkGray
                sender.setTitleColor(.white, for: .normal)
                self.dismiss(animated: true)
            }
        }))

        let cancel = UIBarButtonItem(title: "삭제", image: nil, primaryAction: .init(handler: { _ in
            if let sheet = nav.sheetPresentationController {
                sender.backgroundColor = .white
                sender.setTitleColor(.darkGray, for: .normal)
                self.dismiss(animated: true)
            }
        }))

        vc.navigationItem.leftBarButtonItem = cancel
        vc.navigationItem.rightBarButtonItem = ok
        
           // 4
           present(nav, animated: true, completion: nil)
    }

    func setConstraint() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        subjectTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        
        tutoringPlaceTextField.snp.makeConstraints { make in
            make.top.equalTo(subjectTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        
        repeatTextField.snp.makeConstraints { make in
            make.top.equalTo(tutoringPlaceTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.size.equalTo(30)
        }
        
        repeatLabel.snp.makeConstraints { make in
            make.top.equalTo(tutoringPlaceTextField.snp.bottom).offset(8)
            make.left.equalTo(repeatTextField.snp.right).offset(4)
            make.height.equalTo(repeatTextField.snp.height)
        }
        
        sunButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        monButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalTo(sunButton.snp.right).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        tueButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalTo(monButton.snp.right).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        wedButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalTo(tueButton.snp.right).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        thuButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalTo(wedButton.snp.right).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        friButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalTo(thuButton.snp.right).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        satButton.snp.makeConstraints { make in
            make.top.equalTo(repeatLabel.snp.bottom).offset(8)
            make.left.equalTo(friButton.snp.right).offset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
    }
}
