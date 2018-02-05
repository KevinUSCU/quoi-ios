//
//  ReviewQuestionAnswerViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/4/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReviewQuestionAnswerViewController: UIViewController {
        
    // MARK: Properties
    
    
    // MARK: View References
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var incorrectAnswer: UILabel!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var explanationText: UILabel!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let question = QUOI_STATE.REVIEW_QUESTION!
        let answer = QUOI_STATE.QUESTION_ANSWER
        let gotCorrect = answer == question.answer
        statusImage.image = gotCorrect ? #imageLiteral(resourceName: "status-check") : #imageLiteral(resourceName: "status-x")
        incorrectAnswer.text = !gotCorrect && answer != -1 ? "Your answer was:\n\(String(describing: question.choices[answer!]))" : ""
        resultText.textColor = gotCorrect ? #colorLiteral(red: 0.002184122516, green: 0.7691982728, blue: 0.003388864949, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        if (gotCorrect) {
            resultText.text = "Correct"
        } else {
            resultText.text = "Incorrect"
        }
        questionText.text = question.question
        answerText.text = question.choices[question.answer]
        explanationText.text = question.explanation != nil ? question.explanation : ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

