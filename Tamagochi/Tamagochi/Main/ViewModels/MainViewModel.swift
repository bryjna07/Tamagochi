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
    var tamagochi: TamagochiData
    let manager = UserDefaultsManager.shared
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let riceButtonTap: Observable<String>
        let waterButtonTap: Observable<String>
    }
    
    struct Output {
        let navTitle: Driver<String>
        let tamagochi: Driver<TamagochiData>
        let showAlert: Driver<TamagochiError>
    }
    
    init(data: TamagochiData) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        
        let title = PublishRelay<String>()
        let tamagochiRelay = BehaviorRelay(value: tamagochi)
        let textError = PublishRelay<TamagochiError>()
        
        input.viewWillAppear
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owenr, _ in
                title.accept(UserDefaultsManager.shared.userName)
            }
            .disposed(by: disposeBag)
        
        // 밥 먹기
        input.riceButtonTap
            .subscribe(with: self) { owner, text in
                let num: Int
                do {
                    let result = try owner.textValidation(text: text, type: .rice)
                    num = result
                } catch {
                    let error = error as! TamagochiError
                    num = 0
                    textError.accept(error)
                }
                owner.updateTamagochi(num: num, type: .rice)
                tamagochiRelay.accept(owner.tamagochi)
            }
            .disposed(by: disposeBag)

        // 물 먹기
        input.waterButtonTap
            .subscribe(with: self) { owner, text in
                let num: Int
                do {
                    let result = try owner.textValidation(text: text, type: .water)
                    num = result
                } catch {
                    let error = error as! TamagochiError
                    num = 0
                    textError.accept(error)
                }
                owner.updateTamagochi(num: num, type: .water)
                tamagochiRelay.accept(owner.tamagochi)
            }
            .disposed(by: disposeBag)
        
        return Output(navTitle: title.asDriver(onErrorDriveWith: .empty()),
                      tamagochi: tamagochiRelay.asDriver(onErrorDriveWith: .empty()),
                      showAlert: textError.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    private func textValidation(text: String, type: FeedType) throws(TamagochiError) -> Int {
        guard !text.isEmpty else {
            return 1
        }
        guard let num = Int(text) else {
            throw .notInt
        }
        switch type {
        case .rice:
            guard num >= 1, num <= 99 else {
                throw .arrange(type)
            }
        case .water:
            guard num >= 1, num <= 49 else {
                throw .arrange(type)
            }
        }
        return num
    }
    
    private func updateTamagochi(num: Int, type: FeedType) {
        
        switch type {
        case .rice:
            tamagochi.riceCount = min(tamagochi.riceCount + num, 999)
        case .water:
            tamagochi.waterCount = min(tamagochi.waterCount + num, 999)
        }
        
        // 레벨 계산
        let calc = (tamagochi.riceCount / 5) + (tamagochi.waterCount / 2)
        tamagochi.level = min(1 + (calc / 10), 10)
        manager.updateSelectedTamagochi(tamagochi)
    }
}
