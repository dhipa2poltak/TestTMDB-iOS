//
//  ProductionCountry.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class ProductionCountry: Codable {
    let iso_3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso_3166_1
        case name
    }

    init(
        iso_3166_1: String?,
        name: String?
    ) {
        self.iso_3166_1 = iso_3166_1
        self.name = name
    }
}
