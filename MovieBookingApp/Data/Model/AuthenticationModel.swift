//
//  AuthenticationModel.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation

protocol AuthenticationModel {
    
    func signIn(userAuthInfo: UserAuthVO, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    
    func loginWithEmail(userAuthInfo: UserAuthVO, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    
    func logout(completion: @escaping (MBAResult<Bool>) -> Void)
    
    func getUserProfileInfo(completion: @escaping (MBAResult<ProfileVO>) -> Void)
    
    
    
}

class AuthenticationModelImpl: AuthenticationModel {
    
    
    private init() { }
        
    static let shared = AuthenticationModelImpl()
    let networkingAgent: MBANetworkingAgentProtocol = MBANetworkingAgent.shared
    let profileRepository: ProfileRepository = ProfileRepositoryImpl.shared
    let defaults = MBADefaults.shared
    
    
    
    func signIn(userAuthInfo: UserAuthVO, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        
        networkingAgent.signIn(authInfo: userAuthInfo) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let profileInfo = response.data!
                self.profileRepository.saveProfileInfo(profileInfo: profileInfo)
                self.defaults.saveDefaultUserToken(token: response.token!)
                self.defaults.saveDefaultUserID(id: profileInfo.id)
                completion(.success(profileInfo))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    
    func loginWithEmail(userAuthInfo: UserAuthVO, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.loginWithEmail(authInfo: userAuthInfo) { result in
            switch result {
            case .success(let response):
                let profileInfo = response.data!
                
                self.profileRepository.saveProfileInfo(profileInfo: profileInfo)
                self.defaults.saveDefaultUserToken(token: response.token!)
                self.defaults.saveDefaultUserID(id: profileInfo.id)
                completion(.success(profileInfo))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    
    
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.loginWithGoogle(token: token) { result in
            switch result {
            case .success(let response):
                let profileInfo = response.data!
                
                self.profileRepository.saveProfileInfo(profileInfo: profileInfo)
                
                self.defaults.saveDefaultUserToken(token: response.token!)
                self.defaults.saveDefaultUserID(id: profileInfo.id)
                completion(.success(profileInfo))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    
    func logout(completion: @escaping (MBAResult<Bool>) -> Void) {
        
        let token = defaults.getDefaultUserToken()
        
        networkingAgent.logout(token: token) { result in
            switch result {
            case .success(_):
                self.defaults.removeDefaultUserID()
                self.defaults.removeDefaultUserToken()
                completion(.success(true))
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    
    func getUserProfileInfo(completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.getUserProfileInfo(token: defaults.getDefaultUserToken()) { result in
            switch result {
            case .success(let response):
                self.profileRepository.saveProfileInfo(profileInfo: response)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.profileRepository.getProfileInfo(id: MBADefaults.shared.getDefaultUserID()) { result in
                completion(result)
            }
        }
        
    }
    
}
