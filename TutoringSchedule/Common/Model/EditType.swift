//
//  EditType.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/23.
//

import Foundation

enum EditType<T> {
    case create
    case update(T)
}
