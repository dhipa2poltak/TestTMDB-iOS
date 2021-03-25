//
//  GenreVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

import Alamofire
import SVProgressHUD
import UIKit

class GenreVM: BaseVM {
    var genres: [Genre]?

    func loadData(completion _: EmptyClosure?) {
        fetchMovieGenre()
    }

    func fetchMovieGenre() {
        SVProgressHUD.showGradient()
        request(RestService.fetchMovieGenre).responseJSON { [weak self] resp in
            SVProgressHUD.dismiss()
            resp.validate { json in
                do {
                    let data = try json["genres"].rawData(options: .prettyPrinted)

                    let genres: [Genre] = try JSONDecoder().decode([Genre].self, from: data)
                    self?.genres = genres

                    self?.didLayout()
                } catch {
                    SVProgressHUD.showDismissableError(with: error.localizedDescription)
                }
            }
        }
    }
}

class GenreVC: BaseVC {

    lazy var viewModel = GenreVM(vc: self)

    @IBOutlet weak var tableVw: UITableView!

    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self,
                     action: #selector(didRefreshControl),
                     for: .valueChanged)
        return rc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    private func setupTableView() {
        if #available(iOS 10.0, *) {
            tableVw.refreshControl = refreshControl
        } else {
            tableVw.addSubview(refreshControl)
        }

        tableVw.dataSource = self
        tableVw.delegate = self
        tableVw.backgroundColor = .clear
        tableVw.separatorStyle = .none

        //let genreTVCNib = UINib(nibName: "GenreTVC", bundle: nil)
        //tableVw.register(genreTVCNib, forCellReuseIdentifier: "GenreTVC")
    }

    override func viewDidAppear(_: Bool) {
        super.setupNavBar(transparant: true)

        viewModel.loadData(completion: nil)
    }

    @objc private func didRefreshControl() {
        viewModel.loadData(completion: nil)
    }

    @objc override func layouting(notification _: NSNotification? = nil) {
        refreshControl.endRefreshing()
        tableVw.reloadData()
    }
}

extension GenreVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.genres?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTVC") as? GenreTVC {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTVC", for: indexPath) as! GenreTVC

        if let genre = viewModel.genres?[indexPath.row] {
            cell.lblGenre.text = genre.name
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableVw.indexPath(for: tableViewCell)

        if (indexPath?.row ?? -1) != -1 {
            let genre = viewModel.genres?[indexPath!.row]

            let movieByGenreVC = segue.destination as! MovieByGenreVC
            movieByGenreVC.viewModel.genreId = genre?.id ?? -1
            movieByGenreVC.viewModel.genreName = genre?.name ?? "unknown"
        }
    }
}
