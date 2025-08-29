//
//  BoxOfficeViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: BaseViewModel {
    
    struct Input {
        let searchTap: Observable<String>
    }
    
    struct Output {
        let movie: Driver<[Movie]>
        let networkError: Driver<CustomError>
        let showAlert: Driver<BoxOfficeTextError>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        let alert = PublishRelay<BoxOfficeTextError>()
        let networkError = PublishRelay<CustomError>()
        
        let movie = input.searchTap
            .distinctUntilChanged()
            .flatMap { [weak self] text -> Single<Result<BoxOffice, CustomError>> in
                guard let self else { return .never() }
                
                // 텍스트 검증
                do throws(BoxOfficeTextError) {
                    let validText = try self.validate(text: text)
                    return CustomObservable.getMovie(date: validText)
                } catch {
                    // 텍스트 검증 에러 -> 알럿
                    alert.accept(error)
                    return .never()
                }
            }
            .map { response in
                switch response {
                case .success(let data):
                    return data.boxOffice.movieList
                case .failure(let error):
                    networkError.accept(error)
                    return []
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(movie: movie, networkError: networkError.asDriver(onErrorDriveWith: .empty()), showAlert: alert.asDriver(onErrorDriveWith: .empty()))
    }
    
    // 텍스트 검증 로직
    private func validate(text: String) throws(BoxOfficeTextError) -> String {
        if text.isEmpty {
            throw .isEmpty
        }
        guard let num = Int(text) else {
            throw .notInt
        }
        let today = DateFormatterManager.shared.todayForNumber()
        guard (20101010...today).contains(num) else {
            throw .textCount
        }
        return text
    }
}
