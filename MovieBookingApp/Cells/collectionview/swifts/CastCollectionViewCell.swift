//
//  CastCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ivCast: UIImageView!
    
    var data: CastVO? {
        didSet {
            guard let data = data else { return }
            let url = "\(AppConstants.baseImageURL)/\(data.profilePath)"
            ivCast.sd_setImage(with: URL(string: url)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
