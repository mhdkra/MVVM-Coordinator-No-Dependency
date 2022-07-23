//
//  MainCoordinator.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 20/07/22 .
//

import Foundation

class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    private let router: Router
    private let factory: MainFactory
    private let listView : ProductListView
    init(router: Router, factory: MainFactory) {
        self.router = router
        self.factory = factory
        self.listView = factory.makeProductListView()
    }
    
    override func start() {
        self.showProductList()
    }
    
    private func showProductList() {
        listView.onCartTapped = { [weak self] (cart) in
            guard let self = self else { return }
            self.showOrderSummary(cart: cart)
        }
        router.setRootModule(listView, hideBar: false, animation: .bottomUp)
    }
    
    private func showOrderSummary(cart: [Int:ProductOrderModel]) {
        let view = factory.makeOrderSummaryView()
        view.cart = cart
        
        view.onBackTapped = { [weak self] (enabled, reset, timer) in
            self?.listView.enabled = enabled
            self?.listView.isReset = reset
            self?.listView.timer = timer
            view.timer = timer
        }
        
        router.push(view)
    }
}
