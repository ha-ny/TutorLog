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
    
//    func cellSetting(data calendarData: CalendarTable, selectDate: Date) throws -> (classData: ClassTable, time: String)? {
//        let scheduleData = try realmRepository.read(ScheduleTable.self)
//        let readClassData = try realmRepository.read(ClassTable.self)
//        
//        let schedule = scheduleData.filter { $0._id == calendarData.schedulePK }
//        let classData = readClassData.filter { $0._id == schedule[0].classPK }[0]
//        
//        for data in schedule {
//            if Calendar.current.component(.weekday, from: selectDate) - 1 == data.day {
//                let startTime = Date.convertToString(format: "HH:mm", date: data.startTime)
//                let endTime = Date.convertToString(format: "HH:mm", date: data.endTime)
//                let time = startTime + "~" + endTime
//                
//                return (classData, time)
//            }
//        }
//        return nil
//    }

    func calendarWillDisplay(date: Date) throws -> [ScheduleTable] {
        
        let readCalendar = try realmRepository.read(CalendarTable.self)
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(24 * 60 * 60 - 1)
        
        let calendarTable = readCalendar.filter { $0.date >= start && $0.date <= end }
        let scheduleData = try realmRepository.read(ScheduleTable.self)
        let readClassData = try realmRepository.read(ClassTable.self)
        
        var data = [ScheduleTable]()
        
        for calendarData in calendarTable {
            let schedule = scheduleData.filter { $0._id == calendarData.schedulePK }[0]
            data.append(schedule)
        }
        
        return data.sorted { $0.startTime < $1.startTime }
    }
    
    func calendarPageChange(date: Date) {
        state.value = .calendarPageChange(Date.convertToString(format: "yearMonthFormat".localized, date: date))
    }
    
    func calendarDidSelect(date: Date) throws {
        let calendar = try realmRepository.read(CalendarTable.self)
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(24 * 60 * 60 - 1)
        let data = calendar.filter { $0.date >= start && $0.date <= end }
        
        state.value = .calendarDidSelect(data)
    }
}
