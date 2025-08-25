//
//  NameSpace.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/24/25.
//

import Foundation

enum URL {
    case lotto
    case movie
    
    var baseURL: String {
        switch self {
        case .lotto:
            return "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
        case .movie:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        }
    }
}

enum MovieAPI {
    static let Key = "a436c394711da4b168f336e00666d848"
}
