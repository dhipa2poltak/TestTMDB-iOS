//
//  MovieTrailerVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Alamofire
import Foundation
import SVProgressHUD
import YouTubePlayer

class MovieTrailerVM: BaseVM {

    var movieId = -1
    var movieKey = ""

    func fetchMovieTrailer(movieId: Int) {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieTrailer(movieId: movieId)).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json["results"].rawData(options: .prettyPrinted)

                    let trailers: [Trailer] = try JSONDecoder().decode([Trailer].self, from: data)

                    for trailer in trailers {
                        if trailer.site?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "youtube" {
                            self?.movieKey = trailer.key ?? ""
                            break
                        }
                    }

                    self?.didLayout()
                } catch {
                    SVProgressHUD.showDismissableError(with: error.localizedDescription)
                }
            }
        }
    }
}

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
