//
//  NicknameView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import UIKit
import Then
import SnapKit

final class NicknameView: BaseView {
    
    let textField = UITextField().then {
        $0.textAlignment = .center
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .black
    }
}

extension NicknameView {
    override func configureHierarchy() {
        [
            textField,
            lineView,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(1)
        }
    }
}
