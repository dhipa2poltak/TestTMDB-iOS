//
//  MovieReviewVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import UIKit
import SVProgressHUD

class MovieReviewVC: BaseVC {
    lazy var viewModel = MovieReviewVM()

    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var reviewCV: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblTitleMovie.text = viewModel.movieTitle

        setupObserver()

        reviewCV.delegate = self
        reviewCV.dataSource = self
        reviewCV.reloadData()
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieReviews(movieId: viewModel.movieId, page: viewModel.page)
    }

    private func setupObserver() {
        viewModel.isShowDialogLoading.observe { [weak self] value in
            if value && self?.viewModel.reviews.isEmpty ?? true {
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

        viewModel.reviewData.observe { [weak self] value in
            if value != nil {
                self?.reviewCV.reloadData()
                self?.viewModel.reviewData.value = nil
            }
        }
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
