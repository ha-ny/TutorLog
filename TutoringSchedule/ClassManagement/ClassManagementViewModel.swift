//
//  ClassManagementViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation

class ClassManagementViewModel {
    
    private let realmRepository = RealmRepository()

    enum EventType {
        case settingData([ClassTable])
        case searchData([ClassTable])
        case rowDelete
        case idle
    }
    
    var state: Observable<EventType> = Observable(value: .idle)
    
    func settingData() {
        guard let data = realmRepository.read(ClassTable.self) else { return }
        let filterData = data.filter { !$0.ishidden }.sorted { $0[keyPath: \.className] < $1[keyPath: \.className] }
        state.value = .settingData(filterData)
    }
    
    func searchData(keyWord: String) {
        guard let data = realmRepository.read(ClassTable.self) else { return }
        let filterData = data.filter { !$0.ishidden && $0.className.contains(keyWord) }.sorted { $0[keyPath: \.className] < $1[keyPath: \.className] }
        state.value = .searchData(filterData)
    }
    
    func rowDelete(data classData: ClassTable) {
        guard let scheduleData = realmRepository.read(ScheduleTable.self) else { return }
        guard let calendarData = realmRepository.read(CalendarTable .self) else { return }
                
        let schedules = scheduleData.filter { $0.classPK == classData._id }
        
        for schedule in schedules {

            let calendarFilterData = calendarData.filter {
                $0.schedulePK == schedule._id && Int($0.date.timeIntervalSince(Date())) >= 0
            }

            realmRepository.delete(data: calendarFilterData)
        }

        realmRepository.delete(data: scheduleData)
        realmRepository.create(data: classData)
        state.value = .rowDelete
    }
}
