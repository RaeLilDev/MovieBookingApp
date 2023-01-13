//
//  PaymentMethodRepository.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/6/22.
//

import Foundation

protocol PaymentMethodRepository {
    func savePaymentMethods(data: [PaymentMethodVO])
    
    func getPaymentMethods(completion: @escaping ([PaymentMethodVO]) -> Void)
    
    func getCards(id: Int, completion: @escaping ([CardVO]) -> Void)
    
    func saveCard(id: Int, data: [CardVO])
}

class PaymentMethodRepositoryImpl: BaseRepository, PaymentMethodRepository {
    
    static let shared = PaymentMethodRepositoryImpl()
    
    private override init() { }
    
    func savePaymentMethods(data: [PaymentMethodVO]) {
        
        do {
            try realmInstance.db.write({
                realmInstance.db.add(data, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
        
    func getPaymentMethods(completion: @escaping ([PaymentMethodVO]) -> Void) {
        
        completion(Array(realmInstance.db.objects(PaymentMethodVO.self)))
        
    }
    
    func getCards(id: Int, completion: @escaping ([CardVO]) -> Void) {
        let cardObjets = realmInstance.db.object(ofType: ProfileVO.self, forPrimaryKey: id)!.cards
        
        completion(Array(cardObjets))
    }
    
    func saveCard(id: Int, data: [CardVO]) {
        
        let cardObjets = realmInstance.db.object(ofType: ProfileVO.self, forPrimaryKey: id)!.cards
        do {
            try realmInstance.db.write({
                //realmInstance.db.add(data, update: .modified)
                cardObjets.append(data.last!)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
