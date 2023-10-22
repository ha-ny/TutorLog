//
//  CalendarViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation

class CalendarViewModel {
    
    private let realmRepository = RealmRepository()

    enum EventType {
        case calendarPageChange(String)
        case calendarDidSelect([CalendarTable])
        case idle
    }
    
    var state: Observable<EventType> = Observable(value: .idle)

    func cellSetting(data calendarData: CalendarTable, selectDate: Date) -> (className: String, time: String)?  {
        guard let scheduleData = realmRepository.read(ScheduleTable.self) else { return nil }
        guard let classData = realmRepository.read(ClassTable.self) else { return nil }
        
        let schedule = scheduleData.filter { $0._id == calendarData.schedulePK }
        let className = classData.filter { $0._id == schedule[0].classPK }[0].className
        
        for data in schedule {
            if Calendar.current.component(.weekday, from: selectDate) - 1 == data.day {
                let startTime = Date().convertToString(format: "HH:mm", date: data.startTime)
                let endTime = Date().convertToString(format: "HH:mm", date: data.endTime)
                let time = startTime + "~" + endTime
                
                return (className, time)
            }
        }
        return nil
    }
    
    func calendarWillDisplay(date: Date) -> [CalendarTable]? {
        guard let data = realmRepository.read(CalendarTable.self) else { return nil }
        let betweenDate = Date().betweenDate(date: date)
        return data.filter { $0.date >= betweenDate.start && $0.date <= betweenDate.end }
    }
    
    func calendarPageChange(date: Date) {
        state.value = .calendarPageChange(Date().convertToString(format: "yyyy년 MM월", date: date))
    }
    
    func calendarDidSelect(date: Date) {
        guard let data = calendarWillDisplay(date: date) else { return }
        state.value = .calendarDidSelect(data)
    }
}
