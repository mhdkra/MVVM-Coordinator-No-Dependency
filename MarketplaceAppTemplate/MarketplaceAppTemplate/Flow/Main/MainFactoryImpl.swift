//
//  MainFactoryImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 20/07/22 .
//

import Foundation

extension ModuleFactoryImpl: MainFactory {
    func makeProductListView() -> ProductListView {
        let vc = ProductListVC()
        vc.viewModel = makeProductListVM()
        return vc
    }
    
    func makeOrderSummaryView() -> OrderSummaryView {
        let vc = OrderSummaryVC()
        return vc
    }
    
}
