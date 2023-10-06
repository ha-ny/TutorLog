//
//  RealmModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/02.
//

import Foundation
import RealmSwift

class RealmModel {

    func readData(filterName: String = "") -> Results<StudentTable>? {
        do {
            let realm = try Realm()
            var task = realm.objects(StudentTable.self).sorted(by: \.name)
            
            if !filterName.isEmpty {
                task = task.where {
                    $0.name.contains(filterName)
                }
            }

            return task
            
        } catch {
            return nil
        }
    }
    
    func createData(data: StudentTable) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch {
            
        }
    }
}
