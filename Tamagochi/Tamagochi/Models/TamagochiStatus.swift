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
        let calc = Double(riceCount) / 5 + Double(waterCount) / 2
        return min(max(Int(calc), 1), 9)
    }
}
