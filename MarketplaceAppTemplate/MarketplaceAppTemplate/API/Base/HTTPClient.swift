//
//  HTTPClient.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22  .
//

import Foundation
import Combine

protocol ClientAPI {
    var httpClient: HTTPClient { get }
}

protocol HTTPClient {
//    func send<T: Codable>(request apiRequest: HTTPRequest) -> Future<T>
//    func send<T: Codable>(request apiRequest: HTTPRequest) -> () -> Result<T>
    func send<T : Codable>(_ t: T.Type, request apiRequest: HTTPRequest, completion: @escaping (Result<T, Error>) -> Void)
}

protocol HTTPIdentifier {
    var baseUrl: URL { get }
}

class BaseIdentifier: HTTPIdentifier {
#if DEBUG
    var baseUrl = URL(string: "https://makeup-api.herokuapp.com")!
#else
    var baseUrl = URL(string: "https://makeup-api.herokuapp.com")!
#endif
}
