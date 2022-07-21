//
//  MainCoordinator.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22  .
//

import Foundation

class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    private let router: Router
    private let factory: MainFactory
    
    init(router: Router, factory: MainFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        self.showProductList()
    }
    
    private func showProductList() {
        let view = factory.makeProductListView()
        view.onCardTapped = { [weak self] (movie) in
            guard let self = self else { return }
            self.showOrderSummary(movie: movie)
        }
        router.setRootModule(view, hideBar: false, animation: .bottomUp)
    }
    
    private func showOrderSummary(movie: ProductModel) {
        let view = factory.makeOrderSummaryView()
        router.push(view)
    }
}
