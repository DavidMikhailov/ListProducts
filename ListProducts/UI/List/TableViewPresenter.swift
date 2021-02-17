//
//  TableViewPresenter.swift
//  ListProducts
//
//  Created by Давид Михайлов on 17.02.2021.
//

import UIKit

protocol TableViewPresenterProtocol: class {
    var items : [ProductViewModel] { get }
}

class TableViewPresenter: TableViewPresenterProtocol {
    
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
