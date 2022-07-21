//
//  ProductListView.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation

protocol ProductListView: BaseView {
    var viewModel: ProductListVM! { get set }
    var onCardTapped: ((ProductModel) -> Void)? { get set }
}
