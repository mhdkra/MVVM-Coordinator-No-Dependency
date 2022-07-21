//
//  ProductModel.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation

struct ProductModel {
    let id: Int
    let name: String
    let price: String
    let type: String
    let imgUrl: String
}

enum BasicUIState {
    case close
    case loading
    case success(String)
    case failure(String)
    case warning(String)
    case stopLoadMore
    case stopRefresh
}
