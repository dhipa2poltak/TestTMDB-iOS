//
//  GenreTVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

import UIKit

class GenreTVC: UITableViewCell {

    @IBOutlet weak var lblGenre: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //selectionStyle = .none
    }

    func bindData(_ genre: Genre) {
        lblGenre.text = genre.name
    }
}
