//
//  MainViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func setupNaviBar() {
        super.setupNaviBar()
        navigationItem.title = "대장님의 다마고치"
    }

}

