//
//  AddScheduleViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import SnapKit

class AddScheduleViewController: UIViewController, SendStateDelegate, UITextFieldDelegate{
    
    let realmModel = RealmModel.shared
    
    var days: [weekTime] = []
    var studentArray: [String] = []
    var tapButton: UIButton?
    
    var delegate: SaveSucsessDelegate?
    
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
        view.text = dateFormat(date: Date())
        view.delegate = self
        view.tintColor = .clear
        return view
    }()
    
    lazy var endDateTextField = {
        let view = UITextField().hoshi(title: "종료일")
        view.text = dateFormat(date: Date())
        view.delegate = self
        view.tintColor = .clear
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        navigationItem.rightBarButtonItem = addItem
        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker
        
        setConfigure()
        setConstraint()
    }
    
    // 값이 변할 때 마다 동작
    @objc func startDateChange(_ sender: UIDatePicker) {
        startDateTextField.text = dateFormat(date: sender.date)
        view.endEditing(true)
    }
    
    @objc func endDateChange(_ sender: UIDatePicker) {
        endDateTextField.text = dateFormat(date: sender.date)
        view.endEditing(true)
    }

    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
    
    @objc func saveButtonTapped() {
        
//        let name = nameTextField.text!
//        let studentPhoneNum = studentPhoneNumTextField.text! //번호 -, 공백 빼고 숫자로만 받을 수 있도록
//        let parentPhoneNum = parentPhoneNumTextField.text! //번호 -, 공백 빼고 숫자로만 받을 수 있도록
//        let address = addressTextField.text!
//        let memo = memoTextView.text!
        
        let className = classNameTextField.text ?? ""
        let tutoringPlace = tutoringPlaceTextField.text ?? ""
        
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
    
    func setConfigure() {
        view.addSubview(titleLabel)
        view.addSubview(classNameTextField)
        view.addSubview(tutoringPlaceTextField)
        view.addSubview(startDateTextField)
        view.addSubview(endDateTextField)
        view.addSubview(stackView)
        view.addSubview(dayTitleLabel)
        view.addSubview(studentTitleLabel)
        view.addSubview(studentButton)
        view.addSubview(scrollView)
        
        [sunButton, monButton, tueButton, wedButton, thuButton, friButton, satButton] .forEach({ button in
            self.stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
        })
        
        studentButton.addTarget(self, action: #selector(studentDataButton), for: .touchUpInside)
        startDatePicker.addTarget(self, action: #selector(startDateChange), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(endDateChange), for: .valueChanged)
    }
    
    func setStudent() {

            scrollView.subviews.forEach({ $0.removeFromSuperview() })

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

                scrollView.addSubview(button)
                scrollView.contentSize.width = 80 * CGFloat(i + 1)
            }
        }
    
    @objc func studentButtonTapped(_ sender: UIButton) {
        studentArray.remove(at: sender.tag)
        setStudent()
    }
    
    @objc func studentDataButton() {
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
    
    @objc func dayButtonTapped(_ sender: UIButton) {
        
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
    
    func saveData(startTime: Date, endTime: Date) {
        
        guard let tapButton else { return }
        
        //이미 있으면 지우고 다시 생성
        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
            days.remove(at: index)
        }
        
        days.append(weekTime(week: tapButton.tag, startTime: startTime, endTime: endTime))
        tapButton.backgroundColor = .darkGray
        tapButton.setTitleColor(.white, for: .normal)
        
        print("저장 데이터 확인", days)
    }
    
    func deleteData() {
        
        guard let tapButton else { return }
        
        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
            days.remove(at: index)
        }
        
        tapButton.backgroundColor = .white
        tapButton.setTitleColor(.black, for: .normal)
        
        print("삭제 데이터 확인", days)
    }
    
    func setConstraint() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalTo(view).inset(24)
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
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
            make.height.equalTo(60)
            make.left.equalTo(view).inset(24)
        }
        
        endDateTextField.snp.makeConstraints { make in
            make.top.equalTo(tutoringPlaceTextField.snp.bottom).offset(16)
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
            make.height.equalTo(60)
            make.right.equalTo(view).inset(24)
        }
        
        dayTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(endDateTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(view).inset(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(dayTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view).inset(24)
        }
        
        studentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.left.equalTo(view).offset(24)
        }
        
        studentButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.right.equalTo(view).inset(24)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(studentTitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view).offset(24)
            make.height.equalTo(90)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return false // 입력 불가
    }
}
