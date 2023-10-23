//
//  RealmErrorType.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/23.
//

import Foundation

// Extension+UIViewController -> errorHandling

enum RealmErrorType: Error {
    case connectionFailure
    case createFailed
    case deleteFailed
}

extension RealmErrorType: LocalizedError {
    var description: (title: String, message: String) {
        switch self {
        case .connectionFailure:
            return ("연결 실패", "데이터를 연결하는 동안 문제가 발생했습니다.\n다시 시도해주세요.")
        case .createFailed:
            return ("저장 실패", "데이터를 저장하는 동안 문제가 발생했습니다.\n다시 시도해주세요.")
        case .deleteFailed:
            return ("삭제 실패", "데이터를 삭제하는 동안 문제가 발생했습니다.\n다시 시도해주세요.")
        }
    }
}
