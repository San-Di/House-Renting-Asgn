//
//  HouseRentDetailViewController.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class HouseRentDetailViewController: UIViewController {

    @IBOutlet weak var imgHouse: UIImageView!

    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelSqFt: UILabel!
    
    @IBOutlet weak var labelFavourites: UILabel!
    
    @IBOutlet weak var labelBedrooms: UILabel!
    
    @IBOutlet weak var labelReviewers: UILabel!
    
    
    @IBOutlet weak var labelHouseName: UILabel!
    
    @IBOutlet weak var labelHouseDescription: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    static let identifier = "HouseRentDetailViewController"
    
    var mHouse : HouseVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("House ====< \( mHouse)")
       txtSearchField.borderStyle = .none
        
        if let url = mHouse?.houseImageUrl {
            imgHouse.sd_setImage(with: URL(string: url), completed: nil)
        }
        guard let data = mHouse else {return}
        
        if let price = data.price {
            labelPrice.text = "$ \(price)"
        }
        if let squareFeet = data.squareFeet {
            labelSqFt.text = "\(squareFeet) sqft"
        }
        labelHouseName.text = data.name
        labelLocation.text = data.address
        labelHouseDescription.text = data.description
        labelBedrooms.text = "4 bedrooms"
        labelReviewers.text = "23 Reviewers"
        
    }

    @IBAction func btnBacktoList(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
