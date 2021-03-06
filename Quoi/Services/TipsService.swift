//
//  TipsService.swift
//  Quoi
//
//  Created by Kevin Springer on 1/25/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

//import Foundation
//import UIKit
import Alamofire

protocol TipsServiceDelegate {
    func dataReady(sender: TipsService)
}

class TipsService : NSObject {
    
    var delegate: TipsServiceDelegate?
    var message: String?
    
    func getTipOfTheDay() {
        Alamofire.request("\(QUOI_STATE.API_URL)/tips/tipoftheday")
            .responseJSON { response in
                if let jsonData = response.data {
                    struct Object: Codable {
                        let Tip: String?
                        let Tips: String?
                        let message: String?
                    }
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode(Object.self, from: jsonData) {
                        QUOI_STATE.TIP_OF_THE_DAY = result.Tip
                        if self.delegate != nil && QUOI_STATE.TIP_OF_THE_DAY != nil {
                            self.delegate!.dataReady(sender: self)
                        }
                    }
                }
            }
    }
    
}

