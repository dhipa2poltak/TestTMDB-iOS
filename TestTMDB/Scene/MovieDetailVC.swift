//
//  MovieDetailVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Kingfisher
import UIKit
import SVProgressHUD

class MovieDetailVC: BaseVC {
    lazy var viewModel = MovieDetailVM()

    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupObserver()
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieDetail(movieId: viewModel.movieId)
    }


    private func setupObserver() {
        viewModel.isShowDialogLoading.observe { value in
            if value {
                SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: UIApplication.shared.keyWindow?.center.x ?? 0, vertical: UIApplication.shared.keyWindow?.center.y ?? 0))
                SVProgressHUD.showGradient()
            } else {
                SVProgressHUD.dismiss()
            }
        }

        viewModel.toastMessage.observe { [weak self] value in
            if !value.isEmpty {
                self?.showToast(message: value, font: .systemFont(ofSize: 12.0))
                self?.viewModel.toastMessage.value = ""
            }
        }

        viewModel.titleMovie.observe { [weak self] value in
            self?.lblTitleMovie.text = value
        }

        viewModel.urlImage.observe { [weak self] value in
            self?.ivMovie.kf.setImage(with: URL(string: value))
        }

        viewModel.descMovie.observe { [weak self] value in
            self?.lblDesc.text = value
        }
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
