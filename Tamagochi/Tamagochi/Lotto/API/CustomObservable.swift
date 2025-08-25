//
//  CustomObservable.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import Alamofire
import RxSwift

enum CustomError: Error {
    case invalid
}

final class CustomObservable {
    
    static func getLotto(query: String) -> Observable<Lotto> {
        
        return Observable<Lotto>.create { observer in
            
            let url = "\(URL.lotto.baseURL)&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
//                    print(value)
                    
                    observer.onNext(value)
                    observer.onCompleted() // 매우중요
                    
                case .failure(let error):
//                    print(error)
                    observer.onError(CustomError.invalid)
                }
            }
            
            return Disposables.create()
            
        }
    }
    
    static func getMovie(date: String) -> Observable<[Movie]> {
        
        return Observable<[Movie]>.create { observer in
            
            let url = "\(URL.movie.baseURL)key=\(MovieAPI.Key)&targetDt=\(date)"
            
            AF.request(url).responseDecodable(of: BoxOffice.self) { response in
                switch response.result {
                case .success(let value):
//                    print(value)
                    
                    observer.onNext(value.boxOffice.movieList)
                    observer.onCompleted() // 매우중요
                    
                case .failure(let error):
//                    print(error)
                    observer.onError(CustomError.invalid)
                }
            }
            
            return Disposables.create()
            
        }
    }
}
