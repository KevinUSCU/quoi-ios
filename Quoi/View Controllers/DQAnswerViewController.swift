//
//  DQAnswerViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/31/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import SwiftyJSON

class DQAnswerViewController: UIViewController {
    
    // MARK: Properties
    let statsService: StatsService = StatsService()
    
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
        
        let question = QUOI_STATE.QUESTION_OF_THE_DAY!
        let answer = QUOI_STATE.QUESTION_ANSWER
        let gotCorrect = answer == question["answer"].int
        statusImage.image = gotCorrect ? #imageLiteral(resourceName: "status-check") : #imageLiteral(resourceName: "status-x")
        incorrectAnswer.text = !gotCorrect && answer != -1 ? "Your answer was:\n\(String(describing: question["choices"][answer!]))" : ""
        resultText.textColor = gotCorrect ? #colorLiteral(red: 0.002184122516, green: 0.7691982728, blue: 0.003388864949, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        if (gotCorrect) {
            resultText.text = "Correct"
        } else if (!gotCorrect && answer == -1) {
            resultText.text = "Time ran out!"
        } else {
            resultText.text = "Incorrect"
        }
        questionText.text = question["question"].string
        answerText.text = question["choices"][question["answer"].int!].string
        explanationText.text = question["explanation"] != JSON.null ? question["explanation"].string : ""
        
        // Reload stats so they'll be ready on return to dashboard
        statsService.getDashboardStats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
