//
//  MockRespository.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 1/8/23.
//

import Foundation
@testable import iOSAvanzadoOpenBank


final class MockRespository: RepositoryProtocol {
    
    let loginSuccessful: Bool
    
    init(loginSuccessful: Bool = false) {
        self.loginSuccessful = loginSuccessful
    }
    
    
    func login(withUser user: String, andPassword password: String, completion: @escaping (String?, iOSAvanzadoOpenBank.NetworkError?) -> ()) {
        
        switch loginSuccessful {
        case true:
            completion("token", nil)
        case false:
            completion(nil, .other)
        }
    }
    
    func getHeroes(name: String, completion: @escaping ([iOSAvanzadoOpenBank.Hero], iOSAvanzadoOpenBank.NetworkError?) -> ()) {
        
    }
    
    func deleteToken() {
        
    }

}
