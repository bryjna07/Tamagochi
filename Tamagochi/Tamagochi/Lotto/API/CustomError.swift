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
            return "아직 진행되지 않은 회차이거나 네트워크 에러 입니다."
        }
    }
}

enum TextError: Error {
    case notInt
    case textCount
    
    var errorText: String {
        switch self {
        case .notInt:
            return "숫자를 입력해주세요"
        case .textCount:
            return "1~1186 사이 숫자를 입력하세요"
        }
    }
}
