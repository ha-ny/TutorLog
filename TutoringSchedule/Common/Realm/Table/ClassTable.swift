//
//  ClassTable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation
import RealmSwift

class ClassTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var className: String
    @Persisted var tutoringPlace: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var studentPK: List<String>
    @Persisted var ishidden: Bool = false

    convenience init(className: String, tutoringPlace: String, startDate: Date, endDate: Date, studentPK: [String]) {
        self.init()
        self.className = className
        self.tutoringPlace = tutoringPlace
        self.startDate = startDate
        self.endDate = endDate
        self.studentPK.append(objectsIn: studentPK)
        self.ishidden = ishidden
    }
}
