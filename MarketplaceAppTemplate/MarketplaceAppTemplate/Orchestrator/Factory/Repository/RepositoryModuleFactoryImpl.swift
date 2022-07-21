//
//  RepositoryModuleFactoryImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22.
//

import Foundation

extension ModuleFactoryImpl: RepositoryModuleFactory {
    func makeProductListRepo() -> ProductListRepository{
        return ProductListRepositoryImpl(ProductListAPI: makeProductListAPI())
    }

}
