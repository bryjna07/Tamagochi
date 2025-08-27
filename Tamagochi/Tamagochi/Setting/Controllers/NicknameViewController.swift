//
//  NicknameViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameViewController: BaseViewController {
    
    let nicknameView = NicknameView()
    private let disposeBag = DisposeBag()
    
    private lazy var saveButton = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
    
    override func loadView() {
        view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func bind() {

        saveButton.rx.tap
            .withLatestFrom(nicknameView.textField.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                UserDefaultsManager.shared.userName = text
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

}
