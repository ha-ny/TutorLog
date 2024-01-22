//
//  CalendarTable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation
import RealmSwift

class CalendarTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var weekPK: ObjectId

    convenience init(date: Date, weekPK: ObjectId) {
        self.init()
        self.date = date
        self.weekPK = weekPK
    }
}
