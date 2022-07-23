//
//  ProductListView.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation

protocol ProductListView: BaseView {
    var viewModel: ProductListVM! { get set }
    var onCartTapped: (([Int:ProductOrderModel]) -> Void)? { get set }
    var enabled: Bool! { get set }
    var isReset: Bool! { get set }
    var timer: Timer? { get set }
}
