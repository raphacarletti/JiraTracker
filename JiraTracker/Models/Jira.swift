//
//  Jira.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation

class Jira {
    var name : String!
    var description : String!
    var logs : [Log] = []
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
