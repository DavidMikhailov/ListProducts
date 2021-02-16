//
//  SplitViewcontroller.swift
//  ListProducts
//
//  Created by Давид Михайлов on 16.02.2021.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    
    override func viewDidLoad() {
        
        let masterVC = TableViewController()
        let detailVC = DetailViewController()
        
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [masterVC, detailVC]
        
        
        self.delegate = self
        //Отображаем два контроллера для планшета
        self.preferredDisplayMode = .twoDisplaceSecondary
    
}

   

}

extension SplitViewController: UISplitViewControllerDelegate {


}
