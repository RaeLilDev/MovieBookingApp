//
//  MBAEndpoint.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/26/22.
//

import Foundation
import Alamofire


enum MBAEndpoint: URLConvertible {
    // 1 - enum case with associated value
    
    case signIn
    case loginWithEmail
    case loginWithGoogle
    case logout
    case userProfile
    case nowShowingMovies
    case comingSoonMovies
    case movieDetail(_ id: Int)
    case cinemaList
    case cinemaDayTimeSlots(_ date: String, _ movieid: String)
    case seatPlan(_ timeSlotId: String, _ bookingDate: String)
    case snacks
    case paymentMethods
    case createCard
    case checkout
    
    
    private var baseURL: String {
        return AppConstants.BaseURL
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url: URL {
        let urlComponents = NSURLComponents(string: baseURL.appending(apiPath))
        
        return urlComponents!.url!
    }
    
    // 2 - construct api url
    private var apiPath: String {
        switch self {
            
        case .signIn:
            return "api/v1/register"
            
        case .loginWithEmail:
            return "api/v1/email-login"
            
        case .loginWithGoogle:
            return "api/v1/google-login"
            
        case .logout:
            return "api/v1/logout"
            
        case .userProfile:
            return "api/v1/profile"
            
        case .nowShowingMovies:
            return "api/v1/movies?status=current"
            
        case .comingSoonMovies:
            return "api/v1/movies?status=comingsoon"
            
        case .movieDetail(let id):
            return "api/v1/movies/\(id)"
            
        case .cinemaList:
            return "api/v1/cinemas"
            
        case .cinemaDayTimeSlots(let date, let movieId):
            return "api/v1/cinema-day-timeslots?movie_id=\(movieId)&date=\(date)"
            
        case .seatPlan(let timeSlotId, let date):
            return "api/v1/seat-plan?cinema_day_timeslot_id=\(timeSlotId)&booking_date=\(date)"
            
        case .snacks:
            return "api/v1/snacks"
            
        case .paymentMethods:
            return "api/v1/payment-methods"
            
        case .createCard:
            return "api/v1/card"
            
        case .checkout:
            return "api/v1/checkout"
            
        }
    }
}



