//
//  StartViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class StartViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let modelSelected: ControlEvent<Tamagochi>
    }
    
    struct Output {
        let tamagochis: Driver<[Tamagochi]>
        let selectedTamagochi: Driver<Tamagochi>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        let tamagochiRelay = BehaviorRelay<[Tamagochi]>(value: [])
        
        input.viewDidLoad
            .map {
                Tamagochi.tamagochis
            }
            .bind(to: tamagochiRelay)
            .disposed(by: disposeBag)
        
        let selected = input.modelSelected
            .filter { $0.isAvailable }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(tamagochis: tamagochiRelay.asDriver(),
                      selectedTamagochi: selected
        )
    }
}
