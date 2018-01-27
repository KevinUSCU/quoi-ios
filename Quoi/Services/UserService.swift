//
//  UserService.swift
//  Quoi
//
//  Created by Kevin Springer on 1/26/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Alamofire
import SwiftyJSON

class UserService: NSObject {
    
//    var id: Int?
//    var firstname: String?
//    var lastname: String?
    
    
    func getUserFromTokenToState(token: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(QUOI_STATE.TOKEN ?? "")",
            "Accept": "application/json"
        ]
        Alamofire.request("\(QUOI_STATE.API_URL)/users/fromtoken", headers: headers).responseJSON { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                QUOI_STATE.USERID = "\(json["User"]["id"])"
                QUOI_STATE.FIRSTNAME = "\(json["User"]["firstname"])"
                QUOI_STATE.LASTNAME = "\(json["User"]["lastname"])"
                QUOI_STATE.ROLE = "\(json["User"]["role"])"
                print("\(QUOI_STATE.FIRSTNAME!)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
