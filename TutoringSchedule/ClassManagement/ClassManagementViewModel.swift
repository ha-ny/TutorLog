//
//  ClassManagementViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation

class ClassManagementViewModel {
    
    enum EventType {
        case settingData([ClassTable])
        case searchData([ClassTable])
        case rowDelete
        case idle
    }
    
    private let realmRepository = RealmRepository()
    var state: Observable<EventType> = Observable(value: .idle)
    
    func settingData() throws {
        let data = try realmRepository.read(ClassTable.self)
        let filterData = data.filter { !$0.ishidden }.sorted { $0[keyPath: \.className] < $1[keyPath: \.className] }
        state.value = .settingData(filterData)
    }
    
    func searchData(keyWord: String) throws {
        let data = try realmRepository.read(ClassTable.self)
        let filterData = data.filter { !$0.ishidden && (keyWord.isEmpty || $0.className.contains(keyWord)) }.sorted { $0[keyPath: \.className] < $1[keyPath: \.className] }
        state.value = .searchData(filterData)
    }
    
    func rowDelete(data classData: ClassTable) throws {
        let scheduleData = try realmRepository.read(ScheduleTable.self)
        let schedules = scheduleData.filter { $0.classPK == classData._id }
        
        for schedule in schedules {

            let calendarData = try realmRepository.read(CalendarTable.self)
            let calendarFilterData = calendarData.filter {
                return $0.schedulePK == schedule._id && Int($0.date.timeIntervalSince(Date())) / (24*60*60) >= 0
            }
            
            try realmRepository.delete(data: calendarFilterData)
        }

        try realmRepository.create(data: classData)
        
        state.value = .rowDelete
    }
}
