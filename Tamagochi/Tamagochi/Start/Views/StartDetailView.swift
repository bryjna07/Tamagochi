//
//  StartDetailView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class StartDetailView: BaseView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ._1_2
        $0.clipsToBounds = true
    }
    
    let nameView = TamagochiNameView()
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .black
    }
    
    let detailLabel = UILabel().then {
        $0.text = "저는 방실방실 다마고치 입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let cancelButton = UIButton(type: .system).then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 0.5
    }
    
    let startButton = UIButton(type: .system).then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 0.5
    }
}

extension StartDetailView {
    override func configureHierarchy() {
        [
            imageView,
            nameView,
            dividerView,
            detailLabel,
            cancelButton, startButton,
        ].forEach {
            containerView.addSubview($0)
        }
        
        addSubview(containerView)
    }
    
    override func configureLayout() {
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
        
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(80)
            $0.height.equalTo(imageView.snp.width)
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.bottom.lessThanOrEqualToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(20)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(detailLabel.snp.centerX)
            $0.height.equalTo(44)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(20)
            $0.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(detailLabel.snp.centerX)
            $0.height.equalTo(44)
        }
    }
    
    override func configureView() {
        backgroundColor = .black.withAlphaComponent(0.5)
    }
}
