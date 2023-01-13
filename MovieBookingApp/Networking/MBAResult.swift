//
//  MBAResult.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/26/22.
//

import Foundation

enum MBAResult<T> {
    case success(T)
    case failure(String)
}
