//
//  MovieDetailVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire

class MovieDetailVM: BaseVM {

    var movieId = -1
    var movieDetailsResponse: MovieDetailsResponse?

    let titleMovie = LiveData("")
    let urlImage = LiveData("")
    let descMovie = LiveData("")

    func fetchMovieDetail(movieId: Int) {
        isShowDialogLoading.value = true
        request(RestService.fetchMovieDetail(movieId: movieId)).responseJSON { [weak self] resp in
            self?.isShowDialogLoading.value = false
            resp.validate { json in
                do {
                    let data = try json.rawData(options: .prettyPrinted)

                    let response = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)
                    self?.movieDetailsResponse = response

                    self?.titleMovie.value = response.title ?? ""
                    self?.urlImage.value = Constant.IMAGE_URL_BASE_PATH + (response.posterPath ?? "")
                    self?.descMovie.value = response.overview ?? ""
                } catch {
                    self?.toastMessage.value = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
