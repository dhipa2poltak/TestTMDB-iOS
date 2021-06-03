//
//  AuthorDetails.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class AuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Float?

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }

    init(
        name: String?,
        username: String?,
        avatarPath: String?,
        rating: Float?
    ) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}
