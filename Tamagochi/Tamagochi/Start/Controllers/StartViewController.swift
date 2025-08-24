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
    private let data = BehaviorRelay(value: [
        "tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3","tesT1", "TEST2", "TEST3",]
    )
    private let disposeBag = DisposeBag()
    
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
        data
            .asDriver(onErrorDriveWith: .empty())
            .drive(startView.collectionView.rx.items(cellIdentifier: TamagochiCell.identifier, cellType: TamagochiCell.self)) { (row, element, cell) in
                cell.nameView.nameLabel.text = element
            }
            .disposed(by: disposeBag)
        
        startView.collectionView.rx.modelSelected(String.self)
            .bind(with: self) { owner, value in
                let vc = StartDetailViewController()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

