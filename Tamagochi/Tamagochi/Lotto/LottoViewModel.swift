//
//  LottoViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel: BaseViewModel {
    
    struct Input {
        let searchTap: Observable<String>
    }
    
    struct Output {
        let lotto: Driver<Result<Lotto, CustomError>>
        let showAlert: Driver<LottoTextError>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        let alert = PublishRelay<LottoTextError>()
        
        /// 1번 텍스트 검증 x
        //        let lottoResult = validatedText
        //            .distinctUntilChanged()
        //            .flatMap { text in
        //                CustomObservable
        //                    .getLotto(query: text)
        //            }
        //            .asDriver(onErrorDriveWith: .empty())
        
        /// 4번
        let lottoResult = input.searchTap
            .distinctUntilChanged()
            .flatMapLatest { [weak self] text -> Observable<Result<Lotto, CustomError>> in
                guard let self else { return .empty() }
                
                // 텍스트 검증
                do throws(LottoTextError) {
                    let validText = try self.validate(text: text)
                    return CustomObservable.getLotto(query: validText)
                } catch {
                    // 텍스트 검증 에러 -> 알럿
                    alert.accept(error)
                    return .empty()
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        /// 3번
        //            let lottoResult = input.searchTap
        //                .flatMap { value -> Observable<String> in
        //                    if value.isEmpty {
        //                        alert.accept(.notInt)
        //                        return .empty()
        //                    }
        //                    guard let num = Int(value) else {
        //                        alert.accept(.notInt)
        //                        return .empty()
        //                    }
        //                    guard num > 1, num < 1187 else {
        //                        alert.accept(.textCount)
        //                        return .empty()
        //                    }
        //                    return .just(value)
        //                }
        //                .distinctUntilChanged()
        //                .flatMapLatest { text in
        //                    CustomObservable.getLotto(query: text)
        //                }
        //                .asDriver(onErrorDriveWith: .empty())
        
        /// 2번
        //        let lottoResult = input.searchTap
        //            .compactMap { text in
        //                guard let value = text, !value.isEmpty else {
        //                    alert.accept(.notInt)
        //                    return nil
        //                }
        //                guard let num = Int(value) else {
        //                    alert.accept(.notInt)
        //                    return nil
        //                }
        //                guard num > 1, num < 1187 else {
        //                    alert.accept(.textCount)
        //                    return nil
        //                }
        //                return text
        //            }
        //            .distinctUntilChanged()
        //            .flatMap { text in
        //                CustomObservable
        //                    .getLotto(query: text)
        //            }
        //            .asDriver(onErrorDriveWith: .empty())
        
        return Output(lotto: lottoResult,
                      showAlert: alert.asDriver(onErrorDriveWith: .empty()))
    }
    
    // 텍스트 검증 로직
    private func validate(text: String) throws(LottoTextError) -> String {
        if text.isEmpty {
            throw .isEmpty
        }
        guard let num = Int(text) else {
            throw .notInt
        }
        guard (1...1187).contains(num) else {
            throw .textCount
        }
        return text
    }
}
