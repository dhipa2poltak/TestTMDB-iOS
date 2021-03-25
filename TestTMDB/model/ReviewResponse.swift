//
//  ReviewResponse.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class ReviewResponse: Codable {
    let id: Int?
    let page: Int?
    let results: [Review]?
    let total_pages: Int?
    let total_results: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case total_pages
        case total_results
    }

    init(
        id: Int?,
        page: Int?,
        results: [Review]?,
        total_pages: Int?,
        total_results: Int?
    ) {
        self.id = id
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
}
