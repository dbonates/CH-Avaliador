//
//  User.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let email: String
    var score: Int = 0
}

extension User {
    init?(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
