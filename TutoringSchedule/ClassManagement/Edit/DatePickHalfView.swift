//
//  DatePickHalfView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/03.
//

import UIKit
import SnapKit

protocol sendWeekStateDelegate {
    func saveData(startTime: Date, endTime: Date)
    func deleteData()
}

class DatePickHalfView: UIViewController {

    private let maxCount = 10000
    var day = 0
    var delegate: sendWeekStateDelegate?
    
    let dayLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let timeLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 25)
        return view
    }()
    
    let startLabel = {
        let view = UILabel()
        view.text = "startLabel".localized
        view.textAlignment = .center
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let endLabel = {
        let view = UILabel()
        view.text = "endLabel".localized
        view.textAlignment = .center
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    lazy var pickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    var startHour = 9
    var startMinute = 0
    var endHour = 10
    var endMinute = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "okButtonTapped".localized, style: .plain, target: self, action: #selector(okButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "deleteButtonTapped".localized, style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black

        setConfigure()
        setConstraint()
        timeSetting()
        
        let newRow = maxCount / 2
        pickerView.selectRow(newRow, inComponent: 0, animated: true) // 9
        pickerView.selectRow(newRow + 4, inComponent: 1, animated: true) //0
        pickerView.selectRow(newRow + 1, inComponent: 2, animated: true) // 10
        pickerView.selectRow(newRow + 4, inComponent: 3, animated: true) //0
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dayLabel.text = dateFormatter.shortWeekdaySymbols[day] + "dayLabel".localized
    }

    func setConfigure() {
        view.addSubview(dayLabel)
        view.addSubview(timeLabel)
        view.addSubview(startLabel)
        view.addSubview(endLabel)
        view.addSubview(pickerView)
    }
    
    func setConstraint() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(dayLabel)
            make.left.equalTo(dayLabel.snp.right).offset(14)
        }
        
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        endLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(startLabel)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(6)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
    }
    
    @objc func okButtonTapped() {
        
        var time = "\(startHour):\(startMinute)"
        guard let startTime = stringToDate(format: "HH:mm", date: time) else {
            let description = AlertMessageType.startTimeSaveFailure.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return
        }

        time = "\(endHour):\(endMinute)"
        guard let endTime = stringToDate(format: "HH:mm", date: time) else {
            let description = AlertMessageType.endTimeSaveFailure.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return
        }

        guard Int(endTime.timeIntervalSince(startTime)) >= 0 else {
            let description = AlertMessageType.invalidTimeRange.description
            UIAlertController.customMessageAlert(view: self, title: description.title, message: description.message)
            return
        }
            
        delegate?.saveData(startTime: startTime, endTime: endTime)
        dismiss(animated: true)
    }
    
    func timeSetting() {
        var time = "\(startHour):\(startMinute)"
        guard let startTime = stringToDate(format: "HH:mm", date: time) else { return }
        
        time = "\(endHour):\(endMinute)"
        guard let endTime = stringToDate(format: "HH:mm", date: time) else { return }
        
        timeLabel.text = Date.convertToString(format: "HH:mm", date: startTime) + "~" + Date.convertToString(format: "HH:mm", date: endTime)
    }
    
    @objc func deleteButtonTapped() {
        delegate?.deleteData()
        dismiss(animated: true)
    }
    
    func stringToDate(format: String, date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }
}

extension DatePickHalfView: UIPickerViewDelegate, UIPickerViewDataSource {
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxCount
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let num = component % 2 == 0 ? (row%24)+1 : (row%12)*5
        return String(format: "%02d", num)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let num = component % 2 == 0 ? (row%24)+1 : (row%12)*5
        
        switch component {
        case 0: startHour = num
        case 1: startMinute = num
        case 2: endHour = num
        case 3: endMinute = num
        default:
            return
        }

        timeSetting()
    }
}
