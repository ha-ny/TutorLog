//
//  EditStudentViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/19.
//

import Foundation

class EditStudentViewModel {
    
    private let realmRepository = RealmRepository()
    
    enum EventType {
        //case settingData(StudentTable)
        case saveData
        case idle
    }
    
//    var editType: EditType<StudentTable> = .create {
//        didSet {
//            if case .update(let data) = editType {
//                state.value = .settingData(data)
//            }
//        }
//    }
    
    var state: Observable<EventType> = Observable(value: .idle)
    
    //func saveData(newData: StudentTable) throws {
        
//        if case .update(let data) = editType {
//            newData._id = data._id
//        }

//        try realmRepository.create(data: newData)
//        state.value = .saveData
//    }
    
}
