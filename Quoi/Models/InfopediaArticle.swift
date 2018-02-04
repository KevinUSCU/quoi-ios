//
//  InfopediaArticle.swift
//  
//
//  Created by Kevin Springer on 1/27/18.
//

import Foundation

class InfopediaArticle {
    
    //MARK: Properties
    var title: String
    var description: String
    var category: String
    
    //MARK: Initialization
    init?(title: String, description: String, category: String) {
        // Initialization should fail if parameters are missing
        if title.isEmpty || description.isEmpty || category.isEmpty  {
            return nil
        }
        self.title = title
        self.description = description
        self.category = category
    }
}
