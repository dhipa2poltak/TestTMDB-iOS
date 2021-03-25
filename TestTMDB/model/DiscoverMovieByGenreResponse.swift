//
//  DiscoverMovieByGenreResponse.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class DiscoverMovieByGenreResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let total_pages: Int?
    let total_results: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case total_pages
        case total_results
    }

    init(
        page: Int?,
        results: [Movie]?,
        total_pages: Int?,
        total_results: Int?
    ) {
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
}
