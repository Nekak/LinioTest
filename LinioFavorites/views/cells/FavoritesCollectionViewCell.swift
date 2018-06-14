//
//  FavoritesCollectionViewCell.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ribbonsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        for subview in self.ribbonsView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func putRibbons(plus: Int, andImported isImported: Bool, andCondition condition: String, andFreeShipping isFreeShipping: Bool){
        
        var height:CGFloat = 0
        let width = self.ribbonsView.frame.width
        
        if plus == 1 || plus == 2 {
            self.createIVRibbon(image: plus == 1 ? "ic_plus" : "ic_plus_48" , height: height, width: width)
            height += width
        }
        
        if isImported {
            self.createIVRibbon(image: "ic_airplane", height: height, width: width)
            height += width
        }
        
        if condition == "refurbished" {
            self.createIVRibbon(image: "ic_refresh", height: height, width: width)
            height += width
        }else if condition == "new"{
            self.createIVRibbon(image: "ic_new", height: height, width: width)
            height += width
        }
        
        if isFreeShipping {
            self.createIVRibbon(image: "ic_truck", height: height, width: width)
            height += width
        }
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func createIVRibbon(image: String, height: CGFloat, width: CGFloat){
        let ivRibbon = UIImageView(frame: CGRect(x: 0, y: height, width: width, height: width))
        ivRibbon.contentMode = .scaleAspectFit
        ivRibbon.image = UIImage(named: image)
        
        self.ribbonsView.addSubview(ivRibbon)
    }
}
