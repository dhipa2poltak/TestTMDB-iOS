//
//  MovieByGenreCVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation
import UIKit

class MovieByGenreCVC: UICollectionViewCell {


    @IBOutlet weak var lblTitleMovie: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //selectionStyle = .none
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        
    }

    func bindData(movie: Movie) {
        lblTitleMovie.text = movie.title
    }
}

