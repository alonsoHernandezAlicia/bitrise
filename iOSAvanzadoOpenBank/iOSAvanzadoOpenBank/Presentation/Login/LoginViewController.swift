//
//  LoginViewController.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 20/7/23.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func navigateToTabBar()
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - ViewModel
    var loginViewModel: LoginViewModel?
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
    }
    
    private func setViewModel() {
        let remoteDataSource = RemoteDataSourceImpl()
        let repository = RepositoryImpl(remoteDataSource: remoteDataSource)
        self.loginViewModel = LoginViewModel(repository: repository, loginView: self)
    }

    @IBAction func onLogin(_ sender: Any) {
        loginViewModel?.onLogin(withUser: "bejl@keepcoding.es", andPassword: "123456", testCompletion: nil)
    }
    
    func navigateToTabBar() {
        let tabBarViewController = TabBarViewController()
        navigationController?.pushViewController(tabBarViewController, animated: true)
    }
}
