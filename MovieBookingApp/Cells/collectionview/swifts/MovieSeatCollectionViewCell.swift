//
//  MovieSeatCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import UIKit

class MovieSeatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewContainerMovieSeat: UIView!
    @IBOutlet weak var lblMovieSeatTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(movieSeatVO: MovieSeatVO) {
        lblMovieSeatTitle.text = movieSeatVO.symbol
        if movieSeatVO.isMovieSeatRowTitle() {
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = UIColor.white
            lblMovieSeatTitle.isHidden = false
            lblMovieSeatTitle.textColor = UIColor.black
            
        } else if movieSeatVO.isMovieSeatTaken() {
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_taken_color") ?? UIColor.gray
            lblMovieSeatTitle.isHidden = true
        } else if movieSeatVO.isMovieSeatAvailable() {
            viewContainerMovieSeat.clipsToBounds = true
            lblMovieSeatTitle.isHidden = true
            
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color") ?? UIColor.lightGray
        } else if movieSeatVO.isMovieSeatSelected() {
            viewContainerMovieSeat.clipsToBounds = true
            lblMovieSeatTitle.isHidden = false
            let seatName = movieSeatVO.seatName ?? ""
            let index = seatName.index(seatName.startIndex, offsetBy: 2) // index with an offset of 6 characters
            let seatNumber = seatName.suffix(from: index)
            lblMovieSeatTitle.text = "\(seatNumber)"
            lblMovieSeatTitle.textColor = UIColor.white
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor(named: "primary_color") ?? UIColor.lightGray
        } else {
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = UIColor.white
            lblMovieSeatTitle.isHidden = true
        }
    }

}
