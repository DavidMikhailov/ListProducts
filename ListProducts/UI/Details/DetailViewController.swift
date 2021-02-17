//
//  DetsilViewController.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameDetail: UITextField!
    @IBOutlet weak var qualityDetail: UITextField!
    @IBOutlet weak var priceDetail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func editTappAction(_ sender: UIBarButtonItem) {
    }
    @IBAction func deleteTappAction(_ sender: UIButton) {
    }
}
