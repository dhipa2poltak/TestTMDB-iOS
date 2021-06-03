//
//  MovieReviewVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire
import SVProgressHUD

class MovieReviewVM: BaseVM {

    var reviews: [Review] = []

    var movieId = -1
    var movieTitle = ""
    var page = 1

    func fetchMovieReviews(movieId: Int, page: Int) {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieReviews(movieId: movieId, page: page)).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let reviews: [Review] = try JSONDecoder().decode([Review].self, from: data)

                    if reviews.count > 0 {
                        for review in reviews {
                            self?.reviews.append(review)
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

