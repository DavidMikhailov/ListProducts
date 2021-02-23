//
//  ProductListPresenterProtocol.swift
//  ListProducts
//
//  Created by Давид Михайлов on 17.02.2021.
//

import UIKit

protocol ProductListPresenterProtocol: class {
    var items : [ProductViewModel] { get }
    
    func load(ui: ProductListProtocol)
    
    func getProductId(by row: Int) -> Product.Id
}

class ProductListPresenter: ProductListPresenterProtocol {
    weak var ui: ProductListProtocol!
    let service: ProductsServiceProtocol
    
    init(service: ProductsServiceProtocol) {
        self.service = service
    }
    
    func load(ui: ProductListProtocol) {
        
        self.ui = ui
        
        service.getProductList(onComplete: { [weak self] products in
            guard let self = self else {
                return
            }
            let viewModels = products.map {
                ProductViewModel(
                    id: $0.id,
                    name: $0.name,
                    count: "\($0.count) шт.",
                    price: "\($0.price) р.",
                    productImage: $0.image
                )
            }
            self.items = viewModels
            DispatchQueue.main.async {
                self.ui.dataChanged()
            }            
        })
    }
    
    func getProductId(by row: Int) -> Product.Id {
        return items[row].id
    }
    
    var items: [ProductViewModel] = []
}
