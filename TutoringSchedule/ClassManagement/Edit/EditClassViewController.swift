////
////  EditClassViewController.swift
////  TutoringSchedule
////
////  Created by 김하은 on 2023/09/30.
////
//
//import UIKit
//
//class EditClassViewController: UIViewController {
//   
//    var delegate: saveSucsessDelegate?
//    
//    //editType .update시 기본 세팅
//    var data: ClassTable?
//    
//    private let mainView = EditClassView()
//    private let viewModel = EditClassViewModel()
//    
//    private var days: [weekTime] = []
//    private var studentArray = [String]()
//    private var tapButton: UIButton?
//    
//    init(editType: EditType<ClassTable>, delegate: saveSucsessDelegate) {
//        super.init(nibName: nil, bundle: nil)
//        
//        viewModel.state.bind { [weak self] eventType in
//            guard let self else { return }
//            
//            if case .settingData(let data) = eventType {
//                dataSetting(data)
//            } else if case .saveData = eventType {
//                delegate.saveSucsess()
//                NotificationCenter.default.post(name: .calendarReload, object: nil)
//                navigationController?.popViewController(animated: true)
//            } else if case .settingDayButton(let schedule) = eventType {
//                
//                let buttons = [mainView.sunButton, mainView.monButton, mainView.tueButton, mainView.wedButton, mainView.thuButton, mainView.friButton, mainView.satButton]
//                
//                for data in schedule {
//                    tapButton = buttons[data.day]
//                    saveData(startTime: data.startTime, endTime: data.endTime)
//                }
//            }
//        }
//        
//        viewModel.editType = editType
//        self.delegate = delegate
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func loadView() {
//        super.loadView()
//        self.view = mainView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        navigationItem.title = "scheduleEditViewTitle".localized
//        
//        let addItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
//        addItem.width = 100
//        addItem.tintColor = .signatureColor
//        navigationItem.rightBarButtonItem = addItem
//        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
//        tapGestureRecognizer.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGestureRecognizer)
//        
//        setConfigure()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        mainView.classNameTextField.becomeFirstResponder()
//    }
//    
//    private func setConfigure() {
//        mainView.tutoringPlaceTextField.addTarget(self, action: #selector(didTapView), for: .editingDidEndOnExit)
//        mainView.studentButton.addTarget(self, action: #selector(studentDataButton), for: .touchUpInside)
//        mainView.startDatePicker.addTarget(self, action: #selector(startDateChange), for: .valueChanged)
//        mainView.endDatePicker.addTarget(self, action: #selector(endDateChange), for: .valueChanged)
//        
//        [mainView.sunButton, mainView.monButton, mainView.tueButton, mainView.wedButton, mainView.thuButton, mainView.friButton, mainView.satButton] .forEach {
//            $0.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
//        }
//        
//        [mainView.classNameTextField, mainView.tutoringPlaceTextField, mainView.startDateTextField, mainView.endDateTextField] .forEach {
//            $0.delegate = self
//        }
//    }
//    
//    @objc private func studentDataButton() {
//        let vc = StudentListViewController()
//        vc.delegate = self
//        vc.studentData = studentArray
//        
//        let nav = UINavigationController(rootViewController: vc)
////        if let sheet = nav.sheetPresentationController {
////            sheet.detents = [.medium(), .large()]
////            sheet.prefersGrabberVisible = true
////        }
//        
//        present(nav, animated: true)
//    }
//    
//    @objc private func dayButtonTapped(_ sender: UIButton) {
//        
//        var data: weekTime?
//        
//        if let index = days.firstIndex(where: { $0.week == sender.tag }){
//            data = days[index]
//        }
//        
//        let vc = DatePickHalfView(day: sender.tag, startTime: data?.startTime, endTime: data?.endTime, delegate: self)
//        
//        let nav = UINavigationController(rootViewController: vc)
////        if let sheet = nav.sheetPresentationController {
////            sheet.detents = [.medium()]
////            sheet.preferredCornerRadius = 30
////        }
//        tapButton = sender
//        present(nav, animated: true)
//    }
//    
//    @objc private func didTapView() {
//        view.endEditing(true)
//    }
//    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    private func dataSetting(_ data: ClassTable) {
//        mainView.classNameTextField.text = data.className
//        mainView.tutoringPlaceTextField.text = data.tutoringPlace
//        mainView.startDatePicker.date = data.startDate
//        mainView.endDatePicker.date = data.endDate
//        
//        let startDate = Date.convertToString(format: "fullDateFormat".localized, date: data.startDate)
//        let endDate = Date.convertToString(format: "fullDateFormat".localized, date: data.endDate)
//        mainView.startDateTextField.text = startDate
//        mainView.endDateTextField.text = endDate
//
//        studentArray = Array(data.studentPK)
//        setStudent()
//        
//        errorHandling {
//            try viewModel.settingData(classData: data)
//        }
//    }
//    
//    @objc private func startDateChange(_ sender: UIDatePicker) {
//        mainView.startDateTextField.text = Date.convertToString(format: "fullDateFormat".localized, date: sender.date)
//        mainView.endDatePicker.date = sender.date
//        mainView.endDateTextField.text = mainView.startDateTextField.text
//        view.endEditing(true)
//    }
//    
//    @objc private func endDateChange(_ sender: UIDatePicker) {
//        
//        guard Int(sender.date.timeIntervalSince(mainView.startDatePicker.date)) >= 0 else {
//            
//            let description = AlertMessageType.startDateAfterEndDate.description
//            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
//            return
//        }
//        
//        mainView.endDateTextField.text = Date.convertToString(format: "fullDateFormat".localized, date: sender.date)
//        view.endEditing(true)
//    }
//    
//    @objc private func saveButtonTapped() {
//        let className = (mainView.classNameTextField.text ?? "").trimmingCharacters(in: .whitespaces)
//        let tutoringPlace = (mainView.tutoringPlaceTextField.text ?? "").trimmingCharacters(in: .whitespaces)
//        
//        guard !className.isEmpty else {
//            mainView.classNameTextField.text = nil
//            mainView.classNameTextField.becomeFirstResponder()
//            
//            let description = AlertMessageType.missingClassName.description
//            view.makeToast(description.message, duration: 1.5, position: .top, style: CustomToast.setting())
//            return
//        }
//        
//        guard !days.isEmpty else {
//            mainView.classNameTextField.becomeFirstResponder()
//            let description = AlertMessageType.missingDaySelection.description
//            view.makeToast(description.message, duration: 1.5, position: .top, style: CustomToast.setting())
//            return
//        }
//        
//        let newData = ClassTable(className: className, tutoringPlace: tutoringPlace, startDate: mainView.startDatePicker.date, endDate: mainView.endDatePicker.date, studentPK: studentArray)
//
//        //errorHandling
//        do {
//            let classPK = try viewModel.classDataSave(classData: newData)._id
//            try viewModel.updateDeleteData()
//            
//            for day in days {
//                
//                guard let betweenDates = getBetweenDates(startDate: mainView.startDatePicker.date, endDate: mainView.endDatePicker.date, day: day.week) else {
//                    let description = AlertMessageType.dateCreationError.description
//                    UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
//                    return
//                }
//                
//                let scheduleData = ScheduleTable(classPK: classPK, day: day.week, startTime: day.startTime, endTime: day.endTime)
//                
//                var calendarData = [CalendarTable]()
//                
//                for date in betweenDates {
//                    calendarData.append(CalendarTable(date: date, schedulePK: scheduleData._id))
//                }
//                
//                try viewModel.scheduleDataSave(scheduleData: scheduleData, calendarData: calendarData)
//            }
//            
//        } catch let realmError as RealmErrorType {
//            let errorDescription = realmError.description
//            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
//        } catch { }
//    }
//    
//    //0(일요일) 선택시 기간 내의 모든 일요일 return
//    func getBetweenDates(startDate: Date, endDate: Date, day: Int) -> [Date]? {
//        var dates = [Date]()
//        var currentDate = startDate
//        
//        while currentDate <= endDate {
//            if Calendar.current.component(.weekday, from: currentDate) - 1 == day {
//                dates.append(currentDate)
//            }
//            
//            guard let date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { return nil }
//            currentDate = date
//        }
//        
//        return dates
//    }
//    
//    private func setStudent() {
//        mainView.scrollView.subviews.forEach({ $0.removeFromSuperview() })
//        
//        var width = 0
//        
//        for i in 0..<studentArray.count{
//            errorHandling {
//                if let name = try viewModel.setStudentButton(studentID: studentArray[i]) {
//                    let button = UIButton()
//                    button.layer.cornerRadius = 8
//                    button.layer.borderColor = UIColor.signatureColor.cgColor
//                    button.layer.borderWidth = 1
//                    button.setTitle(name , for: .normal)
//                    button.titleLabel?.font = .systemFont(ofSize: 15)
//                    button.setTitleColor(UIColor.black, for: .normal)
//                    let configuration = UIImage.SymbolConfiguration(pointSize: 10)
//                    let image = UIImage(systemName: "xmark", withConfiguration: configuration)
//                    button.setImage(image, for: .normal)
//                    button.tintColor = .systemGray5
//                    button.semanticContentAttribute = .forceRightToLeft
//                    button.sizeToFit()
//                    button.frame = CGRect(x: width, y: 0, width: Int(button.frame.width) + 15, height: 35)
//                    button.addTarget(self, action: #selector(studentButtonTapped), for: .touchUpInside)
//                    button.tag = i
//
//                    width += Int(button.frame.width) + 8
//                    mainView.scrollView.addSubview(button)
//                    mainView.scrollView.contentSize.width = CGFloat(width) + 20
//                }
//            }
//        }
//    }
//    
//    @objc private func studentButtonTapped(_ sender: UIButton) {
//          studentArray.remove(at: sender.tag)
//          setStudent()
//    }
//}
//
//extension EditClassViewController: sendWeekStateDelegate{
//    func saveData(startTime: Date, endTime: Date) {
//        guard let tapButton else { return }
//        
//        //이미 있으면 지우고 다시 생성
//        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
//            days.remove(at: index)
//        }
//        
//        days.append(weekTime(week: tapButton.tag, startTime: startTime, endTime: endTime))
//        tapButton.backgroundColor = .signatureColor
//        tapButton.setTitleColor(.white, for: .normal)
//    }
//    
//    func deleteData() {
//        guard let tapButton else { return }
//        
//        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
//            days.remove(at: index)
//        }
//        
//        tapButton.backgroundColor = .white
//        tapButton.setTitleColor(.black, for: .normal)
//    }
//}
//
//extension EditClassViewController: studentArrayDelegate {
//    func studentArray(data: [String]) {
//        studentArray = data
//        setStudent()
//    }
//}
//
//extension EditClassViewController {
//    struct weekTime {
//        var week: Int
//        var startTime: Date //2:54
//        var endTime: Date
//
//        init(week: Int, startTime: Date, endTime: Date) {
//            self.week = week
//            self.startTime = startTime
//            self.endTime = endTime
//        }
//    }
//}
//
//extension EditClassViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let textField = textField.superview?.viewWithTag(textField.tag + 1) {
//            textField.becomeFirstResponder()
//        }
//        
//        return true
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard textField.tag < 1000 else { return false }// Date textField 입력 불가
//        guard !string.isEmpty, var text = textField.text else { return true }
//        text = text + string
//        
//        //모아쓰기가 아닌 방식(숫자, 영어 등..)
//        if let textInputMode = textField.textInputMode, textInputMode.primaryLanguage == "en-US"{
//            if text.count > 20 {
//                return returnAndSendAlert()
//            }
//        } else {
//            if text.count > 21 {
//                textField.text?.removeLast()
//                return returnAndSendAlert()
//            }
//        }
//
//       return true
//    }
//    
//    func returnAndSendAlert() -> Bool {
//        let description = AlertMessageType.characterLimit.description
//        UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
//        return false
//    }
//}
//
