//
//  UserDefaultsManager.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    @UserDefaultCodable(key: "tamagochiStatus", defaultValue: [
        TamagochiData(name: "따끔따끔 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false),
        TamagochiData(name: "방실방실 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false),
        TamagochiData(name: "반짝반짝 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false)
    ])
    var tamagochiData: [TamagochiData]
    
    func selectedTamagochi() -> TamagochiData? {
        return tamagochiData.first { $0.isSelected }
    }
}
