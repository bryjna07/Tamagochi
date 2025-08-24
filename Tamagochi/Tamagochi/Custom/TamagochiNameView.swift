//
//  TamagochiNameView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class TamagochiNameView: BaseView {
    
    private let nameLabel = UILabel().then {
        $0.text = "TEST"
        $0.font = .systemFont(ofSize: 16)
    }
    
    init() {
        super.init(frame: .zero)
        layer.borderWidth = 0.5
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .lightGray
    }
}

extension TamagochiNameView {
    override func configureHierarchy() {
        addSubview(nameLabel)
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
}
