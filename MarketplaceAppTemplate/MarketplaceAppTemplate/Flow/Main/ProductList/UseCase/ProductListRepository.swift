//
//  ProductListRepository.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
import Combine

protocol ProductListRepository {
    func request(brand: String) -> Future<[ProductModel], HTTPError>?
}
