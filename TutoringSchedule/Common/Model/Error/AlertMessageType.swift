//
//  AlertMessageType.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/23.
//

import Foundation

// Extension+UIViewController -> errorHandling
enum AlertMessageType: Error {
    case missingName
    case invalidNumberFormat
    case startTimeSaveFailure
    case endTimeSaveFailure
    case invalidTimeRange
    case startDateAfterEndDate
    case missingClassName
    case missingDaySelection
    case dateCreationError
    case characterLimit
}

extension AlertMessageType: LocalizedError {
    var description: (title: String, message: String) {
        switch self {
        case .missingName:
            return ("missingNameTitle".localized, "missingNameMessage".localized)
        case .invalidNumberFormat:
            return ("invalidNumberFormatTitle".localized, "invalidNumberFormatMessage".localized)
        case .startTimeSaveFailure:
            return ("startTimeSaveFailureTitle".localized, "startTimeSaveFailureMessage".localized)
        case .endTimeSaveFailure:
            return ("endTimeSaveFailureTitle".localized, "endTimeSaveFailureMessage".localized)
        case .invalidTimeRange:
            return ("invalidTimeRangeTitle".localized, "invalidTimeRangeMessage".localized)
        case .startDateAfterEndDate:
            return ("startDateAfterEndDateTitle".localized, "startDateAfterEndDateMessage".localized)
        case .missingClassName:
            return ("missingClassNameTitle".localized, "missingClassNameMessage".localized)
        case .missingDaySelection:
            return ("missingDaySelectionTitle".localized, "missingDaySelectionMessage".localized)
        case .dateCreationError:
            return ("dateCreationErrorTitle".localized, "dateCreationErrorMessage".localized)
        case .characterLimit:
            return ("characterLimitTitle".localized, "characterLimitMessage".localized)
        }
    }
}
