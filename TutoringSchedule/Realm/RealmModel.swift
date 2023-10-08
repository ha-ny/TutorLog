//
//  RealmModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/02.
//

import Foundation
import RealmSwift

/////Users/hany/Library/Developer/CoreSimulator/Devices/502D4491-E960-4248-8FEE-E1BAE9CC425A/data/Containers/Data/Application/005E0E6F-8335-4EC1-9189-2095C2B5745A/Documents/default.realm
///
class RealmModel {

    static let shared = RealmModel()
    private init() { }
    
    let realm = try? Realm()

    func read<T: Object>(_ object: T.Type) -> Results<T>? {
        guard let realm else { return nil }
        
        return realm.objects(object)
    }
    
    func create<T: Object>(data: T) {
        guard let realm else { return }
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            
        }
    }
    
//    func update<T: Object>(data: T) {
//        guard let realm else { return }
//
//        do {
//            try realm.write {
//                realm.add(data, update: true)
//            }
//        } catch {
//
//        }
//    }
    
    func delete<T: Object>(data: T) {
        guard let realm else { return }
        
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            
        }
    }
}
