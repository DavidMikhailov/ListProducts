////
////  ProductService.swift
////  ListProducts
////
////  Created by Давид Михайлов on 19.02.2021.
////
//
//import Foundation
//
//protocol ProductServiceProtocol: class {
//    /// Create
//    func create(product: Product, onComplete: @escaping (Error?) -> Void)
//    
//    /// Read
//    func getProductList(onComplete: @escaping ([Product]) -> Void)
//    func getProduct(id: Product.Id, onComplete: @escaping (Product) -> Void)
//    
//    /// Update
//    func edit(product: Product, onComplete: @escaping (Error?) -> Void)
//    
//    /// Delete
//    func delete(id: Product.Id, onComplete: @escaping (Error?) -> Void)
//}
//
//class ProductService: ProductServiceProtocol {
//    
//    let realm: RealmDB
//    
//    /// Create
//    func create(product: Product, onComplete: @escaping (Error?) -> Void) {
//        
//    }
//    
//    /// Read
//    func getProductList(onComplete: @escaping ([Product]) -> Void) {
//        realm.readList() { objects in
//            let products = objects.map {}
//            complete(products)
//        }
//    }
//    func getProduct(id: Product.Id, onComplete: @escaping (Product) -> Void)
//    
//    /// Update
//    func edit(product: Product, onComplete: @escaping (Error?) -> Void)
//    
//    /// Delete
//    func delete(id: Product.Id, onComplete: @escaping (Error?) -> Void)
//    
//}
//
//   
