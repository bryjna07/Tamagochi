//
//  ConfigureUI.swift
//  MovieApp
//
//  Created by YoungJin on 8/2/25.
//

import Foundation

@objc protocol ConfigureUI: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
