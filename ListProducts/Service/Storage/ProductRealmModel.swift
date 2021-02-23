//
//  ProductRealmModel.swift
//  ListProducts
//
//  Created by Давид Михайлов on 22.02.2021.
//

import RealmSwift

class ProductRealmModel: Object {
    
    @objc dynamic var id: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var name: String = ""
    @objc dynamic var dateCreated: Date? = nil
    @objc dynamic var price: Double = 0
    @objc dynamic var count = 0
    @objc dynamic var imageData: Data?
        
    convenience init(id: String, name: String, price: Decimal, count: Int, imageData: Data?, dateCreated: Date) {
        self.init()
        self.id = id
        self.name = name
        self.price = Double(truncating: price as NSNumber)
        self.count = count
        self.imageData = imageData
        self.dateCreated = dateCreated
    }
}
