//
//  MovieTrailerVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation
import SVProgressHUD
import YouTubePlayer

class MovieTrailerVC: BaseVC, YouTubePlayerDelegate {

    lazy var viewModel = MovieTrailerVM()

    @IBOutlet weak var youtubePlayer: YouTubePlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupObserver()
        youtubePlayer.delegate = self
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieTrailer(movieId: viewModel.movieId)
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

        viewModel.movieKey.observe { [weak self] value in
            if !value.isEmpty {
                self?.youtubePlayer.loadVideoID(value)
            }

        }
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        youtubePlayer.play()
    }
}
