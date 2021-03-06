//
//  InfopediaArticleViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/3/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class InfopediaArticleViewController: UIViewController {

    var article: InfopediaArticle?
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let article = article {
            categoryTitleLabel.text = "\(article.category): \(article.title)"
            articleTextLabel.text = article.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Button Handlers
    @IBAction func menuButton(_ sender: UIButton) {
        REMOVE_USER_PREFS()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(next!, animated: true, completion: nil)
    }
    
}
