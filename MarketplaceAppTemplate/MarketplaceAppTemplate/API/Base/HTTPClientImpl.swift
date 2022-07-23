//
//  HTTPClientImpl.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 20/07/22 .
//

import Foundation
import Combine

class HTTPClientImpl: HTTPClient {

    private let identifier: HTTPIdentifier
    
    init(identifier: HTTPIdentifier) {
        self.identifier = identifier
    }
    func send<T : Codable>(_ t: T.Type, request apiRequest: HTTPRequest, completion: @escaping (Result<T, Error>) -> Void){
        let request = apiRequest.request(with: self.identifier.baseUrl)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            
            if HTTPReachability.isConnectedToNetwork() {
                do {
                    self.log(data: data, from: request)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model: T = try decoder.decode(T.self, from: data ?? Data())
                    completion(.success(model))
                } catch let error {
                    print("\n=====HTTPResponseError=====")
                    print("RESPONSE FROM \(request.url?.absoluteString ?? self.identifier.baseUrl.absoluteString) => \((error as NSError).userInfo.debugDescription)")
                    print("====================\n")
                    completion(.failure(HTTPError.uncodableIssue))
                }
            } else {
                completion(.failure(HTTPError.connectionLost))
            }
        }
        .resume()
    }
    
    private func log(data: Data?, from urlRequest: URLRequest) {
        if let data = data {
            print("\n=====HTTPResponse=====")
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("RESPONSE FROM \(urlRequest.url?.absoluteString ?? "") \n\(json)")
                }
            } catch let error {
                print("RESPONSE FROM \(urlRequest.url?.absoluteString ?? "") => \(error.localizedDescription)")
            }
            print("====================\n")
        }
    }
}
