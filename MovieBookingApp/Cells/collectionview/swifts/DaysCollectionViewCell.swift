//
//  DaysCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDayString: UILabel!
    @IBOutlet weak var lblDayNumber: UILabel!
    @IBOutlet weak var viewDays: UIStackView!
    
    var onTapDays: ((String)->Void) = {_ in}
    
    var data: DateVO? {
        didSet {
            if let data = data {
                lblDayString.text = data.dayString
                lblDayNumber.text = data.dayNumber
                if data.isSelected {
                    lblDayString.textColor = UIColor(named: "color_white")
                    lblDayNumber.textColor = UIColor(named: "color_white")
                } else {
                    lblDayString.textColor = UIColor(named: "color_transparent")
                    lblDayNumber.textColor = UIColor(named: "color_transparent")
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerGestureRecognizer()
        
        
    }
    
    private func registerGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapDayItem))
        viewDays.isUserInteractionEnabled = true
        viewDays.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func onTapDayItem() {
        onTapDays(data?.date ?? "")
    }

}
