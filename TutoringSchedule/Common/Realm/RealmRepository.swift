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
    
    func read<T: Object>(_ object: T.Type) throws -> [T] {
        guard let realm else { throw RealmErrorType.connectionFailure }
        return Array(realm.objects(object))
    }

    func create<T: Object>(data: T) throws {
        guard let realm else { throw RealmErrorType.connectionFailure }
        
        do {
            try realm.write {
                realm.add(data, update: .modified)
            }
        } catch {
            throw RealmErrorType.createFailed
        }
    }

    func delete<T: Object>(data: [T]) throws {
        guard let realm else { throw RealmErrorType.connectionFailure }
        
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            throw RealmErrorType.deleteFailed
        }
    }
}
