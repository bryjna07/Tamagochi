//
//  CustomError.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation

enum CustomError: Error {
    case invalid
    
    var errorText: String {
        switch self {
        case .invalid:
            return "네트워크 에러"
        }
    }
}

enum LottoTextError: Error {
    case isEmpty
    case notInt
    case textCount
    
    var errorText: String {
        switch self {
        case .isEmpty:
            return "검색어를 입력해주세요"
        case .notInt:
            return "숫자를 입력해주세요"
        case .textCount:
            return "1~1186 사이 숫자를 입력하세요"
        }
    }
}

enum BoxOfficeTextError: Error {
    case isEmpty
    case notInt
    case textCount
    
    var errorText: String {
        switch self {
        case .isEmpty:
            return "검색어를 입력해주세요"
        case .notInt:
            return "숫자를 입력해주세요"
        case .textCount:
            let today = DateFormatterManager.shared.todayForNumber()
            return "20101010 ~ \(today) 사이 숫자를 입력하세요"
        }
    }
}
