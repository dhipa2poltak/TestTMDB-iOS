//
//  Genre.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class Genre: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
