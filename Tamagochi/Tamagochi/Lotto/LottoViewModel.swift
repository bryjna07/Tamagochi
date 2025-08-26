//
//  LottoViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel: BaseViewModel {
    
    struct Input {
        let searchTap: Observable<String>
    }
    
    struct Output {
        let lotto: Driver<Result<Lotto, CustomError>>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        let lottoResult = input.searchTap
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable
                    .getLotto(query: text)
            }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(lotto: lottoResult)
    }
}
