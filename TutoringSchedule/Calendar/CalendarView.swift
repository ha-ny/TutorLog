//
//  CalendarView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import FSCalendar

class CalendarView: BaseView {
    let calendar = FSCalendar()
    var selectedDate = Date()
    
    override func setConfigure() {
        addSubview(calendar)
    }
    
    override func setConstraint() {
        calendar.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
}

extension CalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    
}
