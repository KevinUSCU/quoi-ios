//
//  InfopediaTableViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/3/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import os.log

class InfopediaTableViewController: UITableViewController, InfopediaServiceDelegate {
    
    // MARK: Properties
    let infopediaService = InfopediaService()
    var articles = [InfopediaArticle]()

    // MARK: Delegate Actions
    func dataReady(sender: InfopediaService) {
        self.articles = infopediaService.infopediaArticles
        self.tableView.reloadData()
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.infopediaService.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load the article data
        infopediaService.getInfopediaArticles()
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
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "InfopediaArticleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InfopediaArticleTableViewCell else {
            fatalError("The dequeued cell is not an instance of InfopediaArticleTableViewCell")
        }

        // Fetches the appropriate article for the data source layout
        let article = articles[indexPath.row]
        
        cell.articleCategoryLabel.text = article.category
        cell.articleTitleLabel.text = article.title

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        
        case "ShowArticle":
            guard let articleDetailViewController = segue.destination as? InfopediaArticleViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedArticleCell = sender as? InfopediaArticleTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedArticleCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedArticle = articles[indexPath.row]
            articleDetailViewController.article = selectedArticle
        
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
}
