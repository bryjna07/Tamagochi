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
        let viewWillAppear: Observable<Void>
        let riceButtonTap: Observable<String>
        let waterButtonTap: Observable<String>
    }
    
    struct Output {
        let navTitle: Driver<String>
        let tamagochi: Driver<Tamagochi>
        let info: Driver<String>
        let showAlert: Driver<TamagochiError>
    }
    
    init(data: TamagochiData?) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        
        let title = PublishRelay<String>()
        let tamagochiRelay = BehaviorRelay<Tamagochi?>(value: nil)
        let infoRelay = BehaviorRelay(value: "")
        let textError = PublishRelay<TamagochiError>()
        
        // 선택된 다마고치 꺼내오기
        input.viewDidLoad
            .subscribe(with: self) { owner, _ in
                if let selectedData = owner.manager.selectedTamagochi() {
                    let tamagochi = selectedData.tamagochi
                    tamagochiRelay.accept(tamagochi)
                    infoRelay.accept(owner.makeInfoText(for: selectedData))
                }
            }
            .disposed(by: disposeBag)
        
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
                if let updated = owner.manager.selectedTamagochi() {
                    tamagochiRelay.accept(updated.tamagochi)
                    infoRelay.accept(owner.makeInfoText(for: updated))
                }
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
                if let updated = owner.manager.selectedTamagochi() {
                    tamagochiRelay.accept(updated.tamagochi)
                    infoRelay.accept(owner.makeInfoText(for: updated))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(navTitle: title.asDriver(onErrorDriveWith: .empty()),
                      tamagochi: tamagochiRelay.compactMap { $0 }.asDriver(onErrorDriveWith: .empty()),
                      info: infoRelay.asDriver(onErrorDriveWith: .empty()),
                      showAlert: textError.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    private func makeInfoText(for tamagochi: TamagochiData) -> String {
        return "LV\(tamagochi.level) - 밥 \(tamagochi.riceCount)개 - 물방울 \(tamagochi.waterCount)개"
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
        guard var tamagochiData = manager.selectedTamagochi() else { return }
        
        switch type {
        case .rice:
            tamagochiData.riceCount = min(tamagochiData.riceCount + num, 999)
        case .water:
            tamagochiData.waterCount = min(tamagochiData.waterCount + num, 999)
        }
        
        // 레벨 계산
        let calc = (tamagochiData.riceCount / 5) + (tamagochiData.waterCount / 2)
        tamagochiData.level = min(1 + (calc / 10), 10)
        manager.updateSelectedTamagochi(tamagochiData)
    }
}
