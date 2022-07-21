//
//  ProductsListViewController.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 20/07/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    var viewModel: ProductsListViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to viewModel: ProductsListViewModel) {

    }
}
