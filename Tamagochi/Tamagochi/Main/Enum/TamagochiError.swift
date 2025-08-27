//
//  TamagochiError.swift
//  Tamagochi
//
//  Created by YoungJin on 8/27/25.
//

import Foundation

enum TamagochiError: Error {
    case notInt
    case arrange(FeedType)
    
    var errorText: String {
        switch self {
        case .notInt:
            return "숫자를 입력해주세요"
        case .arrange(let feed):
            switch feed {
            case .rice:
                return "1~99 사이 숫자만 입력 가능합니다"
            case .water:
                return "1~49 사이 숫자만 입력 가능합니다"
            }
        }
    }
}
