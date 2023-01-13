//
//  UserAuthVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/26/22.
//

import Foundation

struct UserAuthVO {
    let email: String
    let password: String
    var name: String = ""
    var phone: String = ""
    var googleAccessToken: String = ""
    var facebookAccessToken: String = ""
    
    
    func toParameters() -> [String: String] {
        return [
            "email": email,
            "password": password,
            "name": name,
            "phone": phone,
            "google-access-token": googleAccessToken,
            "facebook-access-token": facebookAccessToken
        ]
    }
}
