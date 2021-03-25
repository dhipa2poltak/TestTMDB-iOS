//
//  Trailer.swift
//  TestTMDB
//
//  Created by user on 25/03/21.
//

import Foundation

class Trailer: Codable {
    let id: String?
    let iso_639_1: String?
    let iso_3166_1: String?
    let key: String?
    let name: String?
    let site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso_639_1
        case iso_3166_1
        case key
        case name
        case site
        case size
        case type
    }

    init(
        id: String?,
        iso_639_1: String?,
        iso_3166_1: String?,
        key: String?,
        name: String?,
        site: String?,
        size: Int?,
        type: String?
    ) {
        self.id = id
        self.iso_639_1 = iso_639_1
        self.iso_3166_1 = iso_3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
}
