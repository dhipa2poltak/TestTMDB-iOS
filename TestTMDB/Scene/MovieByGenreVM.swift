//
//  MovieByGenreVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import SVProgressHUD
import Alamofire

class MovieByGenreVM: BaseVM {

    var movies: [Movie] = []

    var genreId = -1
    var genreName = ""
    var page = 1

    func fetchMovieGenre(genreId: String, page: Int) {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieByGenre(genreId: genreId, page: page)).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let movies: [Movie] = try JSONDecoder().decode([Movie].self, from: data)

                    if movies.count > 0 {
                        for movie in movies {
                            self?.movies.append(movie)
                        }

                        self?.page = page
                    }

                    self?.didLayout()
                } catch {
                    SVProgressHUD.showDismissableError(with: error.localizedDescription)
                }
            }
        }
    }
}
