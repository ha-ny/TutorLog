//
//  Model.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/03.
//

import Foundation
import UIKit

enum Days: Int {
    case sun
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
}

//[시작 시간, 끝시간, 요일] 배열로
enum TimeType: Int {
    case startHour
    case startMinute
    case endHour
    case endMinute
}

struct weekTime {

    var week: Int
    var startTime: Date //2:54
    var endTime: Date

    init(week: Int, startTime: Date, endTime: Date) {
        self.week = week
        self.startTime = startTime
        self.endTime = endTime
    }
}

func okAlert(message: String) -> UIAlertController {
    let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "확인", style: .default)
    alert.addAction(ok)
    return alert
}
