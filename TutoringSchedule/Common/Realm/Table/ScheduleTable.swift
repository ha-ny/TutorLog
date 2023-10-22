//
//  ScheduleTable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation
import RealmSwift

class ScheduleTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var classPK: ObjectId
    @Persisted var day: Int
    @Persisted var startTime: Date
    @Persisted var endTime: Date

    convenience init(classPK: ObjectId, day: Int, startTime: Date, endTime: Date) {
        self.init()
        self.classPK = classPK
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
    }
}
