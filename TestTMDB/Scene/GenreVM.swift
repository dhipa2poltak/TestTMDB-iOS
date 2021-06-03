//
//  GenreVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire
import SVProgressHUD

class GenreVM: BaseVM {
    var genres: [Genre]?

    func loadData(completion _: EmptyClosure?) {
        fetchMovieGenre()
    }

    func fetchMovieGenre() {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieGenre).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json["genres"].rawData(options: .prettyPrinted)

                    let genres: [Genre] = try JSONDecoder().decode([Genre].self, from: data)
                    self?.genres = genres

                    self?.didLayout()
                } catch {
                    SVProgressHUD.showDismissableError(with: error.localizedDescription)
                }
            }
        }
    }
}
