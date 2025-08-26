//
//  BoxOfficeViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: BaseViewModel {
    
    struct Input {
        let searchTap: Observable<String>
    }
    
    struct Output {
        let movie: Driver<Result<BoxOffice, CustomError>>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        let movie = input.searchTap
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable
                    .getMovie(date: text)
                    .catch { _ in
                        return Single.never()
                    }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(movie: movie)
    }
}
