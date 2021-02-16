//
//  AddProductViewController.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit

class AddProductViewController : UIViewController {
    @IBOutlet weak var nameProductTextField: UITextField!
    @IBOutlet weak var quantityProductTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBOutlet weak var addImageTapped: UIButton!
    
    
    @IBOutlet weak var saveTapped: UIButton!
}

//MARK: - Extension

extension AddProductViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddProductViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

