//
//  MovieReviewVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire

class MovieReviewVM: BaseVM {

    var reviews: [Review] = []
    let reviewData: LiveData<Review?> = LiveData(nil)

    var movieId = -1
    var movieTitle = ""
    var page = 1

    func fetchMovieReviews(movieId: Int, page: Int) {
        isShowDialogLoading.value = true
        request(RestService.fetchMovieReviews(movieId: movieId, page: page)).responseJSON { [weak self] resp in
            self?.isShowDialogLoading.value = false
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let reviews: [Review] = try JSONDecoder().decode([Review].self, from: data)

                    if reviews.count > 0 {
                        for review in reviews {
                            self?.reviews.append(review)
                            self?.reviewData.value = review
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

