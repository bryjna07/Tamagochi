//
//  MainViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    
    private lazy var profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil)
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }

    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "대장님의 다마고치"
        navigationItem.rightBarButtonItem = profileButton
    }
    
    private func bind() {
           profileButton.rx.tap
               .bind(with: self) { owner, _ in
                   let vc = SettingViewController()
                   owner.navigationController?.pushViewController(vc, animated: true)
               }
               .disposed(by: disposeBag)
       }

}

