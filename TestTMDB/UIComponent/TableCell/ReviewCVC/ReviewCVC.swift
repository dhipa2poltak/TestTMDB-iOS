//
//  ReviewCVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation
import UIKit

class ReviewCVC: UICollectionViewCell {

    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var ivAuthor: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!

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

    func bindData(review: Review) {
        lblContent.text = review.content

        if var avatarPath = review.author_details?.avatar_path {
            if avatarPath.starts(with: "/") {
                avatarPath.remove(at: avatarPath.startIndex)
            }

            ivAuthor.kf.setImage(with: URL(string: avatarPath))
        }

        lblAuthor.text = review.author
    }
}
