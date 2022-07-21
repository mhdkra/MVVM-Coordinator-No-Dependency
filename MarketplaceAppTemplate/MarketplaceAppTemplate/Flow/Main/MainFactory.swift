//
//  MainFactory.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22  .
//

import Foundation

protocol MainFactory {
    func makeProductListView() -> ProductListView
    func makeOrderSummaryView() -> OrderSummaryView
}
