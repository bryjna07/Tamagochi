//
//  Tamagochi.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import Foundation

struct Tamagochi {
    let name: String
    let imageName: String
    let text: String
    let isAvailable: Bool
    
    static var tamagochis: [Tamagochi] {
        let basicTamagochis = [
            Tamagochi(name: "따끔따끔 다마고치", imageName: "1-1", text: "저는 따끔따끔 다마고치 입니당 따끔따끔", isAvailable: true),
            Tamagochi(name: "방실방실 다마고치", imageName: "2-1", text: "저는 방실방실 다마고치 입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!", isAvailable: true),
            Tamagochi(name: "반짝반짝 다마고치", imageName: "3-1", text: "저는 반짝반짝 다마고치 입니당 반짝반짝", isAvailable: true)
        ]
        let testTamagochis = Array(repeating: Tamagochi(name: "준비중이에요", imageName: "noImage", text: "", isAvailable: false), count: 27)
        return basicTamagochis + testTamagochis
    }
}
