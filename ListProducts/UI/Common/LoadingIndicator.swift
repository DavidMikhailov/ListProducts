//
//  LoadingIndicator.swift
//  ListProducts
//
//  Created by Давид Михайлов on 23.02.2021.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        
        activityIndicator.color = .white
        activityIndicator.frame.size = CGSize(width: 70, height: 70)
        activityIndicator.startAnimating()
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        addSubview(activityIndicator)
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
}
