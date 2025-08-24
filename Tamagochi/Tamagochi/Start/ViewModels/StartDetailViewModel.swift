//
//  StartDetailViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class StartDetailViewModel {
    
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
        let tamagochiRelay = BehaviorRelay<Tamagochi>(value: Tamagochi(name: "준비중입니다", image: .no, text: "", isAvailable: false))
        
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                tamagochiRelay.accept(owner.tamagochi)
            }
            .disposed(by: disposeBag)
 
        return Output(tamagochi: tamagochiRelay.asDriver(onErrorDriveWith: .empty()))
    }
}
