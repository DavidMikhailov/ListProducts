//
//  Product.swift
//  ListProducts
//
//  Created by Давид Михайлов on 17.02.2021.
//

import UIKit

struct Product {
    typealias Id = String
    
    let id: Product.Id
    let name: String
    let price: Decimal
    let count: Int
    let image: UIImage
}
