//
//  Realm.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation
import RealmSwift

class MovieBookingRealm: NSObject {
    
    static let shared = MovieBookingRealm()
    
    let db = try! Realm()
    
    override init() {
        
        super.init()
        
        print("Default Realm is at \(db.configuration.fileURL?.absoluteString ?? "undefined")")
    }
}
