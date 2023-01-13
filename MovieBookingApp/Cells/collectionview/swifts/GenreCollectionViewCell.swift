//
//  GenreCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerGenre: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initContainerGenre()
    }
    
    func initContainerGenre() {
        containerGenre.layer.borderWidth = 0.5
        containerGenre.layer.borderColor = UIColor(named: "color_gray")?.cgColor
        containerGenre.layer.cornerRadius = 20
    }
    
    func bindData(with genreName: String) {
        lblName.text = genreName
    }

}
