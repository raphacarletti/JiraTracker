//
//  User.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation

class User {
    var email : String!
    var uid : String!
    var name : String!
    
    init(email: String, uid: String, name: String) {
        self.email = email
        self.uid = uid
        self.name = name
    }
}
