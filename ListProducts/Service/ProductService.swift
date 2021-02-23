//
//  ProductService.swift
//  ListProducts
//
//  Created by Давид Михайлов on 19.02.2021.
//

import Foundation
import RealmSwift

protocol ProductsServiceProtocol: class {
    /// Create
    func create(product: Product, onComplete: @escaping (Error?) -> Void)
    
    /// Read
    func getProductList(onComplete: @escaping ([Product]) -> Void)
    func getProduct(id: Product.Id, onComplete: @escaping (Product) -> Void)

    /// Update
    func edit(product: Product, onComplete: @escaping (Error?) -> Void)

    /// Delete
    func delete(id: Product.Id, onComplete: @escaping (Error?) -> Void)
    
    func observe(onDataUpdated: @escaping () -> Void)
}

class ProductsService: ProductsServiceProtocol {
    
    private let database: ProductDatabase
    private let bgQueue = DispatchQueue.global(qos: .background)
    
    init(database: ProductDatabase) {
        self.database = database
    }

    var observationToken: NotificationToken?
    func observe(onDataUpdated: @escaping () -> Void) {
        self.observationToken = database.observe {
            onDataUpdated()
        }
    }
    
    /// Create
    func create(product: Product, onComplete: @escaping (Error?) -> Void) {
        bgQueue.async {
            //  Имитируем задержку при создании (указано в тестовом задании)
            sleep(2)
            let product = ProductRealmModel(
                id: product.id,
                name: product.name,
                price: product.price,
                count: product.count,
                imageData: product.image?.jpegData(compressionQuality: 0.2),
                dateCreated: Date()
            )
            do {
                try self.database.create(product: product)
                onComplete(nil)
            } catch {
                onComplete(error)
            }
        }
    }
    
    func getProductList(onComplete: @escaping ([Product]) -> Void) {
        bgQueue.async {
            let results = self.database.readAll().sorted(byKeyPath: "dateCreated")
            let models = results.map { realmModel in
                Product.make(from: realmModel)
            }
            onComplete(Array(models))
        }
    }
        
    func getProduct(id: Product.Id, onComplete: @escaping (Product) -> Void) {
        bgQueue.async {
            let predicate = NSPredicate(format: "id = %@", id)
            let results = self.database.readAll().filter(predicate)
            let product = Product.make(from: results.first!)
            onComplete(product)
        }
    }

    /// Update
    func edit(product: Product, onComplete: @escaping (Error?) -> Void) {
        bgQueue.async {
            let product = ProductRealmModel(
                id: product.id,
                name: product.name,
                price: product.price,
                count: product.count,
                imageData: product.image?.jpegData(compressionQuality: 0.2),
                dateCreated: product.dateCreated
            )
            do {
                try self.database.edit(product: product)
                onComplete(nil)
            } catch {
                onComplete(error)
            }
        }
    }

    /// Delete
    func delete(id: Product.Id, onComplete: @escaping (Error?) -> Void) {
        bgQueue.async {
            do {
                try self.database.delete(productId: id)
                onComplete(nil)
            } catch {
                onComplete(error)
            }
        }
    }
}

   

extension Product {
    static func make(from realmModel: ProductRealmModel) -> Product {
        Product(
            id: realmModel.id,
            dateCreated: realmModel.dateCreated!,
            name: realmModel.name,
            price: Decimal(realmModel.price),
            count: realmModel.count,
            image: realmModel.imageData.flatMap { UIImage(data: $0) }
        )
    }
}
