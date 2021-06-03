//
//  MovieTrailerVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation
import YouTubePlayer

class MovieTrailerVC: BaseVC, YouTubePlayerDelegate {

    lazy var viewModel = MovieTrailerVM(vc: self)

    @IBOutlet weak var youtubePlayer: YouTubePlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        youtubePlayer.delegate = self
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieTrailer(movieId: viewModel.movieId)
    }

    @objc override func layouting(notification _: NSNotification? = nil) {
        if !viewModel.movieKey.isEmpty {
            youtubePlayer.loadVideoID(viewModel.movieKey)
        }
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        youtubePlayer.play()
    }
}
