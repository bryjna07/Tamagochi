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
    }
    
    init(data: TamagochiData?) {
        self.tamagochi = data
    }
    
    func transform(input: Input) -> Output {
        
        let title = PublishRelay<String>()
        let tamagochiRelay = BehaviorRelay<Tamagochi?>(value: nil)
        let infoRelay = BehaviorRelay(value: "")
        
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
                let count: Int
                if text.isEmpty {
                    count = 1
                } else if let num = Int(text), num >= 1, num <= 99 {
                    count = num
                } else {
//                    owner.showAlert(title: "입력 오류", message: "1~99 사이의 숫자를 입력해주세요.")
                    return
                }
                
                guard var tamagochiData = owner.manager.selectedTamagochi() else { return }
                // 최대 riceCount 999 체크
                tamagochiData.riceCount = min(tamagochiData.riceCount + count, 999)
                // 레벨 계산
                let calc = (tamagochiData.riceCount / 5) + (tamagochiData.waterCount / 2)
                tamagochiData.level = min(1 + (calc / 10), 10)
                owner.manager.updateSelectedTamagochi(tamagochiData)
                if let updated = owner.manager.selectedTamagochi() {
                    tamagochiRelay.accept(updated.tamagochi)
                    infoRelay.accept(owner.makeInfoText(for: updated))
                }
            }
            .disposed(by: disposeBag)

        // 물 먹기
        input.waterButtonTap
            .subscribe(with: self) { owner, text in
                let count: Int
                if text.isEmpty {
                    count = 1
                } else if let num = Int(text), num >= 1, num <= 49 {
                    count = num
                } else {
//                    owner.showAlert(title: "입력 오류", message: "1~49 사이의 숫자를 입력해주세요.")
                    return
                }
                
                guard var tamagochiData = owner.manager.selectedTamagochi() else { return }
                // 최대 waterCount 999 체크
                tamagochiData.waterCount = min(tamagochiData.waterCount + count, 999)
                // 레벨 계산
                let calc = (tamagochiData.riceCount / 5) + (tamagochiData.waterCount / 2)
                tamagochiData.level = min(1 + (calc / 10), 10)
                owner.manager.updateSelectedTamagochi(tamagochiData)
                if let updated = owner.manager.selectedTamagochi() {
                    tamagochiRelay.accept(updated.tamagochi)
                    infoRelay.accept(owner.makeInfoText(for: updated))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(navTitle: title.asDriver(onErrorDriveWith: .empty()),
            tamagochi: tamagochiRelay.compactMap { $0 }.asDriver(onErrorDriveWith: .empty()),
            info: infoRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
    
    private func makeInfoText(for tamagochi: TamagochiData) -> String {
        return "LV\(tamagochi.level) - 밥 \(tamagochi.riceCount)개 - 물방울 \(tamagochi.waterCount)개"
    }
}
