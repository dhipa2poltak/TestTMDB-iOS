//
//  MovieByGenreVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire

class MovieByGenreVM: BaseVM {

    var movies: [Movie] = []
    let movieData: LiveData<Movie?> = LiveData(nil)

    var genreId = -1
    var genreName = ""
    var page = 1

    func fetchMovieGenre(genreId: String, page: Int) {
        isShowDialogLoading.value = true
        request(RestService.fetchMovieByGenre(genreId: genreId, page: page)).responseJSON { [weak self] resp in
            self?.isShowDialogLoading.value = false
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let movies: [Movie] = try JSONDecoder().decode([Movie].self, from: data)

                    if movies.count > 0 {
                        for movie in movies {
                            self?.movies.append(movie)
                            self?.movieData.value = movie
                        }

                        self?.page = page
                    }
                } catch {
                    self?.toastMessage.value = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
