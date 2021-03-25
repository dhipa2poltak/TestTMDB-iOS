//
//  MovieDetailsResponse.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class MovieDetailsResponse: Codable {
    let adult: Bool?
    let backdrop_path: String?
    //let belongs_to_collection: Any?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdb_id: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Float?
    let poster_path: String?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let release_date: String?
    let revenue: Int?
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let vote_average: Float?
    let vote_count: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        //case belongs_to_collection
        case budget
        case genres
        case homepage
        case id
        case imdb_id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case production_companies
        case production_countries
        case release_date
        case revenue
        case runtime
        case spoken_languages
        case status
        case tagline
        case title
        case video
        case vote_average
        case vote_count
    }

    init(
        adult: Bool?,
        backdrop_path: String?,
        //belongs_to_collection: Any?,
        budget: Int?,
        genres: [Genre]?,
        homepage: String?,
        id: Int?,
        imdb_id: String?,
        original_language: String?,
        original_title: String?,
        overview: String?,
        popularity: Float?,
        poster_path: String?,
        production_companies: [ProductionCompany]?,
        production_countries: [ProductionCountry]?,
        release_date: String?,
        revenue: Int?,
        runtime: Int?,
        spoken_languages: [SpokenLanguage]?,
        status: String?,
        tagline: String?,
        title: String?,
        video: Bool?,
        vote_average: Float?,
        vote_count: Int?
    ) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        //self.belongs_to_collection = belongs_to_collection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdb_id = imdb_id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.production_companies = production_companies
        self.production_countries = production_countries
        self.release_date = release_date
        self.revenue = revenue
        self.runtime = runtime
        self.spoken_languages = spoken_languages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}
