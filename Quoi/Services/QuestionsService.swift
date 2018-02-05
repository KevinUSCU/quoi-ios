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
    var reviewQuestions = [Question]()
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
    
    func recordDailyQuestionAnswer(answer: Int, considersRelevant: Bool) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(QUOI_STATE.TOKEN!)",
            "Accept": "application/json"
        ]
        let parameters = [ "answer": answer, "considersRelevant": considersRelevant ] as [String: Any]
        Alamofire.request("\(QUOI_STATE.API_URL)/questions/dailyquestionanswer/\(QUOI_STATE.USERID!)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.message = "\(json["Answer"])"
            case .failure(let error):
                let json = JSON(error)
                self.message = "\(json["message"])"
            }
            if self.delegate != nil {
                self.delegate!.dataReady(sender: self)
            }
        }
    }
    
    func getReviewQuestions() {
        self.reviewQuestions.removeAll()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(QUOI_STATE.TOKEN!)",
            "Accept": "application/json"
        ]
        Alamofire.request("\(QUOI_STATE.API_URL)/questions/foruser/\(QUOI_STATE.USERID!)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let jsonQuestions = json["Questions"]
                for (_,subJson):(String, JSON) in jsonQuestions {
                    let id = subJson["id"].int
                    let question = subJson["question"].string
                    var choices = [String]()
                    let choicesJson = JSON.init(parseJSON: subJson["choices"].string!)
                    for (_,subJson):(String, JSON) in choicesJson {
                        choices.append(subJson.stringValue)
                    }
                    let answer = subJson["answer"].int
                    var answerHistory = [Bool]()
                    let answerHistoryJson = JSON.init(parseJSON: subJson["answer_history"].string!)
                    for (_,subJson):(String, JSON) in answerHistoryJson {
                        answerHistory.append(subJson.boolValue)
                    }
                    let explanation = subJson["explanation"].string
                    let infopediaId = subJson["infopedia_id"].int
                    let imageUrl = subJson["image_url"].string
                    let deleted = subJson["deleted"].bool

                    let reviewQuestion = Question(id: id, userId: QUOI_STATE.USERID, question: question!, choices: choices, answer: answer!, answerHistory: answerHistory, answeredCorrectly: nil, explanation: explanation, infopediaId: infopediaId, imageUrl: imageUrl, deleted: deleted)
                    self.reviewQuestions.append(reviewQuestion!)
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
