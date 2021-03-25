//
//  SpokenLanguage.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class SpokenLanguage: Codable {
    let iso_639_1: String?
    let name: String?
    let english_name: String?

    enum CodingKeys: String, CodingKey {
        case iso_639_1
        case name
        case english_name
    }

    init(
        iso_639_1: String?,
        name: String?,
        english_name: String?
    ) {
        self.iso_639_1 = iso_639_1
        self.name = name
        self.english_name = english_name
    }
}
