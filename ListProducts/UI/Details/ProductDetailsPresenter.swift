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
}

enum ProductDetailsContext {
    case new
    case exising(Product.Id)
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    weak var ui: ProductDetailsUI!
        
    private let context: ProductDetailsContext
    
    init(context: ProductDetailsContext) {
        self.context = context
    }
    
    func load(ui: ProductDetailsUI) {
        self.ui = ui
        ui.dataChanged()
    }
    
    var canEdit: Bool {
        switch context {
        case .new:
            return false
        case .exising:
            return true
        }
    }
}
