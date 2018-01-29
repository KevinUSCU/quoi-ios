//
//  QuestionsService.swift
//  Quoi
//
//  Created by Kevin Springer on 1/28/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol QuestionsServiceDelegate {
    func dataReady(sender: QuestionsService)
}

class QuestionsService : NSObject {
    
    var delegate: QuestionsServiceDelegate?
    var message: String?
    
    func getQuestionOfTheDay() {
        Alamofire.request("\(QUOI_STATE.API_URL)/questions/questionoftheday").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                QUOI_STATE.QUESTION_OF_THE_DAY = json["Question"]
                // We need to further parse the choices portion, because it is an array inside a string (from the db)
                let choices = JSON.init(parseJSON: QUOI_STATE.QUESTION_OF_THE_DAY!["choices"].string!)
                QUOI_STATE.QUESTION_OF_THE_DAY!["choices"] = choices
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
