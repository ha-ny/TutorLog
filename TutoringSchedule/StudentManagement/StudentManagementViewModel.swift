//
//  StudentManagementViewModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/20.
//

import Foundation

class StudentManagementViewModel {
    
    private let realmRepository = RealmRepository()

    enum EventType {
        case settingData([StudentTable])
        case searchData([StudentTable])
        case rowDelete
        case idle
    }
    
    var state: Observable<EventType> = Observable(value: .idle)
    
    func settingData() throws {
        let data = try realmRepository.read(StudentTable.self)
        let filterData = data.filter { !$0.ishidden }.sorted { $0[keyPath: \.name] < $1[keyPath: \.name] }
        state.value = .settingData(filterData)
    }
    
    func searchData(keyWord: String) throws {
        let data = try realmRepository.read(StudentTable.self)
        let filterData = data.filter { !$0.ishidden && (keyWord.isEmpty || $0.name.contains(keyWord)) }.sorted { $0[keyPath: \.name] < $1[keyPath: \.name] }
        state.value = .searchData(filterData)
    }
    
    func rowDelete(data: StudentTable) throws {
        try realmRepository.create(data: data)
        state.value = .rowDelete
    }
}
