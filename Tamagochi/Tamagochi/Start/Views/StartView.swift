//
//  StartView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class StartView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(TamagochiCell.self, forCellWithReuseIdentifier: TamagochiCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            
            // 아이템 크기
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 3.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)
            
            // 그룹 크기
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0 / 5.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(8)
            
            // 섹션
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
            
            return section
        }
        return layout
    }
}

extension StartView {
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

