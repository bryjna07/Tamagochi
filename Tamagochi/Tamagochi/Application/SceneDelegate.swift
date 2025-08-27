//
//  SceneDelegate.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if let data = UserDefaultsManager.shared.selectedTamagochi() {
            let tab = TabBarController(data: data)
            window?.rootViewController = tab
        } else {
            let startVC = StartViewController()
            let nav = UINavigationController(rootViewController: startVC)
            window?.rootViewController = nav
        }
        
        window?.makeKeyAndVisible()
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                window.rootViewController = vc
            }
        } else {
            window.rootViewController = vc
        }
    }
}
