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
    
    @UserDefaultCodable(
        key: "tamagochiStatus",
        defaultValue: [
            "따끔따끔 다마고치": TamagochiStatus(riceCount: 0, waterCount: 0),
            "방실방실 다마고치": TamagochiStatus(riceCount: 0, waterCount: 0),
            "반짝반짝 다마고치": TamagochiStatus(riceCount: 0, waterCount: 0)
        ]
    )
    
    var tamagochiStatus: [String: TamagochiStatus]
    
    // 현재 선택된 다마고치 이름 저장
    @UserDefault(key: "selectedTamagochiName", defaultValue: "")
    var selectedTamagochiName: String
    
    // 저장 최대값
    private let maxRice = 999
    private let maxWater = 999
    
    func updateStatus(name: String, rice: Int? = nil, water: Int? = nil) {
        var all = tamagochiStatus
        if var status = all[name] {
            if let rice = rice { status.riceCount += rice }
            if let water = water { status.waterCount += water }
            all[name] = status
        }
        tamagochiStatus = all
    }
    
    func status(for name: String) -> TamagochiStatus? {
        tamagochiStatus[name]
    }
    
    func image(tamagochiName: String) -> String {
        guard let status = tamagochiStatus[tamagochiName] else { return "noImage" }
        let level = status.level
        switch tamagochiName {
        case "따끔따끔 다마고치":
            return "1-\(level)"
        case "방실방실 다마고치":
            return "2-\(level)"
        case "반짝반짝 다마고치":
            return "3-\(level)"
        default:
            return "noImage"
        }
    }
    
    // 밥 먹기
    func feedRice(name: String, count: Int) {
        guard var status = tamagochiStatus[name] else { return }
        guard status.riceCount + count <= maxRice else { return }
        updateStatus(name: name, rice: count, water: 0)
    }
    
    // 물 먹기
    func feedWater(name: String, count: Int) {
        guard var status = tamagochiStatus[name] else { return }
        guard status.waterCount + count <= maxWater else { return }
        updateStatus(name: name, rice: 0, water: count)
    }
    
    func resetAll() {
        tamagochiStatus = [
            "따끔따끔 다마고치": TamagochiStatus(riceCount: 0, waterCount: 0),
            "방실방실 다마고치": TamagochiStatus(riceCount: 0, waterCount: 0),
            "반짝반짝 다마고치": TamagochiStatus(riceCount: 0, waterCount: 0)
        ]
        selectedTamagochiName = ""
    }
}
