//
//  AlertMessageType.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/23.
//

import Foundation

// Extension+UIViewController -> errorHandling
enum AlertMessageType {
    case missingName
    case invalidNumberFormat
    case startTimeSaveFailure
    case endTimeSaveFailure
    case invalidTimeRange
    case startDateAfterEndDate
    case missingClassName
    case dateCreationError
}

extension AlertMessageType {
    var description: (title: String, message: String) {
        switch self {
        case .missingName:
            return ("필수 정보 누락", "이름은 반드시 입력해야 합니다.")
        case .invalidNumberFormat:
            return ("유효하지 않은 번호", "숫자만 입력할 수 있습니다.\n다시 설정해주세요")
        case .startTimeSaveFailure:
            return ("시작 시간 저장 실패", "시간을 저장하는데 문제가 발생했습니다.\n다시 시도해주세요.")
        case .endTimeSaveFailure:
            return ("종료 시간 저장 실패", "숫자만 입력 가능합니다.\n다시 시도해주세요.")
        case .invalidTimeRange:
            return ("유효하지 않은 시간", "시작 시간이 종료 시간보다 더 큽니다.\n다시 설정해주세요")
        case .startDateAfterEndDate:
            return ("유효하지 않은 기간", "시작일이 종료일보다 늦습니다.\n다시 설정해주세요")
        case .missingClassName:
            return ("필수 정보 누락", "수업명은 반드시 입력해야 합니다.")
        case .dateCreationError:
            return ("날짜 생성 오류", "날짜를 생성하는 중에 문제가 발생했습니다.\n다시 시도해주세요")
        }
    }
}
