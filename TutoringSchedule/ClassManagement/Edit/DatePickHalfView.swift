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

class DatePickHalfView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private let maxCount = 10000
    var day = 0
    var delegate: sendWeekStateDelegate?
    
    let dayLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    lazy var timeLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 25)
        return view
    }()
    
    let startLabel = {
        let view = UILabel()
        view.text = "시작 시간"
        view.textAlignment = .center
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let endLabel = {
        let view = UILabel()
        view.text = "종료 시간"
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(okButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        
        switch Days(rawValue: day) {
        case .sun: dayLabel.text = "일요일"
        case .mon: dayLabel.text = "월요일"
        case .tue: dayLabel.text = "화요일"
        case .wed: dayLabel.text = "수요일"
        case .thu: dayLabel.text = "목요일"
        case .fri: dayLabel.text = "금요일"
        case .sat: dayLabel.text = "토요일"
        case .none:
            dayLabel.text = "요일 불러오기 실패"
        }
        
        
        view.addSubview(dayLabel)
        view.addSubview(timeLabel)
        view.addSubview(startLabel)
        view.addSubview(endLabel)
        view.addSubview(pickerView)

        
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
        let newRow = maxCount / 2
        pickerView.selectRow(newRow, inComponent: 0, animated: true) // 9
        pickerView.selectRow(newRow + 4, inComponent: 1, animated: true) //0
        pickerView.selectRow(newRow + 1, inComponent: 2, animated: true) // 10
        pickerView.selectRow(newRow + 4, inComponent: 3, animated: true) //0
        
        timeSetting()
    }

    @objc func okButtonTapped() {

        var time = "\(startHour):\(startMinute)"
        guard let startTime = stringToDate(format: "HH:mm", date: time) else {
            let alert = UIAlertController().customMessageAlert(message: "시작시간 저장에 실패했습니다./n다시 실행해주세요.")
            present(alert, animated: true)
            return
        }

        time = "\(endHour):\(endMinute)"
        guard let endTime = stringToDate(format: "HH:mm", date: time) else {
            let alert = UIAlertController().customMessageAlert(message: "종료시간 저장에 실패했습니다./n다시 실행해주세요.")
            present(alert, animated: true)
            return
        }

        guard Int(endTime.timeIntervalSince(startTime)) >= 0 else {
            let alert = UIAlertController().customMessageAlert(message: "시작시간은 종료시간보다 클 수 없습니다")
            present(alert, animated: true)
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
        
        timeLabel.text = Date().convertToString(format: "HH:mm", date: startTime) + "~" + Date().convertToString(format: "HH:mm", date: endTime)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {

        return maxCount
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if component % 2 == 0
        {
            return String(format: "%02d", (row%24)+1)
        }
        else
        {

            return String(format: "%02d", (row%12)*5)
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
             
        switch TimeType(rawValue: component) {
        case .startHour: startHour = (row % 24) + 1
        case .startMinute: startMinute = (row % 12) * 5
        case .endHour: endHour = (row % 24) + 1
        case .endMinute:  endMinute = (row % 12) * 5
        case .none:
            return
        }
        
        timeSetting()
    }
}
