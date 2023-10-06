//
//  CalendarViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
        
    lazy var tableView = {
       let view = UITableView()
        view.rowHeight = 43
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let pickerViewList: [Int] = Array(1...1079).sorted(by: >)
    
    lazy var pickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var yearMonthLabel = {
        let view = UITextField()
        view.text = dateToString(format: "yyyy년 MM월", date: Date())
        view.inputView = pickerView
        view.tintColor = .clear
        view.delegate = self
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()

    let searchButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let todayButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "arrow.uturn.backward"), for: .normal)
        view.tintColor = .darkGray
        return view
    }()
//
//    let tableTitle = {
//        let view = UILabel()
//        view.text = "일정"
//        view.font = .boldSystemFont(ofSize: 16)
//        return view
//    }()
//
    let calendar = FSCalendar()
    var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        setConfigure()
        setConstraint()
        setCalendar()
    }
    
    func setCalendar() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        // calendar locale > 한국으로 설정
        self.calendar.locale = Locale(identifier: "ko_KR")
        
        // 상단 요일을 한글로 변경
        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        self.calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        self.calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        self.calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        self.calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        self.calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        self.calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 월~일 글자 폰트 및 사이즈 지정
        self.calendar.appearance.weekdayFont = .systemFont(ofSize: 14)
        // 숫자들 글자 폰트 및 사이즈 지정
        self.calendar.appearance.titleFont = .systemFont(ofSize: 16)

        //헤더 숨김
        self.calendar.calendarHeaderView.isHidden = true
        
        // 요일 글자 색
        self.calendar.appearance.weekdayTextColor = .darkGray
        
        // 선택시 네모 = 0
        self.calendar.appearance.borderRadius = 1
        
        // 양옆 년도, 월 지우기
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0

        // 달에 유효하지않은 날짜 지우기
        self.calendar.placeholderType = .none

        //선택 된 날의 동그라미 색
        self.calendar.appearance.selectionColor = .gray
        self.calendar.appearance.todayColor = .systemGray4
        self.calendar.select(selectedDate)
    }

    // title의 디폴트 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "Sun" || Calendar.current.shortWeekdaySymbols[day] == "일" {
            return .systemRed
        } else if Calendar.current.shortWeekdaySymbols[day] == "Sat" || Calendar.current.shortWeekdaySymbols[day] == "토" {
            return .systemBlue
        } else {
            return .black
        }
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {

        let label = UILabel(frame: CGRect(x: 5, y: 38, width: cell.bounds.width / 1.2, height: 13))
        label.layer.backgroundColor = UIColor.black.cgColor
        label.font = .boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 3

        switch dateToString(format: "YYYY-MM-dd", date: date) {
        case "2023-09-05":
            label.text = "탕후루"

        case "2023-09-06":
            label.text = "배고파"

        case "2023-09-17":
            label.text = "마라탕"
            
        case "2023-09-20":
            label.text = "배고파"

        default:
            label.layer.backgroundColor = nil
        }

        cell.addSubview(label)
    }
    
    //캘린더 스크롤 감지
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        yearMonthLabel.text = dateToString(format: "yyyy년 MM월", date: calendar.currentPage)
    }
    
    func dateToString(format: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_kr") // 한국의 시간을 지정해준다.
        dateFormatter.timeZone = TimeZone(abbreviation: "KST") // 한국의 시간대로 지정한다.
        
        return dateFormatter.string(from: date) // Date to String
    }
    
    // 날짜를 선택했을 때 할일을 지정 /  myDateFormatter.dateFormat = "yyyy.MM.dd(EEEE) a hh시 mm분" // 2020.08.13(수) 오후 04시 30분
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateToString(format: "yyyy.MM.dd(EEEE) a hh시 mm분", date: date))
    }
    
    //오늘 날짜로 돌아오기
    @objc func todayButtonTapped() {
        self.calendar.select(Date())
    }

    @objc func searchButtonTapped() {
        let vc = CalendarSearchViewController()
        //navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true)
    }
    
    func setConfigure() {
        view.addSubview(calendar)
        view.addSubview(yearMonthLabel)
        view.addSubview(searchButton)
        view.addSubview(todayButton)
        view.addSubview(tableView)
        
        todayButton.addTarget(self, action: #selector(todayButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func setConstraint() {

        yearMonthLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        todayButton.snp.makeConstraints { make in
            make.right.equalTo(searchButton.snp.left)
            make.top.bottom.equalTo(searchButton)
            make.size.equalTo(30)
        }

        searchButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        calendar.snp.makeConstraints { make in
            make.top.equalTo(yearMonthLabel.snp.bottom).inset(25)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(calendar.snp.width)
            make.centerX.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(20)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerViewList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearMonthLabel.text = String(pickerViewList[row])
    }
   
    //textField 입력 못하게..?
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "ddd"
        return cell
    }
}
