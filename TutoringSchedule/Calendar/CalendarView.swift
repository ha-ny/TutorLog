//
//  CalendarView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import FSCalendar

class CalendarView: BaseView {
    
    let dateTapArea = UIControl()
    
    let dateLabel = {
        let view = UILabel()
        view.text = Date.convertToString(format: "yearMonthFormat".localized, date: Date())
        view.textColor = .blue
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let iconImage = {
        let view = UIImageView()
        view.image = .down
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let profileButton = ImageButton(image: .profile)
    
    let calendar = {
       let view = FSCalendar()
        view.locale = Locale.current
        
        //Weekday
        view.appearance.weekdayFont = .systemFont(ofSize: 14)
        view.appearance.weekdayTextColor = .black //요일 글씨 색
        
        for (index, item) in Calendar.current.shortWeekdaySymbols.enumerated() {
            view.calendarWeekdayView.weekdayLabels[index].text = item
        }

        //Header
        view.calendarHeaderView.isHidden = true
        view.headerHeight = 0
        
        view.appearance.titleSelectionColor = UIColor.black
        view.appearance.selectionColor = UIColor.blue.withAlphaComponent(0.2)
        view.appearance.todayColor = UIColor.orange.withAlphaComponent(0.2)
        view.weekdayHeight = 40

        return view
    }()
    
    override func setConfigure() {
        addSubview(dateTapArea)
        addSubview(profileButton)
        addSubview(calendar)
        
        dateTapArea.addSubview(dateLabel)
        dateTapArea.addSubview(iconImage)
    }

    override func setConstraint() {
        dateTapArea.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(26)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        iconImage.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        profileButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().offset(-26)
            $0.size.equalTo(28)
        }

        calendar.snp.makeConstraints {
            $0.top.equalTo(dateTapArea.snp.bottom).offset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}

