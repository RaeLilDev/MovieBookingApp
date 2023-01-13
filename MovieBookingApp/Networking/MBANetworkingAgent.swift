//
//  MBANetworkingAgent.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/26/22.
//

import Foundation
import Alamofire

protocol MBANetworkingAgentProtocol {
    
    //Authentication
    
    func signIn(authInfo: UserAuthVO, completion: @escaping (MBAResult<MBAResponse<ProfileVO>>) -> Void)
    
    func loginWithEmail(authInfo: UserAuthVO, completion: @escaping (MBAResult<MBAResponse<ProfileVO>>) -> Void)
    
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<MBAResponse<ProfileVO>>) -> Void)
    
    func logout(token: String, completion: @escaping (MBAResult<MBAResponse<Bool>>) -> Void)
    
    func getUserProfileInfo(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    
    //Movies
    
    func getNowShowingMovieList(completion: @escaping (MBAResult<[Movie]>) -> Void)
    
    func getComingSoonMovieList(completion: @escaping (MBAResult<[Movie]>) -> Void)
    
    func getMovieDetail(id: Int, completion: @escaping(MBAResult<Movie>) -> Void)
    
    //Cinemas
    
    func getCinemaList(completion: @escaping (MBAResult<[CinemaVO]>) -> Void)
    
    func getCinemaDayTimeSlots(token: String, date: String, movieId: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void)
    
    func getMovieSeatPlan(token: String, slotId: String, date: String, completion: @escaping (MBAResult<[[SeatVO]]>) -> Void)
    
    //Snack
    func getSnackList(token: String, completion: @escaping (MBAResult<[SnackVO]>) -> Void)
    
    func getPaymentMethodList(token: String, completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void)
    
    //Create Card
    func createCard(token: String, card: CardVO, completion: @escaping (MBAResult<[CardVO]>) -> Void)
    
    //Checkout
    func checkout(token: String, booking: BookingVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void)
    
}

struct MBANetworkingAgent: MBANetworkingAgentProtocol {
    
    static let shared = MBANetworkingAgent()
    
    private init() { }
    
