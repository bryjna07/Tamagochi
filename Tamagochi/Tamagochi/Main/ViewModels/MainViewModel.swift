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
    let manager = UserDefaultsManager.shared
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let riceButtonTap: Observable<String>
        let waterButtonTap: Observable<String>
    }
    
    struct Output {
        let tamagochi: Driver<Tamagochi>
        let info: Driver<String>
    }
    
    init(data: Tamagochi) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        
        let tamagochiRelay = BehaviorRelay<Tamagochi?>(value: nil)
        let infoRelay = BehaviorRelay(value: "")
        
        // 선택된 다마고치 꺼내오기
        input.viewDidLoad
            .subscribe(with: self) { owner, _ in
                let name = owner.manager.selectedTamagochiName
                if let status = owner.manager.status(for: name) {
                    let imageName = owner.manager.image(tamagochiName: name)
                    let model = Tamagochi(name: name, imageName: imageName, text: "임시", isAvailable: true)
                    tamagochiRelay.accept(model)
                    infoRelay.accept("LV\(status.level) - 밥알 \(status.riceCount)개 - 물방울 \(status.waterCount)개")
                }
            }
            .disposed(by: disposeBag)
        
        // 밥 먹기
        input.riceButtonTap
            .map { Int($0) ?? 1 }
            .subscribe(with: self) { owner, count in
                let name = owner.manager.selectedTamagochiName
                owner.manager.feedRice(name: name, count: count)
                if let status = owner.manager.status(for: name) {
                    let imageName = owner.manager.image(tamagochiName: name)
                    let model = Tamagochi(name: name, imageName: imageName, text: "임시", isAvailable: true)
                    tamagochiRelay.accept(model)
                    infoRelay.accept("LV\(status.level) - 밥알 \(status.riceCount)개 - 물방울 \(status.waterCount)개")
                }
            }
            .disposed(by: disposeBag)
        
        // 물 먹기
        input.waterButtonTap
            .map { Int($0) ?? 1 }
            .subscribe(with: self) { owner, count in
                let name = owner.manager.selectedTamagochiName
                owner.manager.feedWater(name: name, count: count)
                if let status = owner.manager.status(for: name) {
                    let imageName = owner.manager.image(tamagochiName: name)
                    let model = Tamagochi(name: name, imageName: imageName, text: "임시", isAvailable: true)
                    tamagochiRelay.accept(model)
                    infoRelay.accept("LV\(status.level) - 밥알 \(status.riceCount)개 - 물방울 \(status.waterCount)개")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagochi: tamagochiRelay.compactMap { $0 }.asDriver(onErrorDriveWith: .empty()),
            info: infoRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
