//
//  TamagochiData.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation

struct TamagochiData: Codable {
    let id: Int
    let name: String
    var level: Int
    var riceCount: Int
    var waterCount: Int
    var isSelected: Bool
    
    var imageName: String {
        let currentLevel = min(level, 9)
        return "\(id)-\(currentLevel)"
    }
    
    var infoText: String {
        return "LV\(level) - 밥 \(riceCount)개 - 물방울 \(waterCount)개"
    }
}
