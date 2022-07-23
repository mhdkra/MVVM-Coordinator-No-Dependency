//
//  BaseViewModel.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 20/07/22 .
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
