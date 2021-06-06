//
//  MovieByGenreVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import UIKit
import SVProgressHUD

class MovieByGenreVC: BaseVC, UIScrollViewDelegate {

    lazy var viewModel = MovieByGenreVM()

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var movieCV: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if !viewModel.genreName.isEmpty {
            lblTitle.text = "Genre \(viewModel.genreName) Movies"
        }

        setupObserver()

        movieCV.delegate = self
        movieCV.dataSource = self
        movieCV.reloadData()
    }

    private func setupObserver() {
        viewModel.isShowDialogLoading.observe { [weak self] value in
            if value && self?.viewModel.movies.isEmpty ?? true {
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

        viewModel.movieData.observe { [weak self] value in
            if value != nil {
                self?.movieCV.reloadData()
                self?.viewModel.movieData.value = nil
            }
        }
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.fetchMovieGenre(genreId: String(viewModel.genreId), page: viewModel.page)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if distance < 200 {
            viewModel.fetchMovieGenre(genreId: String(viewModel.genreId), page: viewModel.page + 1)
        }
    }
}

extension MovieByGenreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCV.dequeueReusableCell(withReuseIdentifier: "MovieByGenreCVC", for: indexPath) as! MovieByGenreCVC

        cell.bindData(movie: viewModel.movies[indexPath.row])

        return cell
    }
}

extension MovieByGenreVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {

        return CGSize(width: movieCV.frame.size.width, height: 40)
    }
}

extension MovieByGenreVC: UICollectionViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieCVC = sender as! UICollectionViewCell
        let indexPath = movieCV.indexPath(for: movieCVC)

        if (indexPath?.row ?? -1) != -1 {
            let movie = viewModel.movies[indexPath!.row]

            let movieDetailVC = segue.destination as! MovieDetailVC
            if let movieId = movie.id {
                movieDetailVC.viewModel.movieId = movieId
            }
        }
    }
}
