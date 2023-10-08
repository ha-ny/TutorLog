//
//  RealmModel.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/02.
//

import Foundation
import RealmSwift

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
