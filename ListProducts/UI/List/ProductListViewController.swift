//
//  ViewController.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit

protocol ProductListProtocol: class {
    func dataChanged()
}

class ProductListViewController: UITableViewController, ProductListProtocol {
    
    func dataChanged() {
        tableView.reloadData()
    }
    
    @IBAction func addNewProduct(_ sender: Any) {
        let productDetailsVc = self.storyboard!
            .instantiateViewController(identifier: String(describing: ProductDetailsViewController.self))
            as! ProductDetailsViewController
        
        let detailsPresenter = ProductDetailsPresenter(context: .new)
        productDetailsVc.presenter = detailsPresenter
        
        showDetailViewController(productDetailsVc, sender: self)
    }
    
    var presenter: ProductListPresenterProtocol = ProductListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load(ui: self)
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
    
    var selectedRow: Int? = nil
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "showProductDetails", sender: self)
        
        // let vc = self.storyboard!
//            .instantiateViewController(identifier: )
        // self.destination = vc
//      prepare(self)
        // showDetailViewController(vc, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let details = segue.destination as? ProductDetailsPresenterProtocol {
            let productId = presenter.getId(by: selectedRow)            
            let detailsPresenter = ProductDetailsPresenter(context: .exising(productId))
            details.presenter = detailsPresenter
            self.selectedRow = nil
        }
    }
}

