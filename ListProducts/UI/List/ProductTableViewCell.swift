//
//  ProductTableViewCell.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func set(image: UIImage, name: String, count: Int, price: String) {
        self.countLabel.text = "\(count)"
        self.nameLabel.text = name
        self.priceLabel.text = price
        self.productImage.image = image
    }
}
