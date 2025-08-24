//
//  StartDetailViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class StartDetailViewController: BaseViewController {
    
    let detailView = StartDetailView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
        detailView.cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }

}
