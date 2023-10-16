//
//  EditClassViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import RealmSwift

class EditClassViewController: UIViewController {
    
    //VC 기본 세팅
    var editType: EditType?
    var delegate: saveSucsessDelegate?
    
    //editType .update시 기본 세팅
    var data: ClassTable?
    
    private let mainView = EditClassView()
    private let realmRepository = RealmRepository()
    
    private var days: [weekTime] = []
    private var studentArray = List<ObjectId>()
    private var tapButton: UIButton?

    convenience init(editType: EditType, delegate: saveSucsessDelegate) {
        self.init()
        self.editType = editType
        self.delegate = delegate
    }
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "수업정보"
        
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
        dataSetting()
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
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func dataSetting() {
        guard let data else { return }
        
        mainView.classNameTextField.text = data.className
        mainView.tutoringPlaceTextField.text = data.tutoringPlace
        mainView.startDatePicker.date = data.startDate
        mainView.endDatePicker.date = data.endDate
        
        let startDate = Date().convertToString(format: "yyyy년 MM월 dd일", date: data.startDate)
        let endDate = Date().convertToString(format: "yyyy년 MM월 dd일", date: data.endDate)
        
        mainView.startDateTextField.text = startDate
        mainView.endDateTextField.text = endDate
        studentArray = data.studentPK
        setStudent()
        
        guard let scheduleData = realmRepository.read(ScheduleTable.self) else { return }
                
        let schedules = scheduleData.where {
            $0.classPK == data._id
        }
        
        for data in schedules {
            switch Days(rawValue: data.day) {
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

    @objc private func startDateChange(_ sender: UIDatePicker) {
        mainView.startDateTextField.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: sender.date)
        mainView.endDatePicker.date = sender.date
        mainView.endDateTextField.text = mainView.startDateTextField.text
        view.endEditing(true)
    }

    @objc private func endDateChange(_ sender: UIDatePicker) {
        
        guard Int(sender.date.timeIntervalSince(mainView.startDatePicker.date)) >= 0 else {
            let alert = UIAlertController().customMessageAlert(message: "시작일이 종료일보다 이후일 수 없습니다")
            present(alert, animated: true)
            return
        }
        
        mainView.endDateTextField.text = Date().convertToString(format: "yyyy년 MM월 dd일", date: sender.date)
        view.endEditing(true)
    }

    @objc private func saveButtonTapped() {

        guard let classPK = classDataSave() else { return }
        scheduleDataSave(classPK: classPK)
        delegate?.saveSucsess()
        navigationController?.popViewController(animated: true)
    }
    
    func classDataSave() -> ObjectId? {
        guard let className = mainView.classNameTextField.text, !className.isEmpty else {
            mainView.classNameTextField.becomeFirstResponder()
            
            let alert = UIAlertController().customMessageAlert(message: "수업명 입력은 필수입니다")
            present(alert, animated: true)
            return nil//필수체크
        }

        let tutoringPlace = mainView.tutoringPlaceTextField.text ?? ""

        let newData = ClassTable(className: className, tutoringPlace: tutoringPlace, startDate: mainView.startDatePicker.date, endDate: mainView.endDatePicker.date, studentPK: studentArray)
        
        switch editType {
        case .create:
            realmRepository.create(data: newData)
        case .update:
            guard let data else { return nil }
            
            let originId = data._id
            newData._id = originId
            realmRepository.update(data: newData)
        case .none:
            let alert = UIAlertController().customMessageAlert(message: "오류가 발생했습니다.\n다시 실행해주세요")
            present(alert, animated: true)
            return nil
        }
        
        return newData._id
    }
    
    func scheduleDataSave(classPK: ObjectId) {

        for day in days {
            let scheduleData = ScheduleTable(classPK: classPK, day: day.week, startTime: day.startTime, endTime: day.endTime)
            
            switch editType {
            case .create:
                realmRepository.create(data: scheduleData)
            case .update:
                guard let data else { return }
                
                let originId = data._id
                scheduleData._id = originId
                realmRepository.update(data: scheduleData)
                
                guard var calendarData = realmRepository.read(CalendarTable.self) else { return }
                calendarData = calendarData.where {
                    $0.schedulePK == originId
                }
                
                for result in calendarData {
                    realmRepository.delete(data: result)
                }

            case .none:
                let alert = UIAlertController().customMessageAlert(message: "오류가 발생했습니다.\n다시 실행해주세요")
                present(alert, animated: true)
            }
            
            guard let betweenDates = getBetweenDates(startDate: mainView.startDatePicker.date, endDate: mainView.endDatePicker.date, day: day.week) else {
                let alert = UIAlertController().customMessageAlert(message: "날짜 생성 중 문제가 발생했습니다.\n다시 실행해주세요")
                present(alert, animated: true)
                return
            }
            
            for date in betweenDates {
                let calendarData = CalendarTable(date: date, schedulePK: scheduleData._id)
                realmRepository.create(data: calendarData)
            }
        }
    }

    func getBetweenDates(startDate: Date, endDate: Date, day: Int) -> [Date]? {
        var dates = [Date]()
        var currentDate = startDate
        
        while currentDate <= endDate {
            if Calendar.current.component(.weekday, from: currentDate) - 1 == day {
                dates.append(currentDate)
            }
            
            guard let date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { return nil }
            currentDate = date
        }
        
        return dates
    }
    
    private func setStudent() {
        
        mainView.scrollView.subviews.forEach({ $0.removeFromSuperview() })

            for i in 0..<studentArray.count{

                let xPos = 80 * i
                let button = UIButton()
                button.layer.cornerRadius = 8
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.layer.borderWidth = 1
                
                guard var data = realmRepository.read(StudentTable.self) else { return }
                
                data = data.where {
                    $0._id == self.studentArray[i]
                }

                button.setTitle(data[0].name , for: .normal)
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
        let vc = StudentListViewController()
        vc.delegate = self
        vc.studentData = studentArray

        if let sheet = vc.sheetPresentationController {

            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }

        present(vc, animated: true)
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
    func studentArray(data: List<ObjectId>) {
        studentArray = data
        setStudent()
    }
}
