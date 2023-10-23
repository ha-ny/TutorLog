//
//  EditClassViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit

struct weekTime {
    var week: Int
    var startTime: Date //2:54
    var endTime: Date

    init(week: Int, startTime: Date, endTime: Date) {
        self.week = week
        self.startTime = startTime
        self.endTime = endTime
    }
}

class EditClassViewController: UIViewController {
    
    var delegate: saveSucsessDelegate?
    
    //editType .update시 기본 세팅
    var data: ClassTable?
    
    private let mainView = EditClassView()
    private let viewModel = EditClassViewModel()
    
    private var days: [weekTime] = []
    private var studentArray = [String]()
    private var tapButton: UIButton?
    
    init(editType: EditType<ClassTable>, delegate: saveSucsessDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        viewModel.state.bind { [weak self] eventType in
            guard let self else { return }
            
            if case .settingData(let data) = eventType {
                dataSetting(data)
            } else if case .saveData = eventType {
                delegate.saveSucsess()
                NotificationCenter.default.post(name: .calendarReload, object: nil)
                navigationController?.popViewController(animated: true)
            } else if case .settingDayButton(let schedule) = eventType {
                
                for data in schedule {
                    switch DayType(rawValue: data.day) {
                    case .sun: tapButton = mainView.sunButton
                    case .mon: tapButton = mainView.monButton
                    case .tue: tapButton = mainView.tueButton
                    case .wed: tapButton = mainView.wedButton
                    case .thu: tapButton = mainView.thuButton
                    case .fri: tapButton = mainView.friButton
                    case .sat: tapButton = mainView.satButton
                    case .none:
                        return
                    }
                    
                    saveData(startTime: data.startTime, endTime: data.endTime)
                }
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
        view.backgroundColor = .white
        navigationItem.title = "scheduleEditViewTitle".localized
        
        let backItem = UIBarButtonItem(image: UIImage(systemName: "lessthan.circle.fill"), style: .plain, target: self, action: #selector(backButtonTapped))
        backItem.width = 70
        backItem.tintColor = .black
        navigationItem.leftBarButtonItem = backItem
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.checkmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        navigationItem.rightBarButtonItem = addItem
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        setConfigure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.classNameTextField.becomeFirstResponder()
    }
    
    private func setConfigure() {
        mainView.tutoringPlaceTextField.addTarget(self, action: #selector(didTapView), for: .editingDidEndOnExit)
        mainView.studentButton.addTarget(self, action: #selector(studentDataButton), for: .touchUpInside)
        mainView.startDatePicker.addTarget(self, action: #selector(startDateChange), for: .valueChanged)
        mainView.endDatePicker.addTarget(self, action: #selector(endDateChange), for: .valueChanged)
        
        [mainView.sunButton, mainView.monButton, mainView.tueButton, mainView.wedButton, mainView.thuButton, mainView.friButton, mainView.satButton] .forEach {
            $0.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func studentButtonTapped(_ sender: UIButton) {
        studentArray.remove(at: sender.tag)
        setStudent()
    }
    
    @objc private func studentDataButton() {
        let vc = StudentListViewController()
        vc.delegate = self
        vc.studentData = studentArray

        let nav = UINavigationController(rootViewController: vc)
        
        if let sheet = nav.sheetPresentationController {

            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }

        present(nav, animated: true)
    }
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        
        let vc = DatePickHalfView()
        vc.delegate = self
        vc.day = sender.tag
        let nav = UINavigationController(rootViewController: vc)
        
        if let sheet = nav.sheetPresentationController {
            
            // 3
            sheet.detents = [.medium()]
            
            sheet.preferredCornerRadius = 30
        }
        
        tapButton = sender
        present(nav, animated: true)
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func dataSetting(_ data: ClassTable) {
        mainView.classNameTextField.text = data.className
        mainView.tutoringPlaceTextField.text = data.tutoringPlace
        mainView.startDatePicker.date = data.startDate
        mainView.endDatePicker.date = data.endDate
        
        let startDate = Date.convertToString(format: "fullDateFormat".localized, date: data.startDate)
        let endDate = Date.convertToString(format: "fullDateFormat".localized, date: data.endDate)
        
        mainView.startDateTextField.text = startDate
        mainView.endDateTextField.text = endDate

        studentArray.append(contentsOf: data.studentPK )
        setStudent()
        
        errorHandling {
            try viewModel.settingData(classData: data)
        }
    }
    
    @objc private func startDateChange(_ sender: UIDatePicker) {
        mainView.startDateTextField.text = Date.convertToString(format: "fullDateFormat".localized, date: sender.date)
        mainView.endDatePicker.date = sender.date
        mainView.endDateTextField.text = mainView.startDateTextField.text
        view.endEditing(true)
    }
    
    @objc private func endDateChange(_ sender: UIDatePicker) {
        
        guard Int(sender.date.timeIntervalSince(mainView.startDatePicker.date)) >= 0 else {
            
            let description = AlertMessageType.startDateAfterEndDate.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return
        }
        
        mainView.endDateTextField.text = Date.convertToString(format: "fullDateFormat".localized, date: sender.date)
        view.endEditing(true)
    }
    
    @objc private func saveButtonTapped() {
        guard let className = mainView.classNameTextField.text, !className.isEmpty else {
            mainView.classNameTextField.becomeFirstResponder()
            let description = AlertMessageType.missingClassName.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return
        }
        
        let tutoringPlace = mainView.tutoringPlaceTextField.text ?? ""
        
        let newData = ClassTable(className: className, tutoringPlace: tutoringPlace, startDate: mainView.startDatePicker.date, endDate: mainView.endDatePicker.date, studentPK: studentArray)

        //errorHandling
        do {
            let classPK = try viewModel.classDataSave(classData: newData)._id
                
            for day in days {
                
                guard let betweenDates = getBetweenDates(startDate: mainView.startDatePicker.date, endDate: mainView.endDatePicker.date, day: day.week) else {
                    let description = AlertMessageType.dateCreationError.description
                    UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
                    return
                }
                
                let scheduleData = ScheduleTable(classPK: classPK, day: day.week, startTime: day.startTime, endTime: day.endTime)
                
                var calendarData = [CalendarTable]()
                
                for date in betweenDates {
                    calendarData.append(CalendarTable(date: date, schedulePK: scheduleData._id))
                }
                
                try viewModel.scheduleDataSave(scheduleData: scheduleData, calendarData: calendarData)
            }
            
        } catch let realmError as RealmErrorType {
            let errorDescription = realmError.description
            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
        } catch { }
    }
    
    //0(일요일) 선택시 기간 내의 모든 일요일 return
    func getBetweenDates(startDate: Date, endDate: Date, day: Int) -> [Date]? {
        var dates = [Date]()
        var currentDate = startDate
        
        while currentDate <= endDate {
            if Calendar.current.component(.weekday, from: currentDate) - 1 == day {
                //print("currentDate-----------------", currentDate)
                dates.append(currentDate)
            }
            
            guard let date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { return nil }
            currentDate = date
        }
        
        return dates
    }
    
    private func setStudent() {
        
        mainView.scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        for studentID in studentArray{
            
            //errorHandling
            do {
                if let name = try viewModel.setStudentButton(studentID: studentID), !name.isEmpty{
                    let views = mainView.scrollView.subviews.count
                    let xPos = 80 * views
                    let button = UIButton()
                    button.layer.cornerRadius = 8
                    button.layer.borderColor = UIColor.lightGray.cgColor
                    button.layer.borderWidth = 1
                    
                    button.setTitle(name , for: .normal)
                    button.titleLabel?.font = .systemFont(ofSize: 15)
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.frame = CGRect(x: xPos, y: 0, width: 70, height: 30)
                    button.addTarget(self, action: #selector(studentButtonTapped), for: .touchUpInside)
                    button.tag = views
                    
                    mainView.scrollView.addSubview(button)
                    mainView.scrollView.contentSize.width = 80 * CGFloat(views + 1)
                }
            } catch let realmError as RealmErrorType {
                let errorDescription = realmError.description
                UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
            } catch { }
        }
    }
}

extension EditClassViewController: sendWeekStateDelegate{
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
    
    func deleteData() {
        guard let tapButton else { return }
        
        if let index = days.firstIndex(where: { $0.week == tapButton.tag }){
            days.remove(at: index)
        }
        
        tapButton.backgroundColor = .white
        tapButton.setTitleColor(.black, for: .normal)
    }
}

extension EditClassViewController: studentArrayDelegate {
    func studentArray(data: [String]) {
        studentArray = data
        setStudent()
    }
}

