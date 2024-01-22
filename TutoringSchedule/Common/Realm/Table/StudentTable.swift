//
//  StudentTable.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/21.
//

import Foundation
import RealmSwift

class StudentTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var studentPhoneNum: String
    @Persisted var parentPhoneNum: String
    @Persisted var signatureColor: String
    
    @Persisted var className: String
    @Persisted var tutoringPlace: String
    @Persisted var startDate: Date

    convenience init(name: String, studentPhoneNum: String, parentPhoneNum: String, signatureColor: String, address: String, memo: String, className: String, tutoringPlace: String, startDate: Date) {
        self.init()
        self.name = name
        self.studentPhoneNum = studentPhoneNum
        self.parentPhoneNum = parentPhoneNum
        self.signatureColor = signatureColor
        self.className = className
        self.tutoringPlace = tutoringPlace
        self.startDate = startDate
    }
}
