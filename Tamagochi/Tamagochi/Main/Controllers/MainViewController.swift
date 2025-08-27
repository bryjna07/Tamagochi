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
    private let viewWillAppearRelay = PublishRelay<Void>()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())
    }

    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.rightBarButtonItem = profileButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func bind() {
        
        let input = MainViewModel.Input(
            viewDidLoad: Observable.just(()),
            viewWillAppear: viewWillAppearRelay.asObservable(),
            riceButtonTap: mainView.riceFeedingView.button.rx.tap
                .withLatestFrom(mainView.riceFeedingView.textField.rx.text.orEmpty),
            waterButtonTap: mainView.waterFeedingView.button.rx.tap
                .withLatestFrom(mainView.waterFeedingView.textField.rx.text.orEmpty),
        )

        let output = viewModel.transform(input: input)
        
        output.navTitle
            .drive(with: self) { owner, value in
                owner.navigationItem.title = "\(value)님의 다마고치"
            }
            .disposed(by: disposeBag)
        
        output.tamagochi
            .drive(with: self) { owner, value in
                owner.mainView.tamagochiImageView.image = UIImage(named: value.imageName)
                owner.mainView.nameView.nameLabel.text = value.name
                owner.mainView.infoLabel.text = value.infoText
            }
            .disposed(by: disposeBag)

        output.showAlert
            .drive(with: self) { owner, value in
                owner.showAlert(title: "입력오류", message: value.errorText, ok: "확인") { }
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
