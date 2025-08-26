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
    let tamagochi: TamagochiData?
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
    
    init(data: TamagochiData?) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        
        let tamagochiRelay = BehaviorRelay<Tamagochi?>(value: nil)
        let infoRelay = BehaviorRelay(value: "")
        
        // 선택된 다마고치 꺼내오기
        input.viewDidLoad
            .subscribe(with: self) { owner, _ in
                if let selectedData = owner.manager.selectedTamagochi() {
                    let tamagochi = selectedData.tamagochi
                    tamagochiRelay.accept(tamagochi)
                    let info = owner.caculateLevel(tamagochi: selectedData)
                    infoRelay.accept(info)
                }
            }
            .disposed(by: disposeBag)
        
        // 밥 먹기
        input.riceButtonTap
            .map { Int($0) ?? 1 }
            .subscribe(with: self) { owner, count in
                guard count > 0, count <= 99 else { return }
        
            }
            .disposed(by: disposeBag)
        
        // 물 먹기
        input.waterButtonTap
            .map { Int($0) ?? 1 }
            .subscribe(with: self) { owner, count in
     
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagochi: tamagochiRelay.compactMap { $0 }.asDriver(onErrorDriveWith: .empty()),
            info: infoRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    func caculateLevel(tamagochi: TamagochiData) -> String {
        let calc = (tamagochi.riceCount / 5) + (tamagochi.waterCount / 2)
        let level = 1 + (calc / 10)
        
        return "LV\(min(level, 10)) - 밥알 \(tamagochi.riceCount)개 - 물방울 \(tamagochi.waterCount)개"
    }
    
//    var imageName: String {
//        switch name {
//        case "따끔따끔 다마고치":
//            return "1-\(level)"
//        case "방실방실 다마고치":
//            return "2-\(level)"
//        case "반짝반짝 다마고치":
//            return "3-\(level)"
//        default:
//            return "noImage"
//        }
//    }
}
