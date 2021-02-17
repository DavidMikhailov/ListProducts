//
//  ViewController.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit

struct ProductViewModel {
    let name: String
    let count: Int
    let price: String
    let productImage: UIImage
}

class TableViewController: UITableViewController {
    
    var presenter : TableViewPresenterProtocol = TableViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ProductTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ProductTableViewCell
        let item = presenter.items[indexPath.row]
        cell.set(image: item.productImage, name: item.name, count: item.count, price: item.price)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProductDetails", sender: self)
    }
}

