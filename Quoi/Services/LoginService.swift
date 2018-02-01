//
//  LoginService.swift
//  Quoi
//
//  Created by Kevin Springer on 1/24/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

//import Foundation
import Alamofire
import SwiftyJSON

protocol LoginServiceDelegate {
    func dataReady(sender: LoginService)
}

class LoginService : NSObject {
    
    var delegate: LoginServiceDelegate?
    var message: String?
    
    func login(email: String, password: String) {
        let parameters = [ "email": email, "password": password ]
        Alamofire.request("\(QUOI_STATE.API_URL)/auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let jsonData = response.data {
                    struct Object: Codable {
                        let Auth: String?
                        let message: String?
                    }
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode(Object.self, from: jsonData) {
                        QUOI_STATE.TOKEN = result.Auth
                        if (QUOI_STATE.TOKEN != nil) {
                            self.setStateWithUserDataFromToken(token: QUOI_STATE.TOKEN!, firstVisit: false)
                        }
                        else {
                            self.message = result.message!
                            if self.delegate != nil {
                                self.delegate!.dataReady(sender: self)
                            }
                        }
                    }
                }
            }
    }
    
    func signup(firstname: String, lastname: String, email: String, password: String) {
        let parameters = [ "firstname": firstname, "lastname": lastname, "email": email, "password": password ]
        Alamofire.request("\(QUOI_STATE.API_URL)/auth/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let jsonData = response.data {
                    struct Object: Codable {
                        let Auth: String?
                        let message: String?
                    }
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode(Object.self, from: jsonData) {
                        QUOI_STATE.TOKEN = result.Auth
                        if QUOI_STATE.TOKEN != nil {
                            self.setStateWithUserDataFromToken(token: QUOI_STATE.TOKEN!, firstVisit: true)
                        }
                        else {
                            self.message = result.message!
                            if self.delegate != nil {
                                self.delegate!.dataReady(sender: self)
                            }
                        }
                    }
                }
            }
    }
    
    func setStateWithUserDataFromToken(token: String, firstVisit: Bool) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
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
                SAVE_USER_PREFS()
                self.message = firstVisit ? "Welcome to Quoi, \(QUOI_STATE.FIRSTNAME!)!" : "Welcome back, \(QUOI_STATE.FIRSTNAME!)"
            case .failure(let error):
                let json = JSON(error)
                self.message = "\(json["message"])"
                // Remove user data (in case a token existed for a user that no longer exists
                REMOVE_USER_PREFS()
            }
            if self.delegate != nil {
                self.delegate!.dataReady(sender: self)
            }
        }
    }
}
