//
//  ProductListAPI.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
import Combine
protocol ProductListAPI: ClientAPI {
    func request(brand: String, completion: @escaping (_ result: [ProductListResponse]?, _ error: HTTPError?) -> Void)
}
