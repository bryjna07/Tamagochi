//
//  TamagochiData.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation

struct TamagochiData: Codable {
    let name: String
    var level: Int
    var riceCount: Int
    var waterCount: Int
    var isSelected: Bool
    
    var tamagochi: Tamagochi {
        switch name {
        case "따끔따끔 다마고치":
            return Tamagochi(name: name, imageName: "1-\(level)", text: "저는 따끔따끔 다마고치 입니당 따끔따끔", isAvailable: true)
        case "방실방실 다마고치":
            return Tamagochi(name: name, imageName: "2-\(level)", text: "저는 방실방실 다마고치 입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!", isAvailable: true)
        case "반짝반짝 다마고치":
            return Tamagochi(name: name, imageName: "3-\(level)", text: "저는 반짝반짝 다마고치 입니당 반짝반짝", isAvailable: true)
        default:
            return Tamagochi(name: "준비중이에요", imageName: "noImage", text: "", isAvailable: false)
        }
    }
}
