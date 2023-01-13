//
//  BankCardCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 25/02/2022.
//

import UIKit

class BankCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerBankCard: UIView!
    @IBOutlet weak var lblCardHolder: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblCardType: UILabel!
    
    var data: CardVO? {
        didSet {
            if let data = data {
                lblCardHolder.text = data.cardHolder
                lblExpireDate.text = data.expirationDate
                lblCardNumber.text = String(data.cardNumber.suffix(4))
                lblCardType.text = data.cardType
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    

}
