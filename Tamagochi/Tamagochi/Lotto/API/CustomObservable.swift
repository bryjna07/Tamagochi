//
//  CustomObservable.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import Alamofire
import RxSwift

final class CustomObservable {
    
    static func getLotto(query: String) -> Observable<Result<Lotto, CustomError>> {
        
        return Observable<Result<Lotto, CustomError>>.create { observer in
            
            let url = "\(URL.lotto.baseURL)&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value))
                    observer.onCompleted() // 매우중요
                    
                case .failure(let error):
                    print(error)
                    observer.onNext(.failure(.invalid))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
            
        }
    }
    
    static func getMovie(date: String) -> Single<Result<BoxOffice, CustomError>> {
        
        return Single.create { observer in
            
            let url = "\(URL.movie.baseURL)key=\(MovieAPI.Key)&targetDt=\(date)"
            
            AF.request(url).responseDecodable(of: BoxOffice.self) { response in
                switch response.result {
                case .success(let value):
                    print("API 성공")
//                    print(value)
                    observer(.success(.success(value)))
                    
                case .failure(let error):
                    print(error)
                    observer(.success(.failure(.invalid)))
                }
            }
            
            return Disposables.create()
            
        }
    }
    
//    static func getMovie(date: String) -> Observable<[Movie]> {
//        
//        return Observable<[Movie]>.create { observer in
//            
//            let url = "\(URL.movie.baseURL)key=\(MovieAPI.Key)&targetDt=\(date)"
//            
//            AF.request(url).responseDecodable(of: BoxOffice.self) { response in
//                switch response.result {
//                case .success(let value):
////                    print(value)
//                    
//                    observer.onNext(value.boxOffice.movieList)
//                    observer.onCompleted() // 매우중요
//                    
//                case .failure(let error):
////                    print(error)
//                    observer.onError(CustomError.invalid)
//                }
//            }
//            
//            return Disposables.create()
//            
//        }
//    }
}
