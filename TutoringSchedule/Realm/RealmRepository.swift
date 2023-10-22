//
//  RealmRepository.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/02.
//

import Foundation
import RealmSwift

class RealmRepository {

    private let realm = try? Realm()
    
    func read<T: Object>(_ object: T.Type) -> [T]? {

        guard let realm else { return nil }
        return Array(realm.objects(object))
    }

    func create<T: Object>(data: T) {
        guard let realm else { return }
        
        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            
        }
    }
    
    func update<T: Object>(data: T) {
        guard let realm else { return }

        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {

        }
    }
    
    func delete<T: Object>(data: [T]) {
        guard let realm else { return }
        
        do {
            try realm.write {
                for i in data {
                    realm.delete(i)
                }
            }
        } catch {
            
        }
    }
}
