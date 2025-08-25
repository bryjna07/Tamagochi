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
    private let viewModel: StartDetailViewModel
    
    init(viewModel: StartDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
        let input = StartDetailViewModel.Input(
            viewDidLoad: Observable.just(()),
            startButtonTap: detailView.startButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.tamagochi
            .drive(with: self) { owner, value in
                owner.detailView.imageView.image = UIImage(named: value.imageName)
                owner.detailView.nameView.nameLabel.text = value.name
                owner.detailView.detailLabel.text = value.text
            }
            .disposed(by: disposeBag)
        
        detailView.cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.startButtonTap
            .drive(with: self) { owner, _ in
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    let vm = MainViewModel(data: owner.viewModel.tamagochi)
                    let vc = MainViewController(viewModel: vm)
                    let nav = UINavigationController(rootViewController: vc)
                    sceneDelegate.changeRootViewController(nav)
                }
            }
            .disposed(by: disposeBag)
    }
}
