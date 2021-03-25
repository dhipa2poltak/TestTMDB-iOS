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
    let avatar_path: String?
    let rating: Float?

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatar_path
        case rating
    }

    init(
        name: String?,
        username: String?,
        avatar_path: String?,
        rating: Float?
    ) {
        self.name = name
        self.username = username
        self.avatar_path = avatar_path
        self.rating = rating
    }
}
