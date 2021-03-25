//
//  RestService.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

import Alamofire
import Foundation
import SwiftyJSON

enum RestService: URLRequestConvertible {
    case fetchMovieGenre
    case fetchMovieByGenre(genreId: String, page: Int)
    case fetchMovieDetail(movieId: Int)
    case fetchMovieReviews(movieId: Int, page: Int)
    case fetchMovieTrailer(movieId: Int)

    public func asURLRequest() throws -> URLRequest {
        var url: URL?

        switch self {
        default:
            url = URL(string: "\(Constant.API_BASE_URL)\(path)")
        }

        if let theUrl = url {
            var urlRequest = URLRequest(url: theUrl).defaultURLRequest()
            urlRequest.httpMethod = method.rawValue
            if method == .post {
                do {
                    urlRequest.httpBody = try JSON(param).rawData(options: .prettyPrinted)
                } catch {
                    print("httpBody failed!")
                }
            }
            let encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: nil)

            return encodedURLRequest
        }

        throw NSError()
    }

    var method: HTTPMethod {
        switch self {
        case .fetchMovieGenre: return .get
        case .fetchMovieByGenre: return .get
        case .fetchMovieDetail: return .get
        case .fetchMovieReviews: return .get
        case .fetchMovieTrailer: return .get
        }
    }

    var path: String {
        switch self {
        case .fetchMovieGenre: return "genre/movie/list?api_key=\(Constant.API_KEY)"
        case let .fetchMovieByGenre(genreId: genreId, page: page):
            return "discover/movie?api_key=\(Constant.API_KEY)&with_genres=\(genreId)&page=\(page)"
        case let .fetchMovieDetail(movieId: movieId):
            return "movie/\(movieId)?api_key=\(Constant.API_KEY)&language=en-US"
        case let .fetchMovieReviews(movieId: movieId, page: page):
            return "movie/\(movieId)/reviews?api_key=\(Constant.API_KEY)&page=\(page)&language=en-US"
        case let .fetchMovieTrailer(movieId: movieId):
            return "movie/\(movieId)/videos?api_key=\(Constant.API_KEY)&language=en-US"
        }
    }

    var param: Parameters {
        let p = Parameters()

        switch self {
        default:
            break
        }

        return p
    }
}
