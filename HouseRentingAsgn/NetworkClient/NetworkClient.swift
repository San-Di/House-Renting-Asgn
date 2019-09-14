//
//  NetworkClient.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient {
    
    private let baseUrl: String
    
    private init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    
    private static var sharedNetworkClient: NetworkClient = {
        let url = SharedConstants.BASE_URL
        return NetworkClient(baseUrl: url)
    }()
    
    
    class func shared() -> NetworkClient {
        return sharedNetworkClient
    }
    
    //escapgin => memory reference counting => left method to be called later
    public func getData(success: @escaping (Any) -> Void, failure: @escaping (String) -> Void ){
        Alamofire.request(baseUrl).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.result.value else { return }
                success(data)
                break
            case .failure(let err):
                failure(err.localizedDescription)
                break
            }
        }
        
        
    }
}
