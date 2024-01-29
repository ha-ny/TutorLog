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
        view.text = Date.convertToString(format: "yearMonthFormat".localized, date: Date())
        view.textColor = .bdBlue
        view.font = .customFont(sytle: .bold, ofSize: 18)
        return view
    }()

    let todayButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "arrow.uturn.backward"), for: .normal)
        view.tintColor = .darkGray
        return view
    }()
    
    let calendar = {
       let view = FSCalendar()
        view.locale = Locale.current

        // 상단 요일
        view.appearance.weekdayFont = .customFont(ofSize: 16)
        view.appearance.weekdayTextColor = .bdBlack
        
        // 숫자 폰트 사이즈
        view.appearance.titleFont = .customFont(ofSize: 14)
        
        view.calendarHeaderView.isHidden = true
        view.headerHeight = 0
        view.appearance.titleSelectionColor = UIColor.black
        view.appearance.borderRadius = 0.4
        view.appearance.selectionColor = .darkGray.withAlphaComponent(0.1)
        view.appearance.todayColor = .bdLine
        view.weekdayHeight = 35
        
        return view
    }()
    
    override func setConfigure() {
        addSubview(calendar)
        addSubview(yearMonthLabel)
        addSubview(yearMonthLabel)
        addSubview(todayButton)
    }

    override func setConstraint() {
        yearMonthLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(26)
        }

        todayButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(30)
        }

        calendar.snp.makeConstraints {
            $0.top.equalTo(yearMonthLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}

