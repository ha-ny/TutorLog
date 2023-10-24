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
            return ("connectionFailureTitle".localized, "connectionFailureMessage".localized)
        case .createFailed:
            return ("createFailedTitle".localized, "createFailedMessage".localized)
        case .deleteFailed:
            return ("deleteFailedTitle".localized, "deleteFailedMessage".localized)
        }
    }
}
