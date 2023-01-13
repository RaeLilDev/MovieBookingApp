//
//  PaymentMethodModel.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/6/22.
//

import Foundation

protocol PaymentMethodModel {
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void)
    
    func getCards(completion: @escaping (MBAResult<[CardVO]>) -> Void)
    
    func createCard(card: CardVO, completion: @escaping (MBAResult<[CardVO]>) -> Void)
    
    func checkout(booking: BookingVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void)
    
}

class PaymentMethodModelImpl: BaseModel, PaymentMethodModel {
    
    static let shared = PaymentMethodModelImpl()
    
    let defaults = MBADefaults.shared
    
    private override init() { }
    
    let PaymentMethodRepository: PaymentMethodRepository = PaymentMethodRepositoryImpl.shared
    
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void) {
        
        networkAgent.getPaymentMethodList(token: defaults.getDefaultUserToken()) { result in
            switch result {
            case .success(let data):
                self.PaymentMethodRepository.savePaymentMethods(data: data)
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
            self.PaymentMethodRepository.getPaymentMethods { completion(.success($0)) }
        }
    }
    
    
    func getCards(completion: @escaping (MBAResult<[CardVO]>) -> Void) {
        self.PaymentMethodRepository.getCards(id: defaults.getDefaultUserID()) { completion(.success($0)) }
    }
    
    func createCard(card: CardVO, completion: @escaping (MBAResult<[CardVO]>) -> Void) {
        networkAgent.createCard(token: defaults.getDefaultUserToken(), card: card) { result in
            switch result {
            case .success(let data):
                self.PaymentMethodRepository.saveCard(id: self.defaults.getDefaultUserID(), data: data)
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
            self.PaymentMethodRepository.getCards(id: self.defaults.getDefaultUserID()) { completion(.success($0)) }
        }
    }
    
    
    func checkout(booking: BookingVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void) {
        networkAgent.checkout(token: defaults.getDefaultUserToken(), booking: booking) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    
}
