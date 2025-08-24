//
//  SettingView.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import UIKit
import Then
import SnapKit

final class SettingView: BaseView {
    
    let tableView = UITableView().then {
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        $0.rowHeight = 44
        $0.separatorStyle = .singleLine
    }
}

extension SettingView {
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
