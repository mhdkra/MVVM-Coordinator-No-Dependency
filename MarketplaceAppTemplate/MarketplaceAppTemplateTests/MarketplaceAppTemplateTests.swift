
//
//  MarketplaceAppTemplateTests.swift
//  MarketplaceAppTemplateTests
//
//  Created by Wais on 12/01/22.
//

import XCTest
import Combine
@testable import MarketplaceAppTemplate

class MarketplaceAppTemplateTests: XCTestCase {
    
    private var cart: Cart!
    static let apple = ProductModel(id: 343, name: "Apple", type: "-", imgUrl: "", priceStr: "")
    static let orange = ProductModel(id: 344, name: "Orange", type: "-", imgUrl: "", priceStr: "")
    var observers: [AnyCancellable] = []
    
    override func setUp() {
        self.cart = Cart()
    }
    
    func triggerCartActions(_ actions: CartAction...) {
        Publishers.Sequence<[CartAction], Never>(sequence: actions)
            .receive(subscriber: cart.input)
    }
    
    func testInsertingProduct() {
        cart.orders
            .receive(on: ImmediateScheduler.shared)
            .sink(receiveValue: { (orders) in
                XCTAssertEqual([ProductOrderModel(product: MarketplaceAppTemplateTests.apple, quantity: 1)], orders)
            })
            .store(in: &observers)
        
        triggerCartActions(.incrementProduct(withObject: MarketplaceAppTemplateTests.apple))
    }
    
    func testIncrementingProduct() {
        cart
            .orders
            .receive(on: ImmediateScheduler.shared)
            .sink { (orders) in
                XCTAssertTrue(orders.contains(ProductOrderModel(product: MarketplaceAppTemplateTests.apple, quantity: 1)))
            }
            .store(in: &observers)
        
        triggerCartActions(
            .incrementProduct(withObject: MarketplaceAppTemplateTests.apple)
        )
    }
    
    func test_incrementProductTwice_shouldAddOneProductWithTwoQuantities() {
        let orderSpy = Spy<[ProductOrderModel]>(observedValue: cart.orders)
        
        triggerCartActions(
            .incrementProduct(withObject: Self.apple),
            .incrementProduct(withObject: Self.apple)
        )
        
        let latestState = orderSpy.values.flatMap { $0 }.last
        XCTAssertEqual(
            latestState,
            ProductOrderModel(product: Self.apple, quantity: 2)
        )
    }
    
    func test_incrementProductTwice_shouldAddTwoDifferentProducts() {
        let orderSpy = Spy<[ProductOrderModel]>(observedValue: cart.orders)
        
        triggerCartActions(
            .incrementProduct(withObject: Self.apple),
            .incrementProduct(withObject: Self.orange)
        )

        let latestStates = orderSpy.values.flatMap { $0 }
        XCTAssertEqual(
            latestStates,
            [ ProductOrderModel(product: Self.apple, quantity: 1),
              ProductOrderModel(product: Self.orange, quantity: 1) ]
        )
    }
    
}

final class Spy<Value> {
    
    private var observers: [AnyCancellable] = []
    var values = [Value]()
    
    init(observedValue: AnyPublisher<Value, Never>) {
        observedValue
            .receive(on: ImmediateScheduler.shared)
            .sink { value in
                self.values.append(value)
            }
            .store(in: &observers)
    }
}
