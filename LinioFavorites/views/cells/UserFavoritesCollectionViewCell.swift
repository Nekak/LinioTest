//
//  UserFavoritesCollectionViewCell.swift
//  LinioFavorites
//
//  Created by Nekak Kinich on 12/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import UIKit

class UserFavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var lName: UILabel!
    @IBOutlet var lTotal: UILabel!
    
    @IBOutlet var ivLeft: UIImageView!
    @IBOutlet var ivTopRight: UIImageView!
    @IBOutlet var ivBottomRight: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
