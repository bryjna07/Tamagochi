//
//  MainViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel {
    
    private let disposeBag = DisposeBag()
    let tamagochi: Tamagochi
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let tamagochi: Driver<Tamagochi>
    }
    
    init(data: Tamagochi) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        let tamagochiRelay = BehaviorRelay<Tamagochi?>(value: nil)
        
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                tamagochiRelay.accept(owner.tamagochi)
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagochi: tamagochiRelay
                .compactMap { $0 }
                .asDriver(onErrorDriveWith: .empty())
        )
    }
}
