//
//  ConfigureUI.swift
//  Tamagochi
//
//  Created by YoungJin on 8/24/25.
//

import Foundation

@objc protocol ConfigureUI: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
