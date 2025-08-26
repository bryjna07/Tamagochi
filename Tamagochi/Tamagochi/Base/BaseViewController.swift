//
//  BaseViewController.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
    }
    
    func setupNaviBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func showAlert(title: String, message: String, ok: String, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            completion()
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}
