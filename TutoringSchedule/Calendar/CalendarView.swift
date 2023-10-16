//
//  CalendarView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarView: BaseView {
    
    private let realmRepository = RealmRepository()
    var data: Results<CalendarTable>?

    lazy var yearMonthLabel = {
        let view = UITextField()
        view.text = Date().convertToString(format: "yyyy년 MM월", date: Date())
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

    let calendar = FSCalendar()
    
    let lineView = {
        let view = UILabel()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var tableView = {
       let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConfigure() {
        addSubview(calendar)
        addSubview(yearMonthLabel)
        addSubview(searchButton)
        addSubview(todayButton)
        addSubview(lineView)
        addSubview(tableView)
    }
    
    override func setConstraint() {
        yearMonthLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        todayButton.snp.makeConstraints { make in
            make.right.equalTo(searchButton.snp.left)
            make.top.bottom.equalTo(searchButton)
            make.size.equalTo(30)
        }

        searchButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.right.equalTo(self.safeAreaLayoutGuide).inset(20)
        }

        calendar.snp.makeConstraints { make in
            make.top.equalTo(yearMonthLabel.snp.bottom).inset(25)
            make.centerX.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(calendar.snp.width)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(4)
            make.leading.trailing.equalTo(calendar)
            make.height.equalTo(0.7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
}

extension CalendarView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        guard let scheduleTable = realmRepository.read(ScheduleTable.self) else { return UITableViewCell() }
        guard let classTable = realmRepository.read(ClassTable.self) else { return UITableViewCell() }
        
//        let scheduleData = scheduleTable.where {
//            $0._id = data[indexPath.row].schedulePK
//        }
//        
//        let classData = classTable.where {
//            $0._id = scheduleData.
//        }

        
        let cell = UITableViewCell()
        cell.textLabel?.text = "데이터"
        return cell
    }
}

extension CalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func setCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        
        // calendar locale > 한국으로 설정
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 상단 요일을 한글로 변경
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 월~일 글자 폰트 및 사이즈 지정
        calendar.appearance.weekdayFont = .systemFont(ofSize: 14)
        // 숫자들 글자 폰트 및 사이즈 지정
        calendar.appearance.titleFont = .systemFont(ofSize: 16)

        //헤더 숨김
        calendar.calendarHeaderView.isHidden = true
        
        // 요일 글자 색
        calendar.appearance.weekdayTextColor = .darkGray
        
        // 선택시 네모 = 0
        calendar.appearance.borderRadius = 1
        
        // 양옆 년도, 월 지우기
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0

        // 달에 유효하지않은 날짜 지우기
        calendar.placeholderType = .none

        calendar.appearance.selectionColor = .gray
        calendar.appearance.todayColor = .systemGray4
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

        guard let data else { return }
        
        let label = UILabel(frame: CGRect(x: 28, y: 25, width: 14, height: 14))
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 6
        label.font = .boldSystemFont(ofSize: 9)
        label.textAlignment = .center
        label.textColor = .white

        let betweenDate = Date().betweenDate(date: date)
        let result = data.filter("date >= %@ AND date <= %@", betweenDate.start, betweenDate.end)

        if result.isEmpty {
            for subview in cell.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
            }
        } else {
            label.text = "\(result.count)"
            cell.addSubview(label)
        }
    }
    
    //캘린더 스크롤 감지
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        yearMonthLabel.text =  Date().convertToString(format: "yyyy년 MM월", date: calendar.currentPage)
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let calendarData = realmRepository.read(CalendarTable.self) else { return }
        
        let betweenDate = Date().betweenDate(date: date)
        let result = calendarData.filter("date >= %@ AND date <= %@", betweenDate.start, betweenDate.end)
        
        data = result
        tableView.reloadData()
    }
}

extension CalendarView: UITextFieldDelegate {
    //textField 입력 막음
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
