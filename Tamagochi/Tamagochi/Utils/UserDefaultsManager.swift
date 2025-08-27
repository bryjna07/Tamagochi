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
        TamagochiData(id: 1, name: "따끔따끔 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false),
        TamagochiData(id: 2, name: "방실방실 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false),
        TamagochiData(id: 3, name: "반짝반짝 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false)
    ])
    var tamagochiData: [TamagochiData]
    
    @UserDefault(key: "userName", defaultValue: "대장")
    var userName: String
    
    func selectedTamagochi() -> TamagochiData? {
        return tamagochiData.first { $0.isSelected }
    }

    func updateSelectedTamagochi(_ tamagochi: TamagochiData) {
        guard let index = tamagochiData.firstIndex(where: { $0.name == tamagochi.name }) else { return }
        tamagochiData[index] = tamagochi
    }
}
