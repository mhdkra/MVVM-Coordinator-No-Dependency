//
//  OrderSummaryModel.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 20/07/22.
//

import Foundation

struct OrderSummaryModel : Equatable{
    let id: Int
    let name: String
    let quantity: Int
    let totalPrice: String
}

struct ProductOrderModel : Equatable{
    static func == (lhs: ProductOrderModel, rhs: ProductOrderModel) -> Bool {
        return true
    }
    
    var product: ProductModel
    var quantity: Int
    
    init(product: ProductModel, quantity: Int = 1) {
        self.product = product
        self.quantity = quantity
    }
    
    var incremented: ProductOrderModel {
        return ProductOrderModel(product: product, quantity: quantity + 1)
    }
    
    var decremented: ProductOrderModel {
        return ProductOrderModel(product: product, quantity: quantity - 1)
    }

    var price: Double {
        return product.price * Double(quantity)
    }
    
}
