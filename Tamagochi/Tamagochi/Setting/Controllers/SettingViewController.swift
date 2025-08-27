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
    
    private let settingView = SettingView()
    private let disposeBag = DisposeBag()
    private let viewModel = SettingViewModel()
    private let viewWillAppearRelay = PublishRelay<Void>()
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())
    }
    
    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "설정"
    }
    
    private func bind() {
        
        let input = SettingViewModel.Input(
//            viewDidLoad: Observable.just(()),
            viewWillAppear: viewWillAppearRelay.asObservable(),
            itemSelected: settingView.tableView.rx.itemSelected.asObservable()
        )
           
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(settingView.tableView.rx.items(cellIdentifier: SettingCell.identifier, cellType: SettingCell.self)) { (row, element, cell) in
                cell.label.text = element
                            if row == 0 {
                                let name = UserDefaultsManager.shared.userName
                                cell.nicknameLabel.text = name
                            } else {
                                cell.nicknameLabel.text = ""
                            }
            }
            .disposed(by: disposeBag)
        
        settingView.tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                if indexPath.row == 0 {
                    let vc = NicknameViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                } else if indexPath.row == 2 {
                    owner.showAlert(title: "데이터 초기화", message: "데이터를 초기화 하시겠습니까?", ok: "네") {
                        UserDefaultsManager.shared.tamagochiData = [
                            TamagochiData(name: "따끔따끔 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false),
                            TamagochiData(name: "방실방실 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false),
                            TamagochiData(name: "반짝반짝 다마고치", level: 1, riceCount: 0, waterCount: 0, isSelected: false)
                        ]
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            let startVC = StartViewController()
                            let nav = UINavigationController(rootViewController: startVC)
                            sceneDelegate.changeRootViewController(nav)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
    }
}
