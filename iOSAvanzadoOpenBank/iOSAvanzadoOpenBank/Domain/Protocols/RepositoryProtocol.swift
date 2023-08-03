//
//  RepositoryProtocol.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 21/7/23.
//

import Foundation

protocol RepositoryProtocol {
    func login(withUser user: String, andPassword password: String, completion: @escaping (String?, NetworkError?) -> ())
    func getHeroes(name: String, completion: @escaping ([Hero], NetworkError?) -> ())
    func deleteToken()
}
