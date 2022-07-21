//
//  ProductListAPIImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
import Combine

class ProductListAPIImpl: ProductListAPI {
    
    private class GetProductList: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/products.json"
        var apiVersion = ApiVersion.v1
        var parameters: [String: Any]
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(brand: String) {
            self.parameters = ["brand":brand];
        }
    }
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    
    func request(brand: String, completion: @escaping (_ result: [ProductListResponse]?, _ error: HTTPError?) -> Void) {
        httpClient.send([ProductListResponse].self, request: GetProductList(brand: brand)){ result in
            switch result{
            case .success(let obj):
                completion(obj, nil)
            case .failure(let error):
                completion([],HTTPError.custom(error.readableError))
            }
        }
    }
    
}

