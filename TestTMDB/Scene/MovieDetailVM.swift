//
//  MovieDetailVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire
import SVProgressHUD

class MovieDetailVM: BaseVM {

    var movieId = -1
    var movieDetailsResponse: MovieDetailsResponse?

    func fetchMovieDetail(movieId: Int) {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieDetail(movieId: movieId)).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json.rawData(options: .prettyPrinted)

                    let response = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)
                    self?.movieDetailsResponse = response

                    self?.didLayout()
                } catch {
                    SVProgressHUD.showDismissableError(with: error.localizedDescription)
                }
            }
        }
    }
}
