//
//  AddScheduleViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit

class AddScheduleViewController: UIViewController, SendStateDelegate{
    
    private let mainView = AddScheduleView()
    private let realmModel = RealmModel.shared
    
    private var days: [weekTime] = []
    private var studentArray: [String] = []
    private var tapButton: UIButton?
    
    var delegate: SaveSucsessDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        navigationItem.rightBarButtonItem = addItem
        
        setConfigure()
    }
    
    private func setConfigure() {
        mainView.studentButton.addTarget(self, action: #selector(studentDataButton), for: .touchUpInside)
        mainView.startDatePicker.addTarget(self, action: #selector(startDateChange), for: .valueChanged)
        mainView.endDatePicker.addTarget(self, action: #selector(endDateChange), for: .valueChanged)

        [mainView.sunButton, mainView.monButton, mainView.tueButton, mainView.wedButton, mainView.thuButton, mainView.friButton, mainView.satButton] .forEach({ button in
            button.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
        })
    }

    @objc private func startDateChange(_ sender: UIDatePicker) {
        mainView.startDateTextField.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: sender.date)
        view.endEditing(true)
    }
    
    @objc private func endDateChange(_ sender: UIDatePicker) {
        mainView.endDateTextField.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: sender.date)
        view.endEditing(true)
    }

    @objc private func saveButtonTapped() {
        
//        let name = nameTextField.text!
//        let studentPhoneNum = studentPhoneNumTextField.text! //번호 -, 공백 빼고 숫자로만 받을 수 있도록
//        let parentPhoneNum = parentPhoneNumTextField.text! //번호 -, 공백 빼고 숫자로만 받을 수 있도록
//        let address = addressTextField.text!
//        let memo = memoTextView.text!
        
//        let className = classNameTextField.text ?? ""
//        let tutoringPlace = tutoringPlaceTextField.text ?? ""
        
//        let data = classTable(className: className, tutoringPlace: tutoringPlace, studentPK: studentArray)
//        
//        
//        for i in days {
//            let data = ScheduleTable(classPK: <#T##String#>, day: i.week, startTime: i.startTime, endTime: i.endTime)
//            realmModel.create(data: data)
//        }
        
            //날짜 비교
        // [초기 변수 선언 실시]
//                   let a_string = "2022-11-09"
//                   let b_string = "2022-11-08"
//
//
//                   // [DateFormatter 선언 실시]
//                   let dateFormatter: DateFormatter = .init()
//                   dateFormatter.dateFormat = "yyyy-MM-dd" // [연도, 월, 일자]
//
//
//                   // [compare 사용해 두날짜 비교 수행 실시]
//                   var result = ""
//
//                   if let a_Date: Date = dateFormatter.date(from: a_string),
//                      let b_Date: Date = dateFormatter.date(from: b_string) {
//
//                       switch a_Date.compare(b_Date) {
//                       case .orderedSame:
//                           result = "A == B"
//                       case .orderedDescending:
//                           result = "A >> B"
//                       case .orderedAscending:
//                           result = "A << B"
//                       }
        
        delegate?.saveSucsess()
        navigationController?.popViewController(animated: true)
    }
    
    private func setStudent() {
        mainView.scrollView.subviews.forEach({ $0.removeFromSuperview() })

            for i in 0..<studentArray.count{

                let xPos = 80 * i
                let button = UIButton()
                button.layer.cornerRadius = 8
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.layer.borderWidth = 1
                button.setTitle(studentArray[i], for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 15)
                button.setTitleColor(UIColor.black, for: .normal)
                button.frame = CGRect(x: xPos, y: 0, width: 70, height: 30)
                button.addTarget(self, action: #selector(studentButtonTapped), for: .touchUpInside)
                button.tag = i

                mainView.scrollView.addSubview(button)
                mainView.scrollView.contentSize.width = 80 * CGFloat(i + 1)
            }
        }
    
    @objc private func studentButtonTapped(_ sender: UIButton) {
        studentArray.remove(at: sender.tag)
        setStudent()
    }
    
    @objc private func studentDataButton() {
        let vc = StudentManagementViewController()
        vc.mainView.tableView.allowsMultipleSelection = true
        vc.navigationItem.rightBarButtonItem?.isHidden = true

        if let sheet = vc.sheetPresentationController {

            sheet.detents = [.medium(), .custom(resolver: { _ in
                return 600
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }

        present(vc, animated: true)
        studentArray.append("1")
        studentArray.append("2")
        studentArray.append("3")
        setStudent()
    }
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        
        let vc = DatePickHalfView()
        vc.delegate = self
        vc.day = sender.tag
        let nav = UINavigationController(rootViewController: vc)

        if let sheet = nav.sheetPresentationController {
            
            // 3
            sheet.detents = [.custom(resolver: { _ in
                return 340
            })]
            
            sheet.preferredCornerRadius = 30
            
            
        }
        
        tapButton = sender
        present(nav, animated: true)
    }
    
    //SendStateDelegate
    func saveData(startTime: Date, endTime: Date) {
        guard let tapButton else { return }
        
        //이미 있으면 지우고 다시 생성
        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
            days.remove(at: index)
        }
        
        days.append(weekTime(week: tapButton.tag, startTime: startTime, endTime: endTime))
        tapButton.backgroundColor = .darkGray
        tapButton.setTitleColor(.white, for: .normal)
    }
    
    //SendStateDelegate
    func deleteData() {
        guard let tapButton else { return }
        
        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
            days.remove(at: index)
        }
        
        tapButton.backgroundColor = .white
        tapButton.setTitleColor(.black, for: .normal)
    }
}
