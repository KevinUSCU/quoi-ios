//
//  QuestionModel.swift
//  Quoi
//
//  Created by Kevin Springer on 1/28/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Foundation
import SwiftyJSON

class Question {
    //MARK: Properties
    var id: Int?
    var userId: Int?
    var answerHistory: [Bool?]?
    var answeredCorrectly: Bool?
    var question: String
    var choices: [String?]
    var answer: Int
    var explanation: String?
    var infopediaId: Int?
    var imageUrl: String?
    var deleted: Bool
    
    //MARK: Initialization
    init?(id: Int?, userId: Int?, question: String, choices: [String], answer: Int, answerHistory: [Bool]?, answeredCorrectly: Bool?, explanation: String?, infopediaId: Int?, imageUrl: String?, deleted: Bool?) {
        // Initialization should fail if missing required conditions
        if question.isEmpty || choices.count != 4  {
            print("couldn't initialize Question")
            return nil
        }
        self.id = id
        self.userId = userId
        self.question = question
        self.choices = choices
        self.answer = answer
        self.answerHistory = answerHistory
        self.answeredCorrectly = answeredCorrectly
        self.explanation = explanation
        self.infopediaId = infopediaId
        self.imageUrl = imageUrl
        self.deleted = deleted != nil ? deleted! : false
    }
}
