//
//  TicketViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 25/02/2022.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak var containerTicket: UIView!
    @IBOutlet weak var ivMovieCover: UIImageView!
    @IBOutlet weak var viewBottomSeparator: UIView!
    @IBOutlet weak var viewTopSeparator: UIView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblBookingNo: UILabel!
    @IBOutlet weak var lblShowtimeDate: UILabel!
    @IBOutlet weak var lblTheater: UILabel!
    @IBOutlet weak var lblScreen: UILabel!
    @IBOutlet weak var lblRow: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ivQRCode: UIImageView!
    
    var checkout: CheckoutVO?
    
    private let bookingRecent = BookingRecentVO.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImageView()
        
        setupNavBar()
        
        bindData()
        
        containerTicket.dropShadow(color: UIColor.gray)
        viewTopSeparator.createDottedLine(width: 1.0, color: UIColor.lightGray.cgColor)
        viewBottomSeparator.createDottedLine(width: 1.0, color: UIColor.lightGray.cgColor)
        
        
    }
    
    private func setupNavBar() {
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "cross"), style: .plain, target: self, action: #selector(btnCloseTapped))
        
    }
    
    func setUpImageView() {
        ivMovieCover.layer.cornerRadius = 16
        ivMovieCover.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    //MARK: - Bind ticket data
    private func bindData() {
        
        ivMovieCover.sd_setImage(with: URL(string: bookingRecent.posterPath ?? ""))
        
        lblMovieName.text = bookingRecent.movieName
        lblDuration.text = "\(bookingRecent.duration ?? 0) m"
        
        let startTime = bookingRecent.startTime ?? ""
        let dayMonth = bookingRecent.dayMonth ?? ""
        
        lblShowtimeDate.text = "\(startTime) - \(dayMonth)"
        
        lblTheater.text = "Galaxy Cinema - \(bookingRecent.cinemaName ?? "")"
        
        lblScreen.text = "\(bookingRecent.ticketCount ?? 0)"
        lblRow.text = bookingRecent.row
        lblSeats.text = bookingRecent.seatNames
        lblPrice.text = "$ \(bookingRecent.price ?? 0)"
        
        if let checkout = checkout {
            lblBookingNo.text = checkout.bookingNo
            let url = "\(AppConstants.BaseURL)\(checkout.qrCode.replacingOccurrences(of: " ", with: "%20"))"
            print(url)
            ivQRCode.sd_setImage(with: URL(string: url))
        }
    }
    
    //MARK: - Ontap Back
    @objc func btnCloseTapped() {
        
        navigateToRootViewController()
        
    }
    
}
