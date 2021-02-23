//
//  ProductListPresenterProtocol.swift
//  ListProducts
//
//  Created by Давид Михайлов on 17.02.2021.
//

import UIKit

protocol ProductListPresenterProtocol: class {
    var viewModels : [ProductViewModel] { get }
    
    func load(ui: ProductListProtocol)
    
    func getProductId(by row: Int) -> Product.Id
    
    func filter(by text: String)
}

class ProductListPresenter: ProductListPresenterProtocol {
    weak var ui: ProductListProtocol!
    let service: ProductsServiceProtocol
    
    init(service: ProductsServiceProtocol) {
        self.service = service
    }
    
    var viewModels: [ProductViewModel] = []
    
    private var searchText = ""
    
    func filter(by text: String) {
        self.searchText = text
        buildViewModel()
    }
    
    private func buildViewModel() {
        if searchText.isEmpty {
            viewModels = items
        } else {
            let filteredItems = items.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
            viewModels = filteredItems
        }
        ui.dataChanged()
    }
    
    func load(ui: ProductListProtocol) {
        self.ui = ui
        service.observe { [weak self] in
            self?.reloadDataFromService()
        }
        reloadDataFromService()
    }
    
    private func reloadDataFromService() {
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
                self.buildViewModel()
            }
        })
    }
    
    func getProductId(by row: Int) -> Product.Id {
        return items[row].id
    }
    
    private var items: [ProductViewModel] = []
}
