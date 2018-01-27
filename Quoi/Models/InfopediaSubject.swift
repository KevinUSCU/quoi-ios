//
//  InfopediaSubject.swift
//  Quoi
//
//  Created by Kevin Springer on 1/27/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import Foundation

class InfopediaSubject {
    
    //MARK: Properties
    var subject: String
    var articles: [InfopediaArticle?]
    
    //MARK: Initialization
    init?(subject: String, articles: [InfopediaArticle]) {
        // Initialization should fail if there is no name or if the rating is negative
        if subject.isEmpty || articles.count < 1  {
            return nil
        }
        self.subject = subject
        self.articles = articles
    }
}
