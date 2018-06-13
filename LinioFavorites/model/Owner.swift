//
//  Owner.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import Foundation

class Owner {
    var name: String = ""
    var email: String = ""
    var linioId: String = ""
    
    init() {
        self.name = ""
        self.email = ""
        self.linioId = ""
    }
    
    init(withDictionary dictionary: Dictionary<String,AnyObject>) {
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.linioId = dictionary["linioId"] as? String ?? ""
    }
}
