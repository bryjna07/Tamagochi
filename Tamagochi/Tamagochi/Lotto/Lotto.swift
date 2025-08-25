//
//  Lotto.swift
//  SeSAC7WEEK4CodeBase
//
//  Created by YoungJin on 7/24/25.
//

import Foundation

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
    var allLotto: String {
        return "\(drwtNo1) - \(drwtNo2) - \(drwtNo3) - \(drwtNo4) - \(drwtNo5) - \(drwtNo6) / 보너스: \(bnusNo)"
    }
}
