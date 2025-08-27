//
//  TabBarController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//


import UIKit
import Then


final class TabBarController: UITabBarController {
    
    private let data: TamagochiData
    
    init(data: TamagochiData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        
        let mainVM = MainViewModel(data: data)
        let mainVC = MainViewController(viewModel: mainVM)
        let first = UINavigationController(rootViewController: mainVC).then {
            $0.tabBarItem = UITabBarItem(
                title: "다마고치",
                image: nil,
                tag: 0
            )
        }
        
        let lottoVM = LottoViewModel()
        let lottoVC = LottoViewController(viewModel: lottoVM)
        let second = UINavigationController(rootViewController: lottoVC).then {
            $0.tabBarItem = UITabBarItem(
                title: "로또",
                image: nil,
                tag: 1
            )
        }
        
        let boxOfficeVM = BoxOfficeViewModel()
        let boxOfiiceVC = BoxOfficeViewController(viewModel: boxOfficeVM)
        let third = UINavigationController(rootViewController: boxOfiiceVC).then {
            $0.tabBarItem = UITabBarItem(
                title: "영화",
                image: nil,
                tag: 2
            )
        }
        
        setViewControllers([first, second, third,], animated: false)
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.stackedLayoutAppearance.selected.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
