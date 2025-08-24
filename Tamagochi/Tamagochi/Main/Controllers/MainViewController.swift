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
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil)
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
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
        
        let input = MainViewModel.Input(viewDidLoad: Observable.just(()))

        let output = viewModel.transform(input: input)
        
        output.tamagochi
            .drive(with: self) { owner, value in
                owner.mainView.tamagochiImageView.image = value.image
                owner.mainView.nameView.nameLabel.text = value.name
            }
            .disposed(by: disposeBag)
        
        
           profileButton.rx.tap
               .bind(with: self) { owner, _ in
                   let vc = SettingViewController()
                   owner.navigationController?.pushViewController(vc, animated: true)
               }
               .disposed(by: disposeBag)
       }

}

