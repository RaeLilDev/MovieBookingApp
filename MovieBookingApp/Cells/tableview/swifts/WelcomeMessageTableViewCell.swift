//
//  WelcomeMessageTableViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit
import SDWebImage

class WelcomeMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    var data: ProfileVO? {
        didSet {
            guard let data = data else { return }
            lblName.text = "Hi \(data.name)"
            print(data.name)
            
            let profilePath = "\(AppConstants.BaseURL)/\(data.profileImage)"
            
            imageViewProfile.sd_setImage(with: URL(string: profilePath))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
