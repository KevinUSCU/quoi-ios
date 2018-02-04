//
//  InfopediaTableViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/3/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import os.log

class InfopediaTableViewController: UITableViewController {
    
    // MARK: Properties
    var articles = [InfopediaArticle]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the article data
        loadInfopediaArticles()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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

    // MARK: Private Methods
    
    private func loadInfopediaArticles() {
        guard let article1 = InfopediaArticle(title: "Arrays", description: "Arrays are cool!", category: "JavaScript") else {
            fatalError("Unable to instantiate article")
        }
        guard let article2 = InfopediaArticle(title: "Objects", description: "Objects are spiffy", category: "JavaScript") else {
            fatalError("Unable to instantiate article")
        }
        articles += [article1, article2]
    }
}
