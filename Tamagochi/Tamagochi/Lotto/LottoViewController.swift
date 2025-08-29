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
    
    private let viewModel: LottoViewModel
    private let disposeBag = DisposeBag()
    
    private let searchField = FeedingView(placeholder: "로또검색", buttonImage: nil, buttonName: "검색")
    
    private let resultLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    init(viewModel: LottoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {

        let input = LottoViewModel.Input(
            searchTap: Observable
                .merge(
                    searchField.textField.rx.controlEvent(.editingDidEndOnExit).asObservable(),
                    searchField.button.rx.tap.asObservable()
                )
                .withLatestFrom(searchField.textField.rx.text.orEmpty)
        )
            
        let output = viewModel.transform(input: input)
        
        output.showAlert
            .drive(with: self) { owner, error in
                owner.showAlert(title: "입력오류", message: error.errorText, ok: "확인") { }
            }
            .disposed(by: disposeBag)

        
        output.lotto
            .drive(with: self) { owner, response in
                switch response {
                case .success(let lotto):
                    owner.resultLabel.text = lotto.allLotto
                case .failure(let error):
                    owner.view.makeToast(error.errorText, position: .top)
                }
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
        
        searchField.textField.returnKeyType = .done
    }
}
