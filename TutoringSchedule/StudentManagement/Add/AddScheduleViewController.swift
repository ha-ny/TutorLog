//
//  AddScheduleViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import SnapKit

class AddScheduleViewController: UIViewController {
    
    let closeButton = {
        let view = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration)
        view.setImage(image, for: .normal)
        view.tintColor = .systemGray5
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.text = "일정 등록"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let subjectLabel = {
        let view = UILabel()
        view.text = "과목"
        return view
    }()
    
    let tutoringPlace = {
        let view = UITextField().hoshi(title: "수업 장소")
        return view
    }()
    
    let repeatTextField = {
        let view = UITextField()
        view.keyboardType = .numberPad
        return view
    }()
    
    let repeatLabel = {
        let view = UILabel()
        view.text = "주 간격으로 반복"
        return view
    }()
    
    let sunButton = {
        let view = UIButton()
        view.setTitle("일", for: .normal)
        return view
    }()
    
    let monButton = {
        let view = UIButton()
        view.setTitle("월", for: .normal)
        return view
    }()
    
    let tueButton = {
        let view = UIButton()
        view.setTitle("화", for: .normal)
        return view
    }()
    
    let wedButton = {
        let view = UIButton()
        view.setTitle("수", for: .normal)
        return view
    }()
    
    let thuButton = {
        let view = UIButton()
        view.setTitle("목", for: .normal)
        return view
    }()
    
    let friButton = {
        let view = UIButton()
        view.setTitle("금", for: .normal)
        return view
    }()
    
    let satButton = {
        let view = UIButton()
        view.setTitle("토", for: .normal)
        return view
    }()
    
    let tableView = {
       let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(subjectLabel)
        view.addSubview(tutoringPlace)
        view.addSubview(repeatTextField)
        view.addSubview(repeatLabel)
        view.addSubview(sunButton)
        view.addSubview(monButton)
        view.addSubview(tueButton)
        view.addSubview(wedButton)
        view.addSubview(thuButton)
        view.addSubview(friButton)
        view.addSubview(satButton)
        view.addSubview(tableView)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    func setConstraint() {
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
//        subjectLabel.snp.makeConstraints { make in
//            make.
//        }
//        view.addSubview(subjectLabel)
//        view.addSubview(tutoringPlace)
//        view.addSubview(repeatTextField)
//        view.addSubview(repeatLabel)
//        view.addSubview(sunButton)
//        view.addSubview(monButton)
//        view.addSubview(tueButton)
//        view.addSubview(wedButton)
//        view.addSubview(thuButton)
//        view.addSubview(friButton)
//        view.addSubview(satButton)
//        view.addSubview(tableView)
    }
}
