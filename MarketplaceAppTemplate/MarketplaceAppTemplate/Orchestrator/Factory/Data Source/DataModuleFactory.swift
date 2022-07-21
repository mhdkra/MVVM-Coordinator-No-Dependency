//
//  DataModuleFactory.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22.
//

import Foundation

protocol DataModuleFactory {
    // MARK: - HTTP Client
    func makeBaseIdentifier() -> HTTPIdentifier
    func makeHTTPClient() -> HTTPClient
    
    // MARK: - API    
    func makeProductListAPI() -> ProductListAPI
}
