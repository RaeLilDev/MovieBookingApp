//
//  MovieModel.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation

protocol MovieModel {
    
    func getNowShowingMovieList(completion: @escaping (MBAResult<[MovieVO]>) -> Void)
    
    func getComingSoonMovieList(completion: @escaping (MBAResult<[MovieVO]>) -> Void)
    
    func getMovieDetail(id: Int, completion: @escaping (MBAResult<MovieVO>) -> Void)
    
}

class MovieModelImpl: BaseModel, MovieModel {
    
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    private let contentTypeRepository: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    
    static let shared = MovieModelImpl()
    
    private override init() { }
    
    func getNowShowingMovieList(completion: @escaping (MBAResult<[MovieVO]>) -> Void) {
        
        let contentType: MovieType = .nowShowingMovies
        
        self.contentTypeRepository.getNowShowingOrUpcoming(type: contentType) {
            completion(.success($0))
        }
        
        networkAgent.getNowShowingMovieList { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                let movieObjects = data.map { $0.toMovieVO(groupType: self.contentTypeRepository.getBelongsToTypeObject(type: contentType)) }
                
                self.movieRepository.saveList(type: contentType, data: movieObjects)
                
                completion(.success(movieObjects))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
            
        }
    }
    
    
    func getComingSoonMovieList(completion: @escaping (MBAResult<[MovieVO]>) -> Void) {
        
        let contentType: MovieType = .comingSoonMovies
        
        self.contentTypeRepository.getNowShowingOrUpcoming(type: contentType) {
            completion(.success($0))
        }
        
        networkAgent.getComingSoonMovieList { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                let movieObjects = data.map { $0.toMovieVO(groupType: self.contentTypeRepository.getBelongsToTypeObject(type: contentType)) }
                
                self.movieRepository.saveList(type: contentType, data: movieObjects)
                
                completion(.success(movieObjects))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
            
//            self.contentTypeRepository.getNowShowingOrUpcoming(type: contentType) {
//                completion(.success($0))
//            }
            
        }
        
        
    }
    
    func getMovieDetail(id: Int, completion: @escaping (MBAResult<MovieVO>) -> Void) {
        
        self.movieRepository.getDetail(id: id) {
            completion($0)
        }
        
        networkAgent.getMovieDetail(id: id) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                
                let movieObject = data.toMovieVO()
                
                self.movieRepository.saveDetail(data: movieObject)
                
                completion(.success(movieObject))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
                
            }
            
//            self.movieRepository.getDetail(id: id) {
//                completion($0)
//            }
            
        }
        
    }
    
    
}
