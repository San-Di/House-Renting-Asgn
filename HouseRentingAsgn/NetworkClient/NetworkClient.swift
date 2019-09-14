//
//  NetworkClient.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    
    public func getData(success: @escaping (Any) -> Void, failure: @escaping (String) -> Void ){
        Alamofire.request(SharedConstants.BASE_URL + SharedConstants.ApiRoute.GET_HOUSE_LIST ).responseData { (response) in
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
    
//    public func getDataByHttpHeader(header: HTTPHeaders, parameters: Parameters, success: @escaping (Any) -> Void, failure: @escaping (String) -> Void){
//
//    }
    public func getDataByHttpHeader(route: String, headers: HTTPHeaders, parameters: Parameters, success: @escaping (Any) -> Void, failure: @escaping (String) -> Void){
        
        Alamofire.request(SharedConstants.BASE_URL + route, method: .get, parameters: parameters, headers: headers).responseData { (response) in
            guard let data = response.result.value else { return }
            
            switch response.result {
            case .success:
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    
                    let baseResponse = try decoder.decode(BaseResponse.self, from: data)
                    
                    if(baseResponse.isResponseOK()) {
                        let json = JSON(response.result.value!) // got the whole json respone from network include => (code, message, data)
                        let data = json["data"] // now this time ( we index data from => ["data"]
                        success(data)
                    }else {
                        failure("")
                    }
                }catch let jsonErr {
                    failure(jsonErr.localizedDescription)
                }
                break
                
            case .failure(let err):
                failure(err.localizedDescription)
                break
            }
        }
    }
    
    func postFormData(route: String, headers: HTTPHeaders, parameters: Parameters, success: @escaping (Any) -> Void, failure: @escaping (String) -> Void){
        
        Alamofire.request(SharedConstants.BASE_URL + route, method: .get, parameters: parameters, headers: headers).responseData { (response) in
            guard let data = response.result.value else { return }
            
            switch response.result {
            case .success:
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    
                    let baseResponse = try decoder.decode(BaseResponse.self, from: data)
                    
                    if(baseResponse.isResponseOK()) {
                        let json = JSON(response.result.value!) // got the whole json respone from network include => (code, message, data)
                        let data = json["data"] // now this time ( we index data from => ["data"]
                        success(data)
                    }else {
                        failure("")
                    }
                }catch let jsonErr {
                    failure(jsonErr.localizedDescription)
                }
                break
                
            case .failure(let err):
                failure(err.localizedDescription)
                break
            }
        }
    }
    
    
    func postRawData(request: URLRequest, success: @escaping (Any) -> Void, failure: @escaping (String) -> Void){
        Alamofire.request(request).responseData { (response) in
            guard let data = response.result.value else { return }
            
            switch response.result {
            case .success:
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    
                    let baseResponse = try decoder.decode(BaseResponse.self, from: data)
                    
                    if(baseResponse.isResponseOK()) {
                        let json = JSON(response.result.value!) // got the whole json respone from network include => (code, message, data)
                        let data = json["data"] // now this time ( we index data from => ["data"]
                        success(data)
                    }else {
                        failure("")
                    }
                }catch let jsonErr {
                    failure(jsonErr.localizedDescription)
                }
                break
                
            case .failure(let err):
                failure(err.localizedDescription)
                break
            }
        }
    }
    
}
