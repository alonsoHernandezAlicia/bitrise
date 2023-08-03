//
//  RepositoryImpl.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 21/7/23.
//

import Foundation

final class RepositoryImpl: RepositoryProtocol {

    // MARK: - Properties
    private let remoteDataSource: RemoteDataSourceProtocol
    
    // MARK: - Init
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteToken), name: .deleteToken, object: nil)
    }
    
    // MARK: - Repository protocol functions
    func login(withUser user: String, andPassword password: String, completion: @escaping (String?, NetworkError?) -> ()) {
        remoteDataSource.login(withUser: user, andPassword: password) { token, error in
            // TODO: save in keychain
            guard token != nil else {
                completion(nil, error)
                return
            }
            self.save(token: token, forUser: user)
            completion(token, nil)
        }
    }
    
    func getHeroes(name: String, completion: @escaping ([Hero], NetworkError?) -> ()) {
        remoteDataSource.getHeroes(name: name, completion: completion)
    }
    
    @objc func deleteToken() {
        guard let account = UserDefaultsHelper.defaults.readUser() else { return }
        KeyChainHelper.standard.delete(account: account)
    }
    
    func save(token: String?, forUser user: String) {
        // Se obtiene el token como data, si no se puede convertir es que el string está corrupto
        guard let tokenData = token?.data(using: .utf8) else {
            print("Error converting the token to data")
            return
        }
        
        // Guardar
        KeyChainHelper.standard.save(data: tokenData, account: user)
    }
    
    func readToken(forUser user: String) -> String? {
        let savedTokenData = KeyChainHelper.standard.read(account: user)
        guard let savedTokenData else {
            print("ERROR reading")
            return nil
        }
        guard let tokenString = String(data: savedTokenData, encoding: .utf8) else {
            print("ERROR reading: data is not convertible")
            return nil
        }
        return tokenString
    }
}
