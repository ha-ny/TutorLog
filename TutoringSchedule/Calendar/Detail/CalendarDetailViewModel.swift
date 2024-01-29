//
//  CalendarDetailViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 1/25/24.
//

import Foundation

struct DetailData {
    var classData: ClassTable
    var startTime: Date
    var endTime: Date
}

class CalendarDetailViewModel {
    private let realmRepository = RealmRepository()
    
    func result(date: Date) throws -> [DetailData] {
        var data = [DetailData]()
        
        let readCalendar = try realmRepository.read(CalendarTable.self)
        let start = Calendar.current.startOfDay(for: date)
        let end = start.addingTimeInterval(24 * 60 * 60 - 1)
        
        let calendarTable = readCalendar.filter { $0.date >= start && $0.date <= end }
        let scheduleData = try realmRepository.read(ScheduleTable.self)
        let readClassData = try realmRepository.read(ClassTable.self)
        
        for calendarData in calendarTable {
            let schedule = scheduleData.filter { $0._id == calendarData.schedulePK }[0]
            let classData = readClassData.filter { $0._id == schedule.classPK }[0]
            
            let startTime = schedule.startTime
            let endTime = schedule.endTime
            
            let detail = DetailData(classData: classData, startTime: startTime, endTime: endTime)
            data.append(detail)
        }
        data.sort { $0.startTime < $1.startTime }
        return data
    }
}
