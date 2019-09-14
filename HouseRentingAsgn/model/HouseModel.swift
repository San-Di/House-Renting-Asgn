//
//  HouseModel.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation

class HouseModel {
    private static var sharedHouseModel: HouseModel = {
        
        let houseModel = HouseModel()
        return houseModel
    }()
    
    
    class func shared() -> HouseModel {
        return sharedHouseModel
    }
    
    
    var houseResponse: HouseResponse = HouseResponse()
    
    func apiGetHouseList(success: @escaping () -> Void, failure: @escaping (String) -> Void ) {
        NetworkClient.shared().getData(success: { (data) in
            guard let data = data as? Data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self.houseResponse = try decoder.decode(HouseResponse.self, from: data)
                success()
            }catch let jsonErr {
                failure(jsonErr.localizedDescription)
            }
        }) { (err) in
            failure(err)
        }
    }
}
