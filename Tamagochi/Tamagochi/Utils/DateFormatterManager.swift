//
//  DateFormatterManager.swift
//  Tamagochi
//
//  Created by YoungJin on 8/29/25.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()
    private init() { }
    
    let formatter = DateFormatter()
    
    let today = Date()
    
    func todayForNumber() -> Int {
        formatter.dateFormat = "yyyyMMdd"
        return Int(formatter.string(from: today)) ?? 0
    }
}
