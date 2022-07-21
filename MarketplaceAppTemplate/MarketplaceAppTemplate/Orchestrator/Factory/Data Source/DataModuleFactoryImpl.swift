//
//  DataModuleFactoryImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22.
//

import Foundation

class ModuleFactoryImpl: DataModuleFactory {
    
    func makeBaseIdentifier() -> HTTPIdentifier {
        return BaseIdentifier()
    }
    
    func makeHTTPClient() -> HTTPClient {
        return HTTPClientImpl(identifier: makeBaseIdentifier())
    }

    func makeProductListAPI() -> ProductListAPI{
        ProductListAPIImpl(httpClient: makeHTTPClient())
    }

}
