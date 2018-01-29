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
    static let API_URL = "http://127.0.0.1:3000/api" // localhost
    //static let API_URL = "https://" // heroku
    static var QUESTION_OF_THE_DAY: JSON?
    static var QUESTION_ANSWER: Int?
    
    // Following are User Prefs; these will be saved to disk
    static var TOKEN: String?
    static var USERID: String?
    static var FIRSTNAME: String?
    static var LASTNAME: String?
    static var ROLE: String?
}

func SAVE_USER_PREFS() {
    let defaults = UserDefaults.standard
    defaults.set(QUOI_STATE.TOKEN.self, forKey: "token")
    defaults.set(QUOI_STATE.USERID.self, forKey: "userId")
    defaults.set(QUOI_STATE.FIRSTNAME.self, forKey: "firstname")
    defaults.set(QUOI_STATE.LASTNAME.self, forKey: "lastname")
    defaults.set(QUOI_STATE.ROLE.self, forKey: "role")
    defaults.synchronize()
}

func LOAD_USER_PREFS() {
    let defaults = UserDefaults.standard
    QUOI_STATE.TOKEN = defaults.string(forKey: "token")
    QUOI_STATE.USERID = defaults.string(forKey: "userId")
    QUOI_STATE.FIRSTNAME = defaults.string(forKey: "firstname")
    QUOI_STATE.LASTNAME = defaults.string(forKey: "lastname")
    QUOI_STATE.ROLE = defaults.string(forKey: "role")
}

func REMOVE_USER_PREFS() {
    // Delete values in memory
    QUOI_STATE.TOKEN = nil
    QUOI_STATE.USERID = nil
    QUOI_STATE.FIRSTNAME = nil
    QUOI_STATE.LASTNAME = nil
    QUOI_STATE.ROLE = nil
    // Delete from disk
    SAVE_USER_PREFS()
}
