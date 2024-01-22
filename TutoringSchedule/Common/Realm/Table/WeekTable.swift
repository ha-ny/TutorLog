//
//  WeekTable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation
import RealmSwift

class WeekTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var studentPK: ObjectId
    @Persisted var day: Int
    @Persisted var startTime: Date
    @Persisted var endTime: Date

    convenience init(studentPK: ObjectId, day: Int, startTime: Date, endTime: Date) {
        self.init()
        self.studentPK = studentPK
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
    }
}
