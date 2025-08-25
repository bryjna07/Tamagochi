//
//  TamagochiStatus.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation

struct TamagochiStatus: Codable {
    var riceCount: Int
    var waterCount: Int
    
    var level: Int {
        let calc = (riceCount / 5) + (waterCount / 2)
        let level = 1 + (calc / 10)
        return min(level, 10)
    }
}
