//
//  ReviewQuestionViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/4/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReviewQuestionViewController: UIViewController {
        
    // MARK: Properties
    var reviewQuestion: Question?
    
    // MARK: View References
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerAText: UIButton!
    @IBOutlet weak var answerBText: UIButton!
    @IBOutlet weak var answerCText: UIButton!
    @IBOutlet weak var answerDText: UIButton!
    
   
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Display question on page
        if let reviewQuestion = reviewQuestion {
            questionField.text = reviewQuestion.question
            answerAText.setTitle(reviewQuestion.choices[0], for: .normal)
            answerBText.setTitle(reviewQuestion.choices[1], for: .normal)
            answerCText.setTitle(reviewQuestion.choices[2], for: .normal)
            answerDText.setTitle(reviewQuestion.choices[3], for: .normal)
            // Put question in state (temporary solution)
            QUOI_STATE.REVIEW_QUESTION = reviewQuestion
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    //MARK: Button Handlers
    
    @IBAction func answerAButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 0
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ReviewQuestionAnswer")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func answerBButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 1
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ReviewQuestionAnswer")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func answerCButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 2
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ReviewQuestionAnswer")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func answerDButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 3
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ReviewQuestionAnswer")
        self.present(next!, animated: true, completion: nil)
    }
    
}

