//
//  ProductListRepositoryImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
import Combine

class ProductListRepositoryImpl: ProductListRepository {
    
    
    private let productListAPI: ProductListAPI
    
    init(ProductListAPI: ProductListAPI) {
        self.productListAPI = ProductListAPI
    }
    
    func request(brand: String) -> Future<[ProductModel], HTTPError>? {
        Future { [weak self] promise in
            self?.productListAPI
                .request(brand: brand) { result, error in
                    if let error = error {
                        promise(Result.failure(error))
                    }
                    
                    if let res = result {
                        let model = res.map { (res) in
                            return ProductModel(id: res.id ?? 0, name: res.name ?? "", type: res.productType ?? "", imgUrl: res.imageLink ?? "", priceStr: res.price ?? "")
                        }
                        promise(.success(model))
                    }
                }
        }
    }
}

