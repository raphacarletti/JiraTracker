//
//  Users.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation

class Users {
    static let shared = Users()
    var users : [User] = []
    
    private init() { }
}
