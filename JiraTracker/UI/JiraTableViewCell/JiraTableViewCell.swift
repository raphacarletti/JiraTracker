//
//  JiraTableViewCell.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit

class JiraTableViewCell : UITableViewCell{
    //MARK: - IBOutlets
    
    @IBOutlet var jiraDescription: UILabel!
    @IBOutlet var jiraName: UILabel!
    
    //MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
