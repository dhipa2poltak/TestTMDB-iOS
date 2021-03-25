//
//  Review.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class Review: Codable {
    let author: String?
    let author_details: AuthorDetails?
    let content: String?
    let created_at: String?//Date?
    let id: String?
    let updated_at: String?//Date?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case author_details
        case content
        case created_at
        case id
        case updated_at
        case url
    }

    init(
        author: String?,
        author_details: AuthorDetails?,
        content: String?,
        created_at: String/*Date?*/,
        id: String?,
        updated_at: String/*Date?*/,
        url: String?
    ) {
        self.author = author
        self.author_details = author_details
        self.content = content
        self.created_at = created_at
        self.id = id
        self.updated_at = updated_at
        self.url = url
    }
}
