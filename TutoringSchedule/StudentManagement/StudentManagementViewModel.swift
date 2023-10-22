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
    
    func settingData() {
        guard let data = realmRepository.read(StudentTable.self) else { return }
        let filterData = data.filter { !$0.ishidden }.sorted { $0[keyPath: \.name] < $1[keyPath: \.name] }
        state.value = .settingData(filterData)
    }
    
    func searchData(keyWord: String) {
        guard let data = realmRepository.read(StudentTable.self) else { return }
        let filterData = data.filter { !$0.ishidden && $0.name.contains(keyWord) }.sorted { $0[keyPath: \.name] < $1[keyPath: \.name] }
        state.value = .searchData(filterData)
    }
    
    func rowDelete(data: StudentTable) {
        let newData = StudentTable(name: data.name, studentPhoneNum: data.studentPhoneNum, parentPhoneNum: data.parentPhoneNum, address: data.address, memo: data.memo)
        newData._id = data._id
        newData.ishidden = true
        realmRepository.update(data: data)
        
        state.value = .rowDelete
    }
}
