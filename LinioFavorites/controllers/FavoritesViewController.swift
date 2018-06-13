//
//  FavoritesViewController.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import UIKit
import AlamofireImage

class FavoritesViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var viewNoData: UILabel!
    
    var refreshControl: UIRefreshControl?
    
    var favoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        
        self.viewNoData.text = "No hay datos que mostrar.\nToca aquí para recargar."
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl!
        } else {
            collectionView.addSubview(refreshControl!)
        }
        
        refreshControl?.addTarget(favoritesViewModel, action: #selector(favoritesViewModel.fetchData), for: .valueChanged)
        
        self.setupCollectionViewIdentifiers()
        self.setupClosuresViewModel()
        
        self.favoritesViewModel.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionViewIdentifiers(){
        let nibHeader = UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
        let nibUserFavs = UINib(nibName: "UserFavoritesCollectionViewCell", bundle: nil)
        let nibFavorites = UINib(nibName: "FavoritesCollectionViewCell", bundle: nil)
        
        collectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(nibUserFavs, forCellWithReuseIdentifier: userFavsIdentifier)
        collectionView.register(nibFavorites, forCellWithReuseIdentifier: favoritesIdentifier)
    }
    
    func setupClosuresViewModel(){
        favoritesViewModel.updateDownloadStatus = { (isLoading, error) in
            if isLoading == true {
                self.showActivityIndicator()
            }else{
                self.refreshControl?.perform(#selector(self.refreshControl?.endRefreshing), with: nil, afterDelay: 0.5)
                
                let hasData = self.favoritesViewModel.hasData()
                
                self.collectionView.isHidden = !hasData
                self.viewNoData.isHidden = hasData
                
                self.hideActivityIndicator(completion: {
                    if error != nil {
                        self.showAlertViewWith(title: "¡Aviso!", andMessage: error!, completion: nil)
                    }else{
                        self.collectionView.reloadData()
                    }
                })
            }
        }
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem){
        self.showAlertViewWith(title: "¡Linio!", andMessage: "Se presiona botón de agregar", completion: nil)
    }
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer){
        self.favoritesViewModel.fetchData()
    }

    //MARK: - UICollectionViewDelegate/DataSource
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? HeaderCollectionReusableView
        
        headerView?.lTitle.text = indexPath.section == 1 ? "Todos mis favoritos (\(favoritesViewModel.getFavoritesCount()))" : ""
        
        headerView?.backgroundColor = UIColor.clear
        
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? favoritesViewModel.getMyFavoritesCount() : favoritesViewModel.getFavoritesCount()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userFavsIdentifier, for: indexPath) as? UserFavoritesCollectionViewCell
            
            let mfvm = favoritesViewModel.getMyFavoritesViewModel(forIndex: indexPath.row)
            
            cell?.lName.text = mfvm.name
            cell?.lTotal.text = "\(mfvm.quantity)"
            
            if let url1 = mfvm.url1, let urlIL = URL(string: url1) {
                cell?.ivLeft.af_setImage(withURL: urlIL)
            }
            
            if let url2 = mfvm.url2, let urlTR = URL(string: url2) {
                cell?.ivTopRight.af_setImage(withURL: urlTR)
            }
            
            if let url3 = mfvm.url3, let urlBR = URL(string: url3) {
                cell?.ivBottomRight.af_setImage(withURL: urlBR)
            }
            
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoritesIdentifier, for: indexPath) as? FavoritesCollectionViewCell
            
            let pvm = favoritesViewModel.getProductsViewModel(forIndex: indexPath.row)
            
            if let url = URL(string: pvm.imageUrl) {
                cell?.imageView.af_setImage(withURL: url)
            }
            
            return cell!
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) - 20
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 15, 10, 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 40)
    }
}
