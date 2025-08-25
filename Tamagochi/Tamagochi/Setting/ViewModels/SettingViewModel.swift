//
//  SettingViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel {
    
    private let disposeBag = DisposeBag()
    private let data = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화",]
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        let items: Driver<[String]>
    }

    init() { }
    
    func transform(input: Input) -> Output {
        
        let data = BehaviorRelay<[String]>(value: [])
        
        input.viewDidLoad
            .subscribe(with: self) { owner, _ in
                data.accept(owner.data)
            }
            .disposed(by: disposeBag)
        
        return Output(items: data.asDriver())
    }
}
