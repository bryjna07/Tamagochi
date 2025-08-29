//
//  TamagochiData.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
// codable
struct TamagochiData: Codable {
    let id: Int
    let name: String
    var level: Int
    var riceCount: Int
    var waterCount: Int
    var isSelected: Bool
    
    /// 모델 구조체 안에 있어도 괜찮을지 -> 서버에서 받아오는 데이터라면? DTO 라면 상관없음
    var imageName: String {
        let currentLevel = min(level, 9)
        return "\(id)-\(currentLevel)"
    }
    
    var infoText: String {
        return "LV\(level) - 밥 \(riceCount)개 - 물방울 \(waterCount)개"
    }
}
