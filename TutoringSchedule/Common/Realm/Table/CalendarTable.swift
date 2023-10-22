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
    @Persisted var schedulePK: ObjectId
    @Persisted var startTime: Date?  //일정 수정시 time 넣기
    @Persisted var endTime: Date?   //일정 수정시 time 넣기

    convenience init(date: Date, schedulePK: ObjectId, startTime: Date? = nil, endTime: Date? = nil) {
        self.init()
        self.date = date
        self.schedulePK = schedulePK
        self.startTime = startTime
        self.endTime = endTime
    }
}
