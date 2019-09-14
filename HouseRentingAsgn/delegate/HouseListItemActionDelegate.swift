//
//  HouseListItemAction.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation

protocol HouseListItemActionDelegate {
    
    
    
    // 1. create a protocol (interface)
    //2. extend dat protocol in view controller ( view controller wold be the one who implement logic of degelate function)
    //3. give 'self' to delegate variable
    //4. declare delegate as a variable
    func onClickHouseItemDetail()
}
