//
//  CinemaRepository.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/2/22.
//

import Foundation
import RealmSwift

protocol CinemaRepository {
    
    func saveCinemaList(data: [CinemaVO])
    
    func getCinemaList(completion: @escaping([CinemaVO]) -> Void)
    
    func saveCinemaDayTimeSlots(for date: String, data: [CinemaDayTimeSlotVO])
    
    func getCinemaDayTimeSlots(for date: String, completion: @escaping ([CinemaDayTimeSlotVO]) -> Void)
    
    func saveSeatPlan(slotId: String, date: String, data: [[SeatVO]])
    
    func getSeatPlan(slotId: String, date: String, completion: @escaping ([SeatVO]) -> Void)
    
}



class CinemaRepositoryImpl: BaseRepository, CinemaRepository {
    
    static let shared: CinemaRepository = CinemaRepositoryImpl()
    
    let bookingRecent = BookingRecentVO.shared
    
    private override init() { }
    
    func saveCinemaList(data: [CinemaVO]) {
        
        let objects = List<CinemaVO>()
        
        objects.append(objectsIn: data)
        
        try! realmInstance.db.write {
            realmInstance.db.add(objects, update: .modified)
        }
    }
    
    func getCinemaList(completion: @escaping ([CinemaVO]) -> Void) {
        let cinemaObjects = realmInstance.db.objects(CinemaVO.self)
        completion(Array(cinemaObjects))
    }
    
    
    func saveCinemaDayTimeSlots(for date: String, data: [CinemaDayTimeSlotVO]) {
        
        let objects = data.map { object -> CinemaDayTimeSlotVO in
            object.date = date
            object.id = "\(object.date)-\(object.cinemaId)"
            return object
        }
        do {
            try realmInstance.db.write({
                realmInstance.db.add(objects, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCinemaDayTimeSlots(for date: String, completion: @escaping ([CinemaDayTimeSlotVO]) -> Void) {
        
        let objects: [CinemaDayTimeSlotVO] = realmInstance.db.objects(CinemaDayTimeSlotVO.self)
                    .filter { $0.date == date }
        completion(objects)
    }
    
    
    func saveSeatPlan(slotId: String, date: String, data: [[SeatVO]]) {
        
        let movieID = bookingRecent.movieId ?? 0
        
        var index = 0
        
        data.forEach {
            
            bookingRecent.seatNumberPerRow = $0.count
            
            let objects = $0.map { object -> SeatVO in
                index = index + 1
                object.id = "\(slotId)-\(date)-\(movieID)-\(index)"
                object.timeSlotDateAndMovieId = "\(slotId)-\(date)-\(movieID)"
                return object
            }
            do {
                try realmInstance.db.write({
                    realmInstance.db.add(objects, update: .modified)
                })
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getSeatPlan(slotId: String, date: String, completion: @escaping ([SeatVO]) -> Void) {
        
        let movieID = BookingRecentVO.shared.movieId ?? 0
        
        let objects: [SeatVO] = realmInstance.db.objects(SeatVO.self)
            .filter { $0.timeSlotDateAndMovieId == "\(slotId)-\(date)-\(movieID)" }
        
        completion(objects)
    }
    
}
