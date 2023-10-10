//
//  RealmRepository.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/02.
//

import Foundation
import RealmSwift

// Users/hany/Library/Developer/CoreSimulator/Devices/502D4491-E960-4248-8FEE-E1BAE9CC425A/data/Containers/Data/Application/2AB8B4E9-20E1-43F4-A549-C3F2FD8D2A6C/Documents/

protocol realmRepositoryType {
    func read<T: Object>(_ object: T.Type) -> Results<T>?
    func create<T: Object>(data: T)
    func update<T: Object>(data: T)
    func delete<T: Object>(data: T)
}

class RealmRepository: realmRepositoryType {

    private let realm = try? Realm()

//    func checkSchemaVersion() {
//        guard let realm, let url = realm.configuration.fileURL else { return }
//        
//        do {
//            let version = try schemaVersionAtURL(url)
//            print("schemaVersion", version)
//        }catch {
//            
//        }
//    }
    
    func read<T: Object>(_ object: T.Type) -> Results<T>? {
        guard let realm else { return nil }
        return realm.objects(object)
    }
    
    func create<T: Object>(data: T) {
        guard let realm else { return }
        
        do {
            try realm.write {
                print(data)
                realm.add(data)
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
