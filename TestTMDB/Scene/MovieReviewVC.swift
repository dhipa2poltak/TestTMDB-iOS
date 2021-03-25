//
//  MovieReviewVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Alamofire
import Foundation
import SVProgressHUD
import UIKit

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

class MovieReviewVC: BaseVC {
    lazy var viewModel = MovieReviewVM(vc: self)

    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var reviewCV: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblTitleMovie.text = viewModel.movieTitle

        reviewCV.delegate = self
        reviewCV.dataSource = self
        reviewCV.reloadData()
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieReviews(movieId: viewModel.movieId, page: viewModel.page)
    }

    @objc override func layouting(notification _: NSNotification? = nil) {
        reviewCV.reloadData()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if distance < 200 {
            viewModel.fetchMovieReviews(movieId: viewModel.movieId, page: viewModel.page + 1)
        }
    }
}

extension MovieReviewVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCV.dequeueReusableCell(withReuseIdentifier: "reviewCVC", for: indexPath) as! ReviewCVC

        cell.bindData(review: viewModel.reviews[indexPath.row])

        return cell
    }
}

extension MovieReviewVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {

        return CGSize(width: reviewCV.frame.size.width, height: 240)
    }
}
