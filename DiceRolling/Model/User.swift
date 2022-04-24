//
//  User.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 24/04/22.
//

import Foundation

struct User: Equatable {
    var name: String
    var data: [Int: [Int]]
    
    static let usersExample: [User] = [
        User(
            name: "Andrés",
            data: [
                1 : [4, 1, 6, 2],
                2 : [2, 7, 8],
                4 : [4, 9, 16, 24],
            ]
        ),
        User(name: "Natalia", data: [Int : [Int]]())
    ]
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name
    }
}
