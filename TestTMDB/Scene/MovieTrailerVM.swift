//
//  MovieTrailerVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire

class MovieTrailerVM: BaseVM {

    var movieId = -1
    let movieKey = LiveData("")

    func fetchMovieTrailer(movieId: Int) {
        isShowDialogLoading.value = true
        request(RestService.fetchMovieTrailer(movieId: movieId)).responseJSON { [weak self] resp in
            self?.isShowDialogLoading.value = false
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let trailers: [Trailer] = try JSONDecoder().decode([Trailer].self, from: data)

                    for trailer in trailers {
                        if trailer.site?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "youtube" {
                            self?.movieKey.value = trailer.key ?? ""
                            break
                        }
                    }
                } catch {
                    self?.toastMessage.value = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