    func signIn(authInfo: UserAuthVO, completion: @escaping (MBAResult<MBAResponse<ProfileVO>>) -> Void) {
        let parameters = authInfo.toParameters()
        AF.request(MBAEndpoint.signIn, method: .post, parameters: parameters)
            .responseDecodable(of: MBAResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let data):
                    if (200..<300).contains(data.code) {
                        print(data)
                        completion(.success(data))
                    } else {
                        completion(.failure(data.message))
                    }
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<MBAResponse<ProfileVO>>) -> Void) {
            let parameters = ["access-token": token]
            
            AF.request(MBAEndpoint.loginWithGoogle, method: .post, parameters: parameters)
                .responseDecodable(of: MBAResponse<ProfileVO>.self) { response in
                    switch response.result {
                    case .success(let data):
                        
                        if (200..<300).contains(data.code){
                            print(data)
                            completion(.success(data))
                        } else {
                            completion(.failure(data.message))
                        }
                        
                        
                    case .failure(let error):
                        completion(.failure(error.localizedDescription))
                    }
                }
        }
    
    
    
    func loginWithEmail(authInfo: UserAuthVO, completion: @escaping (MBAResult<MBAResponse<ProfileVO>>) -> Void) {
        let parameters = authInfo.toParameters()
        AF.request(MBAEndpoint.loginWithEmail, method: .post, parameters: parameters).responseDecodable(of: MBAResponse<ProfileVO>.self) { response in
            switch response.result {
            case .success(let data):
                
                if (200..<300).contains(data.code){
                    print(data)
                    completion(.success(data))
                } else {
                    completion(.failure(data.message))
                }
                
            case .failure(let error):
                completion(.failure(error.localizedDescription))
                    
                    
            }
        }
    }
    
    
    func logout(token: String, completion: @escaping (MBAResult<MBAResponse<Bool>>) -> Void) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.logout, method: .post, headers: headers)
            .responseDecodable(of: MBAResponse<Bool>.self) { response in
                switch response.result {
                case .success(let data):
                    if (200..<300).contains(data.code) {
                        print("wtbug: logout: succes code in range")
                        completion(.success(data))
                    } else {
                        completion(.failure(data.message))
                    }
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
            }
        }
        
    }
    
    func getUserProfileInfo(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]

        AF.request(MBAEndpoint.userProfile, headers: headers)
            .responseDecodable(of: MBAResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getNowShowingMovieList(completion: @escaping (MBAResult<[Movie]>) -> Void) {
        AF.request(MBAEndpoint.nowShowingMovies)
            .responseDecodable(of: MBAResponse<[Movie]>.self) { response in
            switch response.result {
            case .success(let result):
                if (200..<300).contains(result.code){
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
                
            case .failure(let error):
                print("Error")
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    
    func getComingSoonMovieList(completion: @escaping (MBAResult<[Movie]>) -> Void) {
        AF.request(MBAEndpoint.comingSoonMovies)
            .responseDecodable(of: MBAResponse<[Movie]>.self) { response in
            switch response.result {
            case .success(let result):
                if (200..<300).contains(result.code){
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
                
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func getMovieDetail(id: Int, completion: @escaping(MBAResult<Movie>) -> Void) {
        AF.request(MBAEndpoint.movieDetail(id))
            .responseDecodable(of: MBAResponse<Movie>.self) { response in
                switch response.result {
                case .success(let result):
                    if (200..<300).contains(result.code) {
                        completion(.success(result.data!))
                    } else {
                        completion(.failure(result.message))
                    }
                    
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    
    func getCinemaList(completion: @escaping (MBAResult<[CinemaVO]>) -> Void) {
        AF.request(MBAEndpoint.cinemaList).responseDecodable(of: MBAResponse<[CinemaVO]>.self) { response in
            switch response.result {
            case.success(let result):
                if (200..<300).contains(result.code) {
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
                
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
            
        }
    }
    
    
    func getCinemaDayTimeSlots(token: String, date: String, movieId: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.cinemaDayTimeSlots(date, movieId), headers: headers)
            .responseDecodable(of: MBAResponse<[CinemaDayTimeSlotVO]>.self) { response in

                switch response.result {
                case .success(let result):
                    if (200..<300).contains(result.code) {
                        completion(.success(result.data!))
                    } else {
                        completion(.failure(result.message))
                    }
                    
                case .failure(let error):
                    
                    completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func getMovieSeatPlan(token: String, slotId: String, date: String, completion: @escaping (MBAResult<[[SeatVO]]>) -> Void) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.seatPlan(slotId, date), headers: headers)
            .responseDecodable(of: MBAResponse<[[SeatVO]]>.self) { response in

                switch response.result {
                case .success(let result):
                    if (200..<300).contains(result.code) {
                        completion(.success(result.data!))
                    } else {
                        completion(.failure(result.message))
                    }
                    
                case .failure(let error):
                    
                    completion(.failure(error.localizedDescription))
            }
        }
        
    }
    
    func getSnackList(token: String, completion: @escaping (MBAResult<[SnackVO]>) -> Void) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.snacks, headers: headers).responseDecodable(of: MBAResponse<[SnackVO]>.self) { response in
            switch response.result {
            case .success(let result):
                if (200..<300).contains(result.code) {
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
                
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func getPaymentMethodList(token: String, completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.paymentMethods, headers: headers).responseDecodable(of: MBAResponse<[PaymentMethodVO]>.self) { response in
            switch response.result {
            case .success(let result):
                if (200..<300).contains(result.code) {
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
                
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func createCard(token: String, card: CardVO, completion: @escaping (MBAResult<[CardVO]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let parameters = card.toParameters()
        AF.request(MBAEndpoint.createCard,
                   method: .post,
                   parameters: parameters,
                   headers: headers)
            .responseDecodable(of: MBAResponse<[CardVO]>.self) { response in
            switch response.result {
            case .success(let result):
                if (200..<300).contains(result.code) {
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
                
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    
    func checkout(token: String, booking: BookingVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.checkout,
                   method: .post,
                   parameters: booking,
                   encoder: .json,
                   headers: headers)
        .responseDecodable(of: MBAResponse<CheckoutVO>.self) { response in
            switch response.result {
            case .success(let result):
                if (200..<300).contains(result.code) {
                    completion(.success(result.data!))
                } else {
                    completion(.failure(result.message))
                }
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
}
