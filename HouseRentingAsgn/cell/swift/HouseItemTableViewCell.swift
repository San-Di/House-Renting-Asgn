//
//  HouseItemTableViewCell.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/12/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import SDWebImage
class HouseItemTableViewCell: UITableViewCell {
    @IBOutlet weak var viewParentView: UIView!
    
    @IBOutlet weak var imgHouse: UIImageView!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var labelLocation: UILabel!
    
    @IBOutlet weak var labelArea: UILabel!
    
    @IBOutlet weak var labelDecoration: UILabel!
    
    @IBOutlet weak var viewPrice: UIView!
    
    @IBOutlet weak var viewGoToDetail: UIView!
    
    @IBOutlet weak var viewbottom: UIView!
    
    @IBOutlet weak var imgGoToDetail: UIImageView!
    var delegate: HouseListItemActionDelegate?
    
    var house: HouseVO? {
        didSet {
            if let house = house {
                
                let houseImage = house.houseImageUrl
                imgHouse.sd_setImage(with: URL(string: houseImage ?? ""), placeholderImage: UIImage(named: "placeholder"))
                
                if let price = house.price?.description {
                    labelPrice.text = "$ \(price)"
                }
                if let location = house.address {
                    labelLocation.text = location
                }
                if let sqft = house.squareFeet?.description {
                   labelArea.text = "\(sqft) sqft"
                    
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewGoToDetail.layer.cornerRadius = viewGoToDetail.bounds.height / 2
        imgGoToDetail.layer.cornerRadius = imgGoToDetail.bounds.height / 2
        
        viewPrice.layer.cornerRadius = 10
        imgHouse.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgHouse.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewParentView.layer.cornerRadius = 10
        //        btnViewDetail.layer.cornerRadius = 10
        viewbottom.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        viewbottom.layer.cornerRadius = 10
        
        initGestureRecognizer()
    }
    func initGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickViewDetail))
        viewGoToDetail.isUserInteractionEnabled = true
        viewGoToDetail.addGestureRecognizer(tapGesture)
    }
    
    @objc func onClickViewDetail() {
        delegate?.onClickHouseItemDetail(data: house)    }
}
