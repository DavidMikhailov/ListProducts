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
    
    func load(ui: ProductListProtocol) {
//        service.load() {
//
//        }
        self.ui = ui
        self.ui.dataChanged()
    }
    
    func getProductId(by row: Int) -> Product.Id {
        return items[row].id
    }
    
    let items = [
        ProductViewModel(
            id: "some_id_1",
            name: "Мыло",
            count: 2,
            price: "10 руб.",
            productImage: UIImage(named: "soap")!
        ),
        ProductViewModel(
            id: "some_id_2",
            name: "Мыло",
            count: 10,
            price: "120 руб.",
            productImage: UIImage(named: "soap")!
        ),
    ]
    
    
}
