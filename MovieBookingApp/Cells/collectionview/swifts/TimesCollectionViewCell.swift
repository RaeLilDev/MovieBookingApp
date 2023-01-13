//
//  TimesCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContainerTime: UIView!
    @IBOutlet weak var lblNameAndTime: UILabel!
    
    var data: String? {
        didSet {
            if let data = data {
                lblNameAndTime.text = data
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewContainerTime.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewContainerTime.layer.borderWidth = 1
        
        
        
    }
//
//    private func registerGestureRecognizer() {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapContainerTime))
//        viewContainerTime.isUserInteractionEnabled = true
//        viewContainerTime.addGestureRecognizer(tapGestureRecognizer)
//    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                viewContainerTime.backgroundColor = UIColor(named: "primary_color")
                viewContainerTime.layer.borderColor = UIColor(named: "primary_color")!.cgColor
                lblNameAndTime.textColor = .white
            } else {
                viewContainerTime.backgroundColor = .clear
                viewContainerTime.layer.borderColor = UIColor.systemGray.cgColor
                lblNameAndTime.textColor = .black
            }
        }
    }
    
}
