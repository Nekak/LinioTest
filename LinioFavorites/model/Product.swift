//
//  Product.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import Foundation

class Product {
    var sku: String = ""
    var idProduct: Int = 0
    var name: String = ""
    var wishListPrice: Int = 0
    var slug: String = ""
    var url: String = ""
    var image: String = ""
    var linioPlusLevel: Int = 0
    var conditionType: String = ""
    var freeShipping: Bool = false
    var imported: Bool = false
    var active: Bool = false
    
    init() {
        self.sku = ""
        self.idProduct = 0
        self.name = ""
        self.wishListPrice = 0
        self.slug = ""
        self.url = ""
        self.image = ""
        self.linioPlusLevel = 0
        self.conditionType = ""
        self.freeShipping = false
        self.imported = false
        self.active = false
    }
    
    init(withDictionary dictionary: Dictionary<String,AnyObject>,andSKU dSKU: String) {
        self.sku = dSKU
        self.idProduct = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.wishListPrice = dictionary["wishListPrice"] as? Int ?? 0
        self.slug = dictionary["slug"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.linioPlusLevel = dictionary["linioPlusLevel"] as? Int ?? 0
        self.conditionType = dictionary["conditionType"] as? String ?? ""
        self.freeShipping = dictionary["conditionType"] as? Bool ?? false
        self.imported = dictionary["imported"] as? Bool ?? false
        self.active = dictionary["active"] as? Bool ?? false
    }
}
