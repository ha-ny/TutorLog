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
    @Persisted var address: String
    @Persisted var memo: String
    @Persisted var ishidden: Bool = false

    convenience init(name: String, studentPhoneNum: String, parentPhoneNum: String, address: String, memo: String) {
        self.init()
        self.name = name
        self.studentPhoneNum = studentPhoneNum
        self.parentPhoneNum = parentPhoneNum
        self.address = address
        self.memo = memo
        self.ishidden = ishidden
    }
}
