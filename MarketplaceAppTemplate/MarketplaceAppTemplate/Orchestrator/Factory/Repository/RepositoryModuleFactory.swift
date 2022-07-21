//
//  RepositoryModuleFactory.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22.
//

import Foundation

protocol RepositoryModuleFactory {
    // MARK: - Main
    func makeProductListRepo() -> ProductListRepository

}
