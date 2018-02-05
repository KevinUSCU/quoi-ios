//
//  ReviewQuestionsTableViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/4/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import os.log

class ReviewQuestionsTableViewController: UITableViewController, QuestionsServiceDelegate {
    
    // MARK: Properties
    let questionsService = QuestionsService()
    var reviewQuestions = [Question]()
    
    // MARK: Delegate Actions
    func dataReady(sender: QuestionsService) {
        self.reviewQuestions = questionsService.reviewQuestions
        self.tableView.reloadData()
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionsService.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load the review questions data
        questionsService.getReviewQuestions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewQuestions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "ReviewQuestionsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ReviewQuestionsTableViewCell else {
            fatalError("The dequeued cell is not an instance of ReviewQuestionsTableViewCell")
        }
        
        // Fetches the appropriate question for the data source layout
        let reviewQuestion = reviewQuestions[indexPath.row]
        
        cell.questionLabel.text = reviewQuestion.question
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowReviewQuestion":
            guard let reviewQuestionsDetailViewController = segue.destination as? ReviewQuestionViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedReviewQuestionsCell = sender as? ReviewQuestionsTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedReviewQuestionsCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedReviewQuestion = reviewQuestions[indexPath.row]
            reviewQuestionsDetailViewController.reviewQuestion = selectedReviewQuestion
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
}

