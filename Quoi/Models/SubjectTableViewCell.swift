//
//  SubjectTableViewCell.swift
//  Quoi
//
//  Created by Kevin Springer on 1/27/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var subjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
