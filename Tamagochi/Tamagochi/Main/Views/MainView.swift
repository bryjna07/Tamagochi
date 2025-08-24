//
//  MainView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class MainView: BaseView {
    
    private let bubbleimageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .bubble
    }
    
    private let bubbleLabel = UILabel().then {
        $0.text = "테이블뷰컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
    }
    
    let tamagochiImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ._1_1
    }
    
    let nameView = TamagochiNameView()
    
    private let infoLabel = UILabel().then {
        $0.text = "TEST"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let riceFeedingView = FeedingView(placeholder: "밥주세용", buttonImage: UIImage(systemName: "fork.knife.circle"), buttonName: "밥먹기")
    
    private let waterFeedingView = FeedingView(placeholder: "물주세용", buttonImage: UIImage(systemName: "drop.circle"), buttonName: "물먹기")
}

extension MainView {
    override func configureHierarchy() {
        bubbleimageView.addSubview(bubbleLabel)
        [
            bubbleimageView,
            tamagochiImageView,
            nameView,
            infoLabel,
            riceFeedingView,
            waterFeedingView,
        ].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        bubbleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        bubbleimageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(80)
            $0.height.equalTo(160)
        }
        
        tamagochiImageView.snp.makeConstraints {
            $0.top.equalTo(bubbleimageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(tamagochiImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().inset(80)
            $0.trailing.lessThanOrEqualToSuperview().inset(80)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(80)
        }
        
        riceFeedingView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(80)
        }
        
        waterFeedingView.snp.makeConstraints {
            $0.top.equalTo(riceFeedingView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(80)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
