//
//  BelongsToTypeObject.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation
import RealmSwift

class BelongsToTypeObject: Object {
    
    @Persisted(primaryKey: true)
    var name: String
    
    @Persisted(originProperty: "belongsToType")
    var movies: LinkingObjects<MovieVO>
    
}
