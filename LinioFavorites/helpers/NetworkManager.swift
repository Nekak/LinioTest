//
//  NetworkManager.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    static func downloadFavorites(completion: @escaping ((Array<Favorites>?,String?) -> Void)){
        Alamofire.request(url_get_favorites, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
                case .success:
                    if let arrayResponseJSON = response.value as? Array<Dictionary<String,AnyObject>> {
                        var arrFavorites = Array<Favorites>()
                        
                        for dictionary in arrayResponseJSON {
                            let favorite = Favorites()
                            favorite.parseFromDictionary(dictionary: dictionary)
                            
                            arrFavorites.append(favorite)
                        }
                        
                        completion(arrFavorites,nil)
                    }else{
                        completion(nil,"Error en datos recibidos")
                    }
                break
                case .failure:
                    completion(nil,"Error en servidor")
                break
            }
        }
    }
}
