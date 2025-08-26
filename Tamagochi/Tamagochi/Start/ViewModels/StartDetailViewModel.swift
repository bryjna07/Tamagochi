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
        let tamagochiRelay = BehaviorRelay<Tamagochi>(value: Tamagochi(name: "준비중입니다", imageName: "noImage", text: "", isAvailable: true))
        
        let startRelay = PublishRelay<Void>()
        
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                tamagochiRelay.accept(owner.tamagochi)
            }
            .disposed(by: disposeBag)
        
        input.startButtonTap
            .bind(with: self) { owner, _ in
                var allData = UserDefaultsManager.shared.tamagochiData
                
                // 기존 모든 다마고치 선택 해제
                     allData = allData.map { data in
                         var mutable = data
                         mutable.isSelected = false
                         return mutable
                     }

                     if let index = allData.firstIndex(where: { $0.name == owner.tamagochi.name }) {
                         // 이미 존재하는 다마고치면 선택 상태만 변경
                         allData[index].isSelected = true
                     } else {
                         // 처음 선택된 다마고치면 새로 추가
                         let selected = TamagochiData(
                             name: owner.tamagochi.name,
                             level: 1,
                             riceCount: 0,
                             waterCount: 0,
                             isSelected: true
                         )
                         allData.append(selected)
                     }
                UserDefaultsManager.shared.tamagochiData = allData
                startRelay.accept(())
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagochi: tamagochiRelay.asDriver(onErrorDriveWith: .empty()),
            startButtonTap: startRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
