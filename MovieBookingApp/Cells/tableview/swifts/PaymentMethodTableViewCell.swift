//
//  PaymentMethodTableViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 22/02/2022.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    var data: PaymentMethodVO? {
        didSet {
            if let data = data {
                lblName.text = data.name
                lblDesc.text = data.desc
            }
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
