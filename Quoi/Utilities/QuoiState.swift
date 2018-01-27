//
//  QuoiState.swift
//  Quoi
//
//  Created by Kevin Springer on 1/26/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Foundation

struct QUOI_STATE {
    static let API_URL = "http://127.0.0.1:3000/api" // localhost
    //static let API_URL = "https://" // heroku
    static var TOKEN: String?
    static var USERID: String?
    static var FIRSTNAME: String?
    static var LASTNAME: String?
    static var ROLE: String?
    static var tipOfTheDay: String?
}
