//
//  Cart.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 23/07/22.
//

import Foundation
import Combine

enum CartAction {
    case incrementProduct(withObject: ProductModel)
    case decrementProduct(withId: Int)
    case clear
}

class Cart {
    var orders: AnyPublisher<[ProductOrderModel], Never>{
        didSet{
            
        }
    }
    var input: AnySubscriber<CartAction, Never>
    var observers: [AnyCancellable] = []
    init() {
        let actionInput = PassthroughSubject<CartAction, Never>()
        
        self.orders = actionInput.scan([Int:ProductOrderModel]()) { (currentOrders, action) -> [Int:ProductOrderModel] in
            var newOrders = currentOrders
            switch (action) {
            case .incrementProduct(let product):
                if let order = newOrders[product.id] {
                    newOrders.updateValue(order.incremented, forKey: product.id)
                }else{
                    newOrders.updateValue(ProductOrderModel(product: product), forKey: product.id)
                }
            case .decrementProduct(let productId):
                if let order = newOrders[productId] {
                    let decrementedOrder = order.decremented
                    if (decrementedOrder.quantity == 0) {
                        newOrders.removeValue(forKey: productId)
                    } else {
                        newOrders.updateValue(decrementedOrder, forKey: productId)
                    }
                }
            case .clear:
                return [:]
            }
            
            return newOrders
        }
        .map(\.values)
        .map(Array.init)
        .eraseToAnyPublisher()
 
        self.input = AnySubscriber(actionInput)
    }


}

extension Cart {
    var numberOfProducts: AnyPublisher<Int, Never> {
        return orders.map(\.count).eraseToAnyPublisher()
    }
    
    var totalPrice: AnyPublisher<Double, Never> {
        return orders.map { $0.reduce(0) { (acc, order) -> Double in
            acc + order.price
        }
        }.eraseToAnyPublisher()
    }
    
    var products : [ProductOrderModel] {
        var arr = [ProductOrderModel]()
        orders
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { products in
                arr = products
            })
         .store(in: &observers)
        return arr
    }
}
