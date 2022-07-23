//
//  OrderSummaryView.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
protocol OrderSummaryView: BaseView {
    var cart : [Int:ProductOrderModel]! { get set }
    var onBackTapped: ((Bool,Bool, Timer?) -> Void)? { get set }
    var isReset: Bool! { get set }
    var timer: Timer? { get set }
}
