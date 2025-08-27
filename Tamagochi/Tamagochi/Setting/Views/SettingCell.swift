//
//  SettingCell.swift
//  Tamagochi
//
//  Created by YoungJin on 8/25/25.
//

import UIKit
import Then
import SnapKit

final class SettingCell: BaseTableViewCell {
    
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "star")
        $0.tintColor = .black
    }
    
    let label = UILabel().then {
        $0.text = "내 이름 설정하기"
        $0.font = .systemFont(ofSize: 14)
    }
    
    let nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
       }
}

extension SettingCell {
    override func configureHierarchy() {
        [
            iconImageView,
            label,
            nicknameLabel,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.trailing.lessThanOrEqualTo(nicknameLabel.snp.leading).offset(-4)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
    }
}
