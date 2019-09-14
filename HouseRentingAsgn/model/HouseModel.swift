//
//  HouseModel.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HouseModel {
    private static var sharedHouseModel: HouseModel = {
        
        let houseModel = HouseModel()
        return houseModel
    }()
    
    
    class func shared() -> HouseModel {
        return sharedHouseModel
    }
    
    
    var houseResponse: HouseResponse = HouseResponse()
    var house: HouseVO?
    
    func apiGetHouseList(success: @escaping () -> Void, failure: @escaping (String) -> Void ) {
        NetworkClient.shared().getData(success: { (data) in
            guard let data = data as? Data else { return }
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase

                self.houseResponse = try decoder.decode(HouseResponse.self, from: data)
                success()
            }catch let jsonErr {
                failure(jsonErr.localizedDescription)
            }
        }) { (err) in
            failure(err)
        }
        
    }
    
    
    func apiGetHouseById(houseId: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        
        let headers: HTTPHeaders = [
            SharedConstants.PARAM.PARAM_HOUSE_ID : String(houseId)
        ]
        NetworkClient.shared().getDataByHttpHeader(route: SharedConstants.ApiRoute.GET_HOUSE_BY_ID, headers: headers, parameters: [:], success: { (data) in
            
            guard let data = data as? JSON else { return }
            
            // ************ you got json type from network client response => **BUT ** you got to typecast to DATA type in decoder.decode method
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self.house = try decoder.decode(HouseVO.self, from: Data(data.rawData()))
                success()
            } catch let jsonErr {
                failure(jsonErr.localizedDescription)
            }
        }) { (err) in
            failure(err)
        }
    }
    
    func apiGetHouseByIdWithFormData(houseId: String, success: @escaping() -> Void, failure: @escaping(String) -> Void) {
        
        let parameters: Parameters = [
            SharedConstants.PARAM.PARAM_HOUSE_ID : String(houseId)
        ]
        
        NetworkClient.shared().postFormData(route: SharedConstants.ApiRoute.GET_HOUSE_BY_FORM_DATA, headers: [:], parameters: parameters, success: { (data) in
            
            
            guard let data = data as? JSON else { return }
            
            // ************ you got json type from network client response => **BUT ** you got to typecast to DATA type in decoder.decode method
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self.house = try decoder.decode(HouseVO.self, from: Data(data.rawData()))
                success()
            } catch let jsonErr {
                failure(jsonErr.localizedDescription)
            }
            
        }) { (err) in
            failure(err)
        }
    }
    
    func apiGetHouseByIdWithRequestObject(houseRequest: HouseRequest, success: @escaping() -> Void, failure: @escaping(String) -> Void){
        
        var request = URLRequest(url: URL(string: SharedConstants.BASE_URL + SharedConstants.ApiRoute.GET_HOUSE_BY_ID_WITH_REQUEST_OBJECT)!)
        
        request.httpMethod = "POST"
        request.setValue(SharedConstants.REQUEST_TYPE.REQUEST_TYPE_FORM_URLENCODED, forHTTPHeaderField: SharedConstants.REQUEST_TYPE.CONTENT_TYPE)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        do {
            
            request.httpBody = try encoder.encode(houseRequest)
            
        }catch let jsonErr {
            failure(jsonErr.localizedDescription)
        }
        
        
        NetworkClient.shared().postRawData(request: request, success: { (data) in
            guard let data = data as? JSON else { return }
            
            // ************ you got json type from network client response => **BUT ** you got to typecast to DATA type in decoder.decode method
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self.house = try decoder.decode(HouseVO.self, from: Data(data.rawData()))
                success()
            } catch let jsonErr {
                failure(jsonErr.localizedDescription)
            }
        }) { (err) in
            failure(err)
        }
    }
    
}
