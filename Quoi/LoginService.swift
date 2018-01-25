//
//  LoginService.swift
//  Quoi
//
//  Created by Kevin Springer on 1/24/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

//import Foundation
import UIKit
import Alamofire

protocol LoginServiceDelegate {
    func dataReady(sender: LoginService)
}

class LoginService : NSObject {
    let API_URL = "http://127.0.0.1:3000/api" // localhost
    //let API_URL = "https://" // heroku
    var delegate: LoginServiceDelegate?
    var token: String?
    var message: String?
    
    func login(email: String, password: String) {
        let parameters = [ "email": email, "password": password ]
        Alamofire.request("\(API_URL)/auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let jsonData = response.data {
                    struct Object: Codable {
                        let Auth: String?
                        let message: String?
                    }
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode(Object.self, from: jsonData) {
                        self.token = result.Auth
                        self.message = (self.token != nil) ? "Welcome back!" : result.message!
                        if self.delegate != nil {
                            self.delegate!.dataReady(sender: self)
                        }
                    }
                }
        }
    }
}
