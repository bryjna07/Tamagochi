//
//  TamagochiCell.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class TamagochiCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ._1_2
        $0.clipsToBounds = true
    }
    
    let nameView = TamagochiNameView()
    
    func configureCell(data: Tamagochi) {
        imageView.image = UIImage(named: data.imageName)
        nameView.nameLabel.text = data.name
    }
    
}

extension TamagochiCell {
    
    override func configureHierarchy() {
        [
            imageView,
            nameView,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self.snp.width)
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.bottom.lessThanOrEqualToSuperview()
        }
    }
}
