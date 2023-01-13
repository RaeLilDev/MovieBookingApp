//
//  MBAMBADefaults.Defaults.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation

class MBADefaults {
    
    let defaults = UserDefaults.standard
    
    static let shared = MBADefaults()
    
    func isUserLoggedIn() -> Bool {
        defaults.string(forKey: AppConstants.token) != nil
    }
    
    func saveDefaultUserToken(token: String) {
        defaults.set(token, forKey: AppConstants.token)
    }
    
    func saveDefaultUserID(id: Int) {
        defaults.set(id, forKey: AppConstants.id)
    }

    
    func getDefaultUserToken() -> String {
        defaults.string(forKey: AppConstants.token)!
    }
    
    func getDefaultUserID() -> Int {
        defaults.integer(forKey: AppConstants.id)
    }
    
    func removeDefaultUserToken() {
        defaults.removeObject(forKey: AppConstants.token)
    }
    
    func removeDefaultUserID() {
        defaults.removeObject(forKey: AppConstants.id)
    }
}
