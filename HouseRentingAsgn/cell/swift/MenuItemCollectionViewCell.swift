//
//  MenuItemCollectionViewCell.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/12/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelMenuItem: UILabel!
    
    @IBOutlet weak var viewMenuIndicator: UIView!
    
    var mData: String!{
        didSet{
            labelMenuItem.text = mData
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMenuIndicator.layer.cornerRadius = viewMenuIndicator.bounds.height / 2
    }

}
