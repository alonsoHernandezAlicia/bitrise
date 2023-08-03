//
//  LoginViewModel.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 21/7/23.
//

import Foundation


final class LoginViewModel {
    
    // MARK: Properties
    private let repository: RepositoryProtocol
    private weak var loginView: LoginViewControllerProtocol?
    
    // MARK: - Init
    init(repository: RepositoryProtocol, loginView: LoginViewControllerProtocol?) {
        self.repository = repository
        self.loginView = loginView
    }
    
    // MARK: - LoginViewModelProtocol methods
    func onLogin(withUser user: String, andPassword password: String, testCompletion: ((NetworkError?) -> ())?) {
        repository.login(withUser: user, andPassword: password) { token, error in
            guard error == nil else {
                print("Don't navigate to home")
                testCompletion?(error)
                return
            }
            UserDefaultsHelper.defaults.save(user: user)
            DispatchQueue.main.async {
                self.loginView?.navigateToTabBar()
            }
        }
    }
}
