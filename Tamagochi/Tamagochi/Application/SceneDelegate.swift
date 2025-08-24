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
        
        let nav = UINavigationController(rootViewController: StartViewController())
        
        window?.rootViewController = nav
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

