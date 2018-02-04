//
//  InfopediaService.swift
//  Quoi
//
//  Created by Kevin Springer on 2/3/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol InfopediaServiceDelegate {
    func dataReady(sender: InfopediaService)
}

class InfopediaService : NSObject {
    
    var delegate: InfopediaServiceDelegate?
    var infopediaArticles = [InfopediaArticle]()
    var message: String?
    
    func getInfopediaArticles() {
        self.infopediaArticles.removeAll()
        
        Alamofire.request("\(QUOI_STATE.API_URL)/infopedia").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonArticles = json["Infopedias"]
                for (_,subJson):(String, JSON) in jsonArticles {
                    let title = subJson["title"].string
                    let category = subJson["category"].string
                    let description = subJson["description"].string
                    let article = InfopediaArticle(
                        title: title != nil ? title! : "",
                        description: description != nil ? description! : "",
                        category: category != nil ? category! : ""
                    )
                    self.infopediaArticles.append(article!)
                }
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

