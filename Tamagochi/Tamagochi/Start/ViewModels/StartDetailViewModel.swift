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
        let startButtonTap: Observable<Void>
    }
    
    struct Output {
        let tamagochi: Driver<Tamagochi>
        let startButtonTap: Driver<Void>
    }
    
    init(data: Tamagochi) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        let tamagochiRelay = BehaviorRelay<Tamagochi>(value: Tamagochi(name: "준비중입니다", imageName: "noImage", text: "", isAvailable: false))
        
        let startRelay = PublishRelay<Void>()
        
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                tamagochiRelay.accept(owner.tamagochi)
            }
            .disposed(by: disposeBag)
        
        input.startButtonTap
            .bind(with: self) { owner, _ in
                UserDefaultsManager.shared.selectedTamagochiName = owner.tamagochi.name
                startRelay.accept(())
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagochi: tamagochiRelay.asDriver(onErrorDriveWith: .empty()),
            startButtonTap: startRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
