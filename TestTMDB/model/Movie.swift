//
//  Movie.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class Movie: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Float?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Float?
    let vote_count: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case genre_ids
        case id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case video
        case vote_average
        case vote_count
    }

    init(
        adult: Bool?,
        backdrop_path: String?,
        genre_ids: [Int]?,
        id: Int?,
        original_language: String?,
        original_title: String?,
        overview: String?,
        popularity: Float?,
        poster_path: String?,
        release_date: String?,
        title: String?,
        video: Bool?,
        vote_average: Float?,
        vote_count: Int?
    ) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.genre_ids = genre_ids
        self.id = id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}
