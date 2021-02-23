//
//  Database.swift
//  ListProducts
//
//  Created by Давид Михайлов on 22.02.2021.
//

import RealmSwift

class ProductDatabase {
    
    func create(product: ProductRealmModel) throws {
        let realm = try! Realm()
        try realm.write {
            realm.add(product)
        }
    }
    
    func readAll() -> Results<ProductRealmModel> {
        let realm = try! Realm()
        return realm.objects(ProductRealmModel.self)
    }
    
    func delete(productId: String) throws {
        let realm = try! Realm()
        try realm.write {
            let objectsToDelete = realm.objects(ProductRealmModel.self).filter("id = %@", productId)
            realm.delete(objectsToDelete)
        }
    }
    
    func edit(product: ProductRealmModel) throws {
        let realm = try! Realm()
        try realm.write {
            realm.add(product, update: .modified)
        }
    }
}
