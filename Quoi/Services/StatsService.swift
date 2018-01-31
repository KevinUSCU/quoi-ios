//
//  StatsService.swift
//  Quoi
//
//  Created by Kevin Springer on 1/30/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol StatsServiceDelegate {
    func dataReady(sender: StatsService)
}

class StatsService : NSObject {
    
    var delegate: StatsServiceDelegate?
    var dashboardStats: JSON?
    var message: String?
    
    func getDashboardStats() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(QUOI_STATE.TOKEN!)",
            "Accept": "application/json"
        ]
        Alamofire.request("\(QUOI_STATE.API_URL)/stats/dashboardstatus/\(QUOI_STATE.USERID!)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.dashboardStats = json["Stats"]
            case .failure(let error):
                let json = JSON(error)
                self.message = "\(json["message"])"
            }
            if self.delegate != nil {
                self.delegate!.dataReady(sender: self)
            }
        }
    }
    
}
