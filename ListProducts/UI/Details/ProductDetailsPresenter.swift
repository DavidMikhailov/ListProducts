//
//  ProductDetailsPresenter.swift
//  ListProducts
//
//  Created by Давид Михайлов on 17.02.2021.
//

import UIKit

protocol ProductDetailsPresenterProtocol: class {
    func load(ui: ProductDetailsUI)
    
    var canEdit: Bool { get }
    
    func create(name: String, count: String, price: String, image: UIImage?)
    
    func remove()
    
    func edit(name: String, count: String, price: String, image: UIImage?)
    
    var existingProduct: Product? { get }
}

enum ProductDetailsContext {
    case new
    case exising(Product.Id)
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    weak var ui: ProductDetailsUI!
        
    private let context: ProductDetailsContext
    private let service: ProductsServiceProtocol
    
    init(context: ProductDetailsContext, service: ProductsServiceProtocol) {
        self.context = context
        self.service = service
    }
    
    func load(ui: ProductDetailsUI) {
        self.ui = ui
        ui.dataChanged()
        
        switch context {
        case .exising(let id):
            service.getProduct(id: id, onComplete: { [weak self] product in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.existingProduct = product
                    self.ui.dataChanged()
                }
            })
        default:
            break
        }
    }
    
    func create(name: String, count: String, price: String, image: UIImage?) {
        guard let priceDecimal = Decimal(string: price), let countInt = Int(count) else {
            return
        }
        let newProduct = Product(id: UUID().uuidString, dateCreated: Date(), name: name, price: priceDecimal, count: countInt, image: image)
        service.create(product: newProduct) { [weak self] error in
            if let error = error {
//                self.ui.showError(error)
            } else {
                
            }
        }
    }
    
    func remove() {
        switch context {
        case .exising(let id):
            service.delete(id: id) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print(error)
//                    self.ui.showError(error)
                } else {
                    
                }
            }
        default:
            return
        }
    }
    
    func edit(name: String, count: String, price: String, image: UIImage?) {
        guard let priceDecimal = Decimal(string: price), let countInt = Int(count) else {
            return
        }
        switch context {
        case .exising(let id):
            let editingProduct = Product(
                id: id,
                dateCreated: existingProduct!.dateCreated,
                name: name,
                price: priceDecimal,
                count: countInt,
                image: image
            )
            service.edit(product: editingProduct) { [weak self] error in
                if let error = error {
    //                self.ui.showError(error)
                } else {
                    
                }
            }
        default:
            return
        }
    }
    
    var existingProduct: Product?
    var canEdit: Bool {
        switch context {
        case .new:
            return false
        case .exising:
            return true
        }
    }
}
