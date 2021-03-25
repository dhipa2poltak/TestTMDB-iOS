//
//  MovieDetailVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation
import Alamofire
import Kingfisher
import SVProgressHUD
import UIKit

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

class MovieDetailVC: BaseVC {
    lazy var viewModel = MovieDetailVM(vc: self)

    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieDetail(movieId: viewModel.movieId)
    }

    @objc override func layouting(notification _: NSNotification? = nil) {
        lblTitleMovie.text = viewModel.movieDetailsResponse?.title

        if let posterPath = viewModel.movieDetailsResponse?.poster_path {
            let urlImage = Constant.IMAGE_URL_BASE_PATH + posterPath
            ivMovie.kf.setImage(with: URL(string: urlImage))
        }

        lblDesc.text = viewModel.movieDetailsResponse?.overview
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "reviewSegue") {
            let movieReviewVC = segue.destination as! MovieReviewVC
            movieReviewVC.viewModel.movieId = viewModel.movieId
            movieReviewVC.viewModel.movieTitle = viewModel.movieDetailsResponse?.title ?? "unknown"
        } else if (segue.identifier == "trailerSegue") {
            let movieTrailerVC = segue.destination as! MovieTrailerVC
            movieTrailerVC.viewModel.movieId = viewModel.movieId
        }
    }
}
