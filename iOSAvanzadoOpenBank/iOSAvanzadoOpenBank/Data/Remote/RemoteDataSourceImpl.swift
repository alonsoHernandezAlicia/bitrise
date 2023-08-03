//
//  RemoteDataSourceImpl.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 21/7/23.
//



import Foundation


enum NetworkError: Error, Equatable {
    case malformedURL
    case noData
    case noUser
    case errorCode(Int?)
    case tokenFormat
    case decoding
    case other
}

final class RemoteDataSourceImpl: RemoteDataSourceProtocol {
        
    // MARK: - Properties
    private let session: URLSession
    private let server: String = "https://dragonball.keepcoding.education/"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func login(withUser user: String, andPassword password: String, completion: @escaping (String?, NetworkError?) -> ()) {
        // Basic authentication user:password -> base64
        let loginString = String(format: "%@:%@", user, password) // user:password
        // let loginString = "\(user):\(password)"
        let loginData = loginString.data(using: .utf8)
        guard let base64loginString = loginData?.base64EncodedString() else {
            return
        }
        
        // Get URL request:
        // Get URL
        guard let url = URL(string: "\(server)/api/auth/login") else {
            print("Error: invalid URL")
            return
        }
        
        // Request //  HEADER, BODY
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Post -> debería ser get
        request.setValue("Basic \(base64loginString)", forHTTPHeaderField: "Authorization")
        
        // Perform the call
        let task = session.dataTask(with: request) { data, response, error in
            // Check parameters
            guard error == nil else {
                completion(nil, .other)
                return
            }
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let
                    httpResponse = ((response) as? HTTPURLResponse),
                    httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, .errorCode(statusCode))
                return
            }
            
            
            // Get token from data
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, .tokenFormat)
                return
            }

            // YA TENEMOS EL TOKEN, PASARLO AL REPOSITORY
            completion(token, nil)
        }
        // By default task is in suspended state
        task.resume()
    }
    
    func getHeroes(name: String, completion: @escaping ([Hero], NetworkError?) -> ()) {
        // Get URL request:
        // Get URL
        guard let url = URL(string: "\(server)/api/heros/all") else {
            completion([], .malformedURL)
            return
        }
        
        guard let user = UserDefaultsHelper.defaults.readUser() else {
            completion([], .noUser)
            return
        }

        guard let tokenData = KeyChainHelper.standard.read(account: user) else {
            completion([], .tokenFormat)
            return
        }
        // Get token
        guard let token = String(data: tokenData, encoding: .utf8) else {
            completion([], .other)
            return
        }
        
        // URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Get body
        struct Body: Encodable {
            let name: String
        }
        let body = Body(name: name)
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        // Perform the call
        let task = session.dataTask(with: urlRequest) { data, response, error in
            // Check parameters
            guard error == nil else {
                completion([], .other)
                return
            }
            guard let data = data else {
                completion([], .noData)
                return
            }
            
            guard let
                    httpResponse = ((response) as? HTTPURLResponse),
                    httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion([], .errorCode(statusCode))
                return
            }
            
            
            // Get token from data
            guard let heroesResponse =  try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], .decoding)
                return
            }
            // YA TENEMOS LOS HEROES, PASARLOS AL REPOSITORY
            completion(heroesResponse, nil)
        }
        // By default task is in suspended state
        task.resume()
        
        print("Esto se ejecuta antes aunque esta después escrito")
    }
}
