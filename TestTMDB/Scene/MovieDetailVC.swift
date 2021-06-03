//
//  MovieDetailVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Kingfisher
import UIKit

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

        if let posterPath = viewModel.movieDetailsResponse?.posterPath {
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
