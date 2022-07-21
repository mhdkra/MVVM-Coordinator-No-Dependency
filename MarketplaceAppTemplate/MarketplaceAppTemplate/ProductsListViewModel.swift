//
//  ProductsListViewModel.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 20/07/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

protocol ProductsListViewModelInput {
    func viewDidLoad()
}

protocol ProductsListViewModelOutput {
    
}

protocol ProductsListViewModel: ProductsListViewModelInput, ProductsListViewModelOutput { }

class DefaultProductsListViewModel: ProductsListViewModel {
    
    // MARK: - OUTPUT

}

// MARK: - INPUT. View event methods
extension DefaultProductsListViewModel {
    func viewDidLoad() {
    }
}
