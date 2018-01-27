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
    
    //MARK: Initialization
    init?(title: String, description: String) {
        // Initialization should fail if there is no name or if the rating is negative
        if title.isEmpty || description.isEmpty  {
            return nil
        }
        self.title = title
        self.description = description
    }
}
