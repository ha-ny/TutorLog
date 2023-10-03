//
//  Model.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/03.
//

import Foundation

//AddScheduleViewController
//(시, 분)

struct Time {
    var start: (Int, Int)
    var end: (Int, Int)
}

class TimebyDay {

    var sun: Time?
    var mon: Time?
    var tue: Time?
    var wed: Time?
    var thu: Time?
    var fri: Time?
    var sat: Time?
    
    init(sun: Time?, mon: Time?, tue: Time?, wed: Time?, thu: Time?, fri: Time?, sat: Time?) {
        self.sun = sun
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
        self.sat = sat
    }
}
