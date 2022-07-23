//
//  VMModuleFactoryImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 20/07/22 .
//

import Foundation

extension ModuleFactoryImpl: VMModuleFactory {
    func makeProductListVM() -> ProductListVM {
        return ProductListVM(repository: makeProductListRepo())
    }
}
