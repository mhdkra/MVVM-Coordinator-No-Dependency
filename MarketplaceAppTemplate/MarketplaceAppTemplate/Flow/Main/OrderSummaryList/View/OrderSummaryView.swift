//
//  OrderSummaryView.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
protocol OrderSummaryView: BaseView {
    var products : [OrderSummaryModel] { get set }
}
