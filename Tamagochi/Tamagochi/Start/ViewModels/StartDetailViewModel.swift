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
        let startButtonTap: Driver<TamagochiData>
    }
    
    init(data: Tamagochi) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        
        /// publishRelay가 안되는 이유 생각해보기
        let tamagochiRelay = BehaviorRelay<Tamagochi?>(value: nil)
        
        let startRelay = PublishRelay<TamagochiData>()
        
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
                    // 이름 같은 다마고치 인덱스 탐색
                    var tamagochiData = allData[index]
                    tamagochiData.isSelected = true
                    UserDefaultsManager.shared.tamagochiData = allData
                    startRelay.accept(tamagochiData)
                    print("탭바로 이동", tamagochiData)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagochi: tamagochiRelay.compactMap { $0 } .asDriver(onErrorDriveWith: .empty()),
            startButtonTap: startRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
