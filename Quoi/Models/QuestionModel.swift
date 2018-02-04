//
//  QuestionModel.swift
//  Quoi
//
//  Created by Kevin Springer on 1/28/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Foundation

class Question {
    //MARK: Properties
    var id: Int?
    var userId: Int?
    var answeredCorrectly: Bool?
    var question: String
    var choices: [String]
    var answer: Int
    var explanation: String?
    var infopediaId: Int?
    var imageUrl: String?
    var deleted: Bool
    
    //MARK: Initialization
    init?(question: String, choices: [String], answer: Int, explanation: String?, infopediaId: Int?, imageUrl: String?) {
        // Initialization should fail if missing required conditions
        if question.isEmpty || choices.count != 4  {
            return nil
        }
        self.question = question
        self.choices = choices
        self.answer = answer
        self.explanation = explanation
        self.infopediaId = infopediaId
        self.imageUrl = imageUrl
        self.deleted = false
    }
}
