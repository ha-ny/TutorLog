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
    
    func settingData(classData: ClassTable) {
        guard let data = realmRepository.read(ScheduleTable.self) else { return }
        let scheduleData = data.filter { $0.classPK == classData._id }
        state.value = .settingDayButton(scheduleData)
    }
    
    func setStudentButton(studentID: String) -> String? {
        guard let data = realmRepository.read(StudentTable.self) else { return nil }
        return data.filter { !$0.ishidden && $0._id.stringValue == studentID }[0].name
    }
    
    func saveData(newData: ClassTable) {
        
        if case .update(let data) = editType {
            let originId = data._id
            newData._id = originId
        }

        realmRepository.create(data: newData)
        state.value = .saveData
    }
    
    func classDataSave(classData: ClassTable) -> ClassTable {
        if case .update(let data) = editType {
            classData._id = data._id
        }

        realmRepository.create(data: classData)
        return classData
    }
    
    func scheduleDataSave(scheduleData: ScheduleTable, calendarData: [CalendarTable]) {
        
        if case .update(let data) = editType {
            guard let scheduleData = realmRepository.read(ScheduleTable.self) else { return }
            
            let filterScheduleData = scheduleData.filter { $0.classPK == data._id }
            for Schedule in filterScheduleData {
                guard let calendarData = realmRepository.read(CalendarTable.self) else { return }
                
                let filterCalendarData = calendarData.filter { $0.schedulePK == Schedule._id }
                realmRepository.delete(data: filterCalendarData)
            }
            
            realmRepository.delete(data: filterScheduleData)
        }
        
        realmRepository.create(data: scheduleData)

        for data in calendarData {
            realmRepository.create(data: data)
        }

        state.value = .saveData
    }
}
