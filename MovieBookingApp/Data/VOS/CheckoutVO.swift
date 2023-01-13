//
//  CheckoutVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/10/22.
//

import Foundation

struct CheckoutVO: Codable {
    
    var bookingNo: String
    var qrCode: String
    
    
    enum CodingKeys: String, CodingKey {
        case bookingNo = "booking_no"
        case qrCode = "qr_code"
    }
    
}
