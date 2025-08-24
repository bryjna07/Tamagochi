//
//  SettingViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    let settingView = SettingView()
    private let disposeBag = DisposeBag()
    
    private let data = BehaviorRelay(value: [
        "tesT1", "TEST2", "TEST3",]
    )
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "설정"
    }
    
    private func bind() {
        
        data
            .asDriver(onErrorDriveWith: .empty())
            .drive(settingView.tableView.rx.items(cellIdentifier: SettingCell.identifier, cellType: SettingCell.self)) { (row, element, cell) in
                
            }
            .disposed(by: disposeBag)
        
        settingView.tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                if indexPath.row == 0 {
                    let vc = NicknameViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
    }

}
