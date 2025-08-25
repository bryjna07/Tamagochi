//
//  TabBarController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//


import UIKit
import Then


final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let manager = UserDefaultsManager.shared
        let name = manager.selectedTamagochiName
        let imageName = manager.image(tamagochiName: name)
        let model = Tamagochi(name: name, imageName: imageName, text: "임시", isAvailable: true)
        
        let mainVM = MainViewModel(data: model)
        let mainVC = MainViewController(viewModel: mainVM)
        let first = UINavigationController(rootViewController: mainVC).then {
            $0.tabBarItem = UITabBarItem(
                title: "다마고치",
                image: nil,
                tag: 0
            )
        }
        
        let upComingVC = LottoViewController()
        let second = UINavigationController(rootViewController: upComingVC).then {
            $0.tabBarItem = UITabBarItem(
                title: "로또",
                image: nil,
                tag: 1
            )
        }
        
        let boxOfiiceVC = BoxOfficeViewController()
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
