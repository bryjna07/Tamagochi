//
//  LottoViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import UIKit
import Alamofire
import Then
import SnapKit
import RxSwift
import RxCocoa

final class LottoViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let searchField = FeedingView(placeholder: "로또검색", buttonImage: nil, buttonName: "검색")
    
    let resultLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        
        searchField.button.rx.tap
            .withLatestFrom(searchField.textField.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable
                    .getLotto(query: text)
            }
            .subscribe(with: self) { owner, lotto in
               print("onNext", lotto)
                owner.resultLabel.text = lotto.allLotto
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(searchField)
        view.addSubview(resultLabel)
        
        searchField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.height.equalTo(44)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }
    
}
 
