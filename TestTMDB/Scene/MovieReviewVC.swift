//
//  MovieReviewVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import UIKit

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
