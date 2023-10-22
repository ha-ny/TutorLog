//
//  CalendarView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import FSCalendar

class CalendarView: BaseView {
        
    let yearMonthLabel = {
        let view = UILabel()
        view.text = Date().convertToString(format: "yyyy년 MM월", date: Date())
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
//    let searchButton = {
//        let view = UIButton()
//        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        view.tintColor = .black
//        return view
//    }()
    
    let todayButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "arrow.uturn.backward"), for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    let calendar = {
       let view = FSCalendar()
        view.locale = Locale(identifier: "ko_KR")
        
        // 상단 요일
        view.appearance.weekdayFont = .systemFont(ofSize: 14)
        view.appearance.weekdayTextColor = .black

        view.calendarWeekdayView.weekdayLabels[0].text = "일"
        view.calendarWeekdayView.weekdayLabels[1].text = "월"
        view.calendarWeekdayView.weekdayLabels[2].text = "화"
        view.calendarWeekdayView.weekdayLabels[3].text = "수"
        view.calendarWeekdayView.weekdayLabels[4].text = "목"
        view.calendarWeekdayView.weekdayLabels[5].text = "금"
        view.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 숫자 폰트 사이즈
        view.appearance.titleFont = .systemFont(ofSize: 16)

        view.calendarHeaderView.isHidden = true //Header
        view.appearance.borderRadius = 1 // 선택시: 네모(0)
        view.appearance.headerMinimumDissolvedAlpha = 0.0 //전후 년, 월 지우기
        view.placeholderType = .none // 이번 달 날짜만 나오도록
        
        view.appearance.selectionColor = .gray
        view.appearance.todayColor = .systemGray4
        
        return view
    }()
    
    let lineView = {
        let view = UILabel()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let tableView = {
        let view = UITableView()
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return view
    }()
    
    override func setConfigure() {
        addSubview(calendar)
        addSubview(yearMonthLabel)
        //addSubview(searchButton)
        addSubview(todayButton)
        addSubview(lineView)
        addSubview(tableView)
    }
    
    override func setConstraint() {
        yearMonthLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        todayButton.snp.makeConstraints { make in
            make.right.equalTo(self).inset(20)
            make.top.equalTo(self).inset(20)
            make.size.equalTo(30)
        }
        
//        todayButton.snp.makeConstraints { make in
//            make.right.equalTo(searchButton.snp.left)
//            make.top.bottom.equalTo(searchButton)
//            make.size.equalTo(30)
//        }
        
//        searchButton.snp.makeConstraints { make in
//            make.size.equalTo(30)
//            make.top.right.equalTo(self.safeAreaLayoutGuide).inset(20)
//        }
        
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

