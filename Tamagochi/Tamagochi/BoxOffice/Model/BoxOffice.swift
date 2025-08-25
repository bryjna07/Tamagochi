//
//  BoxOffice.swift
//  SeSAC7WEEK4CodeBase
//
//  Created by YoungJin on 7/24/25.
//

import Foundation

struct BoxOffice: Decodable {
    let boxOffice: DailyBoxOffice
    
    enum CodingKeys: String, CodingKey {
        case boxOffice = "boxOfficeResult"
    }
}

struct DailyBoxOffice: Decodable {
    let movieList: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movieList = "dailyBoxOfficeList"
    }
}

struct Movie: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
