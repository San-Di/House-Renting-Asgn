//
//  HouseVO.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation

struct HouseVO: Codable {
    
    var id: Double?
    var name : String?
    var houseImageUrl: String?
    var description: String?
    var price: String?
    var address : String?
    var squareFeet : String?
    var latitude : Double?
    var longtitude: Double?
}
