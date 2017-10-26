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
    //MARK: - Variables
   
    
    //MARK: - Functions
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let view = viewFromNibForClass()
        
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UITableViewCell {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UITableViewCell
        
        return view
    }
}
