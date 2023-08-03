//
//  MockRemoteDataSource.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 31/7/23.
//

import Foundation
@testable import iOSAvanzadoOpenBank

final class MockRemoteDataSource: RemoteDataSourceProtocol {
    
    let loginSuccess: Bool
    let heroesSuccess: Bool
    
    init(loginSuccess: Bool = false, heroesSuccess: Bool = false) {
        self.loginSuccess = loginSuccess
        self.heroesSuccess = heroesSuccess
    }
    
    
    func login(withUser user: String, andPassword password: String, completion: @escaping (String?, iOSAvanzadoOpenBank.NetworkError?) -> ()) {
        switch self.loginSuccess {
        case true:
            completion("token", nil)
        case false:
            completion(nil, .other)
        }
    }
    
    func getHeroes(name: String, completion: @escaping ([iOSAvanzadoOpenBank.Hero], iOSAvanzadoOpenBank.NetworkError?) -> ()) {
        
        switch heroesSuccess {
        case true:
            completion([getEmptyStubHero()], nil)
        case false:
            completion([], .other)
        }
    }
    
    private func getEmptyStubHero() -> Hero {
        return Hero(photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")!, id: "", name: "", description: "")
    }
}
