//
//  LogTableViewCell.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit

class LogTableViewCell : UITableViewCell{
    //MARK: - IBOutlets
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var hoursLabel: UILabel!
    
    //MARK: - Variables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

