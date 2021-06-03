//
//  MovieTrailerVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire
import SVProgressHUD

class MovieTrailerVM: BaseVM {

    var movieId = -1
    var movieKey = ""

    func fetchMovieTrailer(movieId: Int) {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieTrailer(movieId: movieId)).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let trailers: [Trailer] = try JSONDecoder().decode([Trailer].self, from: data)

                    for trailer in trailers {
                        if trailer.site?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "youtube" {
                            self?.movieKey = trailer.key ?? ""
                            break
                        }
                    }

                    self?.didLayout()
                } catch {
                    SVProgressHUD.showDismissableError(with: error.localizedDescription)
                }
            }
        }
    }
}

