//
//  StartViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class StartViewController: BaseViewController {
    
    private let startView = StartView()
    private let disposeBag = DisposeBag()
    private let viewModel = StartViewModel()
    
    override func loadView() {
        view = startView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }

    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "다마고치 선택하기"
    }

    private func bind() {
        let input = StartViewModel.Input(
            viewDidLoad: Observable.just(()),
            modelSelected: startView.collectionView.rx.modelSelected(Tamagochi.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.tamagochis
            .drive(startView.collectionView.rx.items(cellIdentifier: TamagochiCell.identifier, cellType: TamagochiCell.self)) { (row, element, cell) in
                cell.configureCell(data: element)
            }
            .disposed(by: disposeBag)
        
        output.selectedTamagochi
            .drive(with: self) { owner, value in
                let vm = StartDetailViewModel(data: value)
                let vc = StartDetailViewController(viewModel: vm)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

