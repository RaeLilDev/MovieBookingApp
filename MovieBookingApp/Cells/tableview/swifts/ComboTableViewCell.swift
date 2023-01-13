//
//  ComboTableViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 22/02/2022.
//

import UIKit

class ComboTableViewCell: UITableViewCell {

    @IBOutlet weak var containerStepper: UIStackView!
    @IBOutlet weak var containerCount: UIView!
    @IBOutlet weak var lblSnackPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    var updateTotalPrice: (()->Void) = { }
    
    var data: SnackVO? {
        didSet {
            if let data = data {
                lblName.text = data.name
                lblDesc.text = data.desc
                lblCount.text = "\(data.count)"
                lblSnackPrice.text = "\(data.price)$"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStepper()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupStepper() {
        containerStepper.layer.borderWidth = 0.5
        containerStepper.layer.borderColor = UIColor(named: "color_gray")?.cgColor
        containerStepper.layer.cornerRadius = 4
        containerCount.layer.borderWidth = 0.5
        containerCount.layer.borderColor = UIColor(named: "color_gray")?.cgColor
    }
    
    @IBAction func onTapBtnAdd(_ sender: UIButton) {
        if let data = data {
            data.count += 1
            lblCount.text = "\(data.count)"
            updateTotalPrice()
        }
    }
    
    @IBAction func onTapBtnSubtract(_ sender: UIButton) {
        if let data = data, data.count > 0 {
            data.count -= 1
            lblCount.text = "\(data.count)"
            updateTotalPrice()
        }
    }
    
}
