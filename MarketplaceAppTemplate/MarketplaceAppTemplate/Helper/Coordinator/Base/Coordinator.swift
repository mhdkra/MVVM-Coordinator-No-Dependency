//
//  Coordinator.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22  .
//

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}
