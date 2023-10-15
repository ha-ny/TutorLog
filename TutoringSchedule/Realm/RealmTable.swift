//
//  RealmTable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/02.
//

import Foundation
import RealmSwift

class StudentTable: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var studentPhoneNum: String //Int
    @Persisted var parentPhoneNum: String //Int
    @Persisted var address: String
    @Persisted var memo: String

    //init -> id: String
    convenience init(name: String, studentPhoneNum: String, parentPhoneNum: String, address: String, memo: String) {
        self.init()
        self.name = name
        self.studentPhoneNum = studentPhoneNum
        self.parentPhoneNum = parentPhoneNum
        self.address = address
        self.memo = memo
    }
}

class ClassTable: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var className: String
    @Persisted var tutoringPlace: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var studentPK: List<ObjectId>

    convenience init(className: String, tutoringPlace: String, startDate: Date, endDate: Date, studentPK: List<ObjectId>) {
        self.init()
        self.className = className
        self.tutoringPlace = tutoringPlace
        self.startDate = startDate
        self.endDate = endDate
        self.studentPK = studentPK
    }
}

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
