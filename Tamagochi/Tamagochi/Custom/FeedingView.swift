//
//  FeedingView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class FeedingView: BaseView {
    
    private let textField = UITextField().then {
        $0.textAlignment = .center
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let button = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .large
        $0.configuration = config
    }
    
    init(placeholder: String, buttonImage: UIImage?, buttonName: String) {
        super.init(frame: .zero)
        textField.placeholder = placeholder
        button.configuration?.image = buttonImage
        button.configuration?.title = buttonName
    }
}

extension FeedingView {
    override func configureHierarchy() {
        [
            textField,
            lineView,
            button,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.equalTo(lineView.snp.top)
            $0.trailing.equalTo(button.snp.leading).offset(-8)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.trailing.equalTo(button.snp.leading).offset(-8)
        }
        
        button.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.width.equalTo(96)
        }
    }
}
