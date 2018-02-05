//
//  QuoiState.swift
//  Quoi
//
//  Created by Kevin Springer on 1/26/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Foundation
import SwiftyJSON

struct QUOI_STATE {
    
    // MARK: API URL
    static let API_URL = "http://127.0.0.1:3000/api" // localhost
//    static let API_URL = "https://quoi-server.herokuapp.com/api" // heroku
    
    // MARK: Daily Data
    static var TIP_OF_THE_DAY: String?
    static var QUESTION_OF_THE_DAY: JSON?
    
    static var REVIEW_QUESTION: Question?
    
    // MARK: Inputs
    static var QUESTION_ANSWER: Int?
    
    // MARK: Stats
    static var DASHBOARD_STATS: JSON?
    static var DAILY_QUESTION_SUCCESS_RATE: JSON?
    
    // MARK: User Profile Data
    static var USERID: Int?
    static var FIRSTNAME: String?
    static var LASTNAME: String?
    static var ROLE: String?
    
    // MARK: User Prefs saved to disk
    static var TOKEN: String?
    
}

func SAVE_USER_PREFS() {
    let defaults = UserDefaults.standard
    defaults.set(QUOI_STATE.TOKEN.self, forKey: "token")
    defaults.synchronize()
}

func LOAD_USER_PREFS() {
    let defaults = UserDefaults.standard
    QUOI_STATE.TOKEN = defaults.string(forKey: "token")
}

func REMOVE_USER_PREFS() {
    // Delete values currently in memory
    QUOI_STATE.TOKEN = nil
    // Delete values currently on disk
    SAVE_USER_PREFS()
}
