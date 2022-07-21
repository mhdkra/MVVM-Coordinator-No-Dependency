//
//  ProductListVM.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
import Combine

class ProductListVM: BaseViewModel {
    private let repository: ProductListRepository
    var productsRelay : [ProductModel] = [ProductModel]()
    var stateRelay : BasicUIState = .loading
    
    var observers: [AnyCancellable] = []
    
    var onGettingProduct: (([ProductModel]) -> Void)?
    var currentState: ((BasicUIState) -> Void)?
    
    init(repository: ProductListRepository) {
        self.repository = repository
    }
    struct Input {
        let viewDidLoadRelay = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let products: [ProductModel]
        let state: BasicUIState
    }
    
    func transform(_ input: Input) -> Output {
        return Output(products: self.productsRelay,
                      state: self.stateRelay)
    }
    
    func requestproducts(brand: String){
        self.currentState?(.loading)
        self.repository
            .request(brand: brand)!
            .sink( receiveCompletion: {[weak self] completion in
                self?.currentState?(.close)
                switch completion {
                case .finished:
                    print("")
                case .failure(let error):
                    self?.currentState?(.failure(error.readableError))
                }
                
            }, receiveValue: {[weak self] result in
                self?.currentState?(.close)
                self?.productsRelay = result
                self?.onGettingProduct?(result)
                
            }).store(in: &observers)
    }
    
}
