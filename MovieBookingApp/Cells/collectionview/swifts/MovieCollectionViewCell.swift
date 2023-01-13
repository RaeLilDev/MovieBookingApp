//
//  MovieCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerMovie: UIView!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    var data: MovieVO? {
        didSet {
            guard let data = data else { return }
            
            lblName.text = data.originalTitle
            
            let genres = data.genres.joined(separator: "/")
            lblInfo.text = "\(genres)"
            
            let posterPath = "\(AppConstants.baseImageURL)/\(data.posterPath)"
            ivMovie.sd_setImage(with: URL(string: posterPath)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerMovie.dropShadow(color: UIColor.blue)
        
          
    }
    

}
