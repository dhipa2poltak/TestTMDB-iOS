//
//  GenreResponse.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class GenreResponse: Codable {
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case genres
    }

    init(genres: [Genre]?) {
        self.genres = genres
    }
}
