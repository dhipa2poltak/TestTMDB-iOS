//
//  ProductionCountry.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class ProductionCountry: Codable {
    let iso31661: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }

    init(
        iso31661: String?,
        name: String?
    ) {
        self.iso31661 = iso31661
        self.name = name
    }
}
