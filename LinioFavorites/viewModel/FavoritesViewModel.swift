//
//  FavoritesViewModel.swift
//  LinioFavorites
//
//  Created by Ramses Rodríguez on 13/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import UIKit

class FavoritesViewModel: NSObject {
    var arrFavorites: Array<Favorites>
    var arrAllProducts: Array<Product>
    
    var updateDownloadStatus: ((_ isLoading: Bool,_ error: String?) -> Void)?
    
    override init() {
        self.arrFavorites = Array<Favorites>()
        self.arrAllProducts = Array<Product>()
        
        super.init()
    }
    
    //MARK: - Download data
    @objc func fetchData(){
        self.updateDownloadStatus?(true, nil)
        
        NetworkManager.downloadFavorites { (arrFavs, error) in
            if error != nil {
                self.updateDownloadStatus?(false,error)
            }else{
                DispatchQueue.global(qos: .background).async {
                    self.arrFavorites.removeAll()
                    self.arrFavorites.append(contentsOf: arrFavs!)
                
                    self.arrAllProducts.removeAll()
                
                    for fav in self.arrFavorites {
                        self.arrAllProducts.append(contentsOf: fav.productList)
                    }
                
                    DispatchQueue.main.async {
                        self.updateDownloadStatus?(false,nil)
                    }
                }
            }
        }
    }
    
    //MARK: - Validation
    func hasData() -> Bool {
        return !arrFavorites.isEmpty
    }
    
    //MARK: - Getter
    func getMyFavoritesCount() -> Int{
        return self.arrFavorites.count
    }
    
    func getFavoritesCount() -> Int{
        return self.arrAllProducts.count
    }
    
    func getMyFavoritesViewModel(forIndex index: Int) -> MyFavoritesViewModel{
        guard index < self.arrFavorites.count else {
            return MyFavoritesViewModel(name: "", quantity: 0, url1: nil, url2: nil, url3: nil)
        }
        
        let favorites = self.arrFavorites[index]
        
        var url1:String? = nil
        var url2:String? = nil
        var url3:String? = nil
        
        if favorites.productList.count > 2 {
            url3 = favorites.productList[2].image
        }
        
        if favorites.productList.count > 1 {
            url2 = favorites.productList[1].image
        }
        
        if favorites.productList.count > 0 {
            url1 = favorites.productList[0].image
        }
        
        return MyFavoritesViewModel(name: favorites.name, quantity: favorites.productList.count, url1: url1, url2: url2, url3: url3)
    }
    
    func getProductsViewModel(forIndex index: Int) -> ProductsViewModel{
        guard index < self.arrAllProducts.count else {
            return ProductsViewModel(imageUrl: "", linioPlusLevel: 0, conditionType: "", freeShipping: false, imported: false)
        }
        
        let product = self.arrAllProducts[index]
        
        return ProductsViewModel(imageUrl: product.image, linioPlusLevel: product.linioPlusLevel, conditionType: product.conditionType, freeShipping: product.freeShipping, imported: product.imported)
    }
}
