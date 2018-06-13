//
//  Favorites.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import Foundation

class Favorites {
    var idFavorites: Int = 0
    var name: String = ""
    var favDescription: String = ""
    var isDefault: Bool = false
    var createdAt: String = ""
    var visibility: String = ""
    var owner: Owner = Owner()
    var productList: Array<Product> = Array<Product>()
    
    init() {
        self.idFavorites = 0
        self.name = ""
        self.favDescription = ""
        self.isDefault = false
        self.createdAt = ""
        self.visibility = ""
        self.owner = Owner()
        self.productList = Array<Product>()
    }
    
    func parseFromDictionary(dictionary: Dictionary<String,AnyObject>){
        self.idFavorites = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.favDescription = dictionary["description"] as? String ?? ""
        self.isDefault = dictionary["default"] as? Bool ?? false
        self.createdAt = dictionary["createdAt"] as? String ?? ""
        self.visibility = dictionary["visibility"] as? String ?? ""
        
        if let dictOwner = dictionary["owner"] as? Dictionary<String,AnyObject> {
            let owner = Owner(withDictionary: dictOwner)
            self.owner = owner
        }
        
        if let dictProducts = dictionary["products"] as? Dictionary<String,AnyObject> {
            for (sku,object) in dictProducts {
                if let dictProduct = object as? Dictionary<String,AnyObject> {
                    let product = Product(withDictionary: dictProduct, andSKU: sku)
                    productList.append(product)
                }
            }
        }
    }
}
