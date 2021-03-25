//
//  ProductionCompany.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class ProductionCompany: Codable {
    let name: String?
    let origin_country: String?
    let logo_path: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case origin_country
        case logo_path
        case id
    }

    init(
        name: String?,
        origin_country: String?,
        logo_path: String?,
        id: Int?
    ) {
        self.name = name
        self.origin_country = origin_country
        self.logo_path = logo_path
        self.id = id
    }
}
