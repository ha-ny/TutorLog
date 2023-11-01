//
//  EditClassViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation

class EditClassViewModel {
    
    private let realmRepository = RealmRepository()
    
    enum EventType {
        case settingData(ClassTable)
        case settingDayButton([ScheduleTable])
        case saveData
        case idle
    }
    
    var editType: EditType<ClassTable> = .create {
        didSet {
            if case .update(let data) = editType {
                state.value = .settingData(data)
            }
        }
    }
    
    var state: Observable<EventType> = Observable(value: .idle)
    
    func settingData(classData: ClassTable) throws {
        let data = try realmRepository.read(ScheduleTable.self)
        let scheduleData = data.filter { $0.classPK == classData._id}
        state.value = .settingDayButton(scheduleData)
    }
    
    func setStudentButton(studentID: String) throws -> String? {
        let data = try realmRepository.read(StudentTable.self)
        let student = data.filter { !$0.ishidden && $0._id.stringValue == studentID }
        return student.isEmpty ? nil : student[0].name
    }
    
    func saveData(newData: ClassTable) throws {
        
        if case .update(let data) = editType {
            newData._id = data._id
        }

        try realmRepository.create(data: newData)
        state.value = .saveData
    }
    
    func classDataSave(classData: ClassTable) throws -> ClassTable {
        if case .update(let data) = editType {
            classData._id = data._id
        }

        try realmRepository.create(data: classData)
        return classData
    }
    
    func updateDeleteData() throws {
        if case .update(let data) = editType {
            let scheduleData = try realmRepository.read(ScheduleTable.self)
            
            let filterScheduleData = scheduleData.filter { $0.classPK == data._id }
            for Schedule in filterScheduleData {
                let calendarData = try realmRepository.read(CalendarTable.self)
                let filterCalendarData = calendarData.filter { $0.schedulePK == Schedule._id }
                try realmRepository.delete(data: filterCalendarData)
            }
            
            try realmRepository.delete(data: filterScheduleData)
        }
    }
    
    func scheduleDataSave(scheduleData: ScheduleTable, calendarData: [CalendarTable]) throws {
        //삭제일땐 updateDeleteData 한번 호출해주기
        try realmRepository.create(data: scheduleData)

        for data in calendarData {
            try realmRepository.create(data: data)
        }

        state.value = .saveData
    }
}
