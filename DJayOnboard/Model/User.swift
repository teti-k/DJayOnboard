//
//  User.swift
//  DJayOnboard
//
//  Created by Tetiana Karagodova on 25/11/2025.
//

class User: Codable {
    let userID: String
    let userName: String
    var level: ProficiencyLevel?

    init(userID: String, userName: String) {
        self.userID = userID
        self.userName = userName
    }
}
