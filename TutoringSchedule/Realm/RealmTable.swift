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

class classTable: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var className: String
    @Persisted var tutoringPlace: String
    @Persisted var studentPK: List<String>

    convenience init(className: String, tutoringPlace: String, studentPK: List<String>) {
        self.init()
        self.className = className
        self.tutoringPlace = tutoringPlace
        self.studentPK = studentPK
    }
}

class ScheduleTable: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var classPK: String
    @Persisted var day: Int
    @Persisted var startTime: Date
    @Persisted var endTime: Date

    convenience init(classPK: String, day: Int, startTime: Date, endTime: Date) {
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
    @Persisted var SchedulePK: String
    @Persisted var startTime: Date?
    @Persisted var endTime: Date?

    convenience init(date: Date, SchedulePK: String, startTime: Date?, endTime: Date?) {
        self.init()
        self.date = date
        self.SchedulePK = SchedulePK
        self.startTime = startTime
        self.endTime = endTime
    }
}

class TutoringLogTable: Object {

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var calendarPK: String
    @Persisted var contents: String
    @Persisted var homework: String

    convenience init(calendarPK: String, contents: String, homework: String) {
        self.init()
        self.calendarPK = calendarPK
        self.contents = contents
        self.homework = homework
    }
}
