//
//  Logged.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation

class Log {
    var key : String!
    var dateInitial : String!
    var hours : Int!
    var name : String!
    
    init(dateInitial: String, hours: Int, key: String, name: String) {
        self.dateInitial = dateInitial
        self.hours = hours
        self.key = key
        self.name = name
    }
}
