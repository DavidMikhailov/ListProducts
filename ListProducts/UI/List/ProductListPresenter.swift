//
//  TableViewPresenter.swift
//  ListProducts
//
//  Created by Давид Михайлов on 17.02.2021.
//

import UIKit

protocol ProductListPresenterProtocol: class {
    var items : [ProductViewModel] { get }
    
    func load(ui: ProductListProtocol)
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
    
    
    let items = [
        ProductViewModel(
            name: "Мыло",
            count: 2,
            price: "10 руб.",
            productImage: UIImage(named: "soap")!
        ),
        ProductViewModel(
            name: "Мыло",
            count: 10,
            price: "120 руб.",
            productImage: UIImage(named: "soap")!
        ),
    ]
    
    
}
