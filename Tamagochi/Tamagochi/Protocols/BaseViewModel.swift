//
//  BaseViewModel.swift
//  Tamagochi
//
//  Created by YoungJin on 8/26/25.
//

import Foundation

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
