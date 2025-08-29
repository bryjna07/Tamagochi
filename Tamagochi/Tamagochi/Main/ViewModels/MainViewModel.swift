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
            .map { $0.isEmpty ? "1" : $0 }
            .map { text -> Result<Int, TamagochiError> in
                do throws(TamagochiError) {
                    return .success(try self.textValidate(text: text, type: .rice))
                } catch {
                    return .failure(error)
                }
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let num):
                    owner.updateTamagochi(num: num, type: .rice)
                    tamagochiRelay.accept(owner.tamagochi)
                case .failure(let error):
                    textError.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        // 물 먹기
        input.waterButtonTap
            .map { $0.isEmpty ? "1" : $0 }
            .map { text -> Result<Int, TamagochiError> in
                do throws(TamagochiError) {
                    return .success(try self.textValidate(text: text, type: .water))
                } catch {
                    return .failure(error)
                }
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let num):
                    owner.updateTamagochi(num: num, type: .water)
                    tamagochiRelay.accept(owner.tamagochi)
                case .failure(let error):
                    textError.accept(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(navTitle: title.asDriver(onErrorDriveWith: .empty()),
                      tamagochi: tamagochiRelay.asDriver(onErrorDriveWith: .empty()),
                      showAlert: textError.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    private func textValidate(text: String, type: FeedType) throws(TamagochiError) -> Int {
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
