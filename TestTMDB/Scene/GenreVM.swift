//
//  GenreVM.swift
//  TestTMDB
//
//  Created by user on 03/06/21.
//

import Foundation
import Alamofire

class GenreVM: BaseVM {
    var genres: [Genre]?
    let genreData: LiveData<[Genre]?> = LiveData(nil)

    func loadData(completion _: EmptyClosure?) {
        fetchMovieGenre()
    }

    func fetchMovieGenre() {
        isShowDialogLoading.value = true
        request(RestService.fetchMovieGenre).responseJSON { [weak self] resp in
            self?.isShowDialogLoading.value = false
            resp.validate { json in
                do {
                    let data = try json["genres"].rawData(options: .prettyPrinted)

                    let genres: [Genre] = try JSONDecoder().decode([Genre].self, from: data)
                    self?.genres = genres
                    self?.genreData.value = genres
                } catch {
                    self?.toastMessage.value = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
