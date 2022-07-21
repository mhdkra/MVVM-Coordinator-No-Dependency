//
//  VMModuleFactory.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22
//

import Foundation

protocol VMModuleFactory {
    // MARK: - Main

    func makeProductListVM() -> ProductListVM
}
