//
//  BaseResponse.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation


struct BaseResponse: Codable {
    var code: Int?
    var message: String?
    
    var error: ErrorVO?
    
    func isResponseOK() -> Bool {
        if let code = code, code > 0 {
            if code == 200 {
                return true
            }else{
                return false
            }
            
        }
        return false
        }
}
