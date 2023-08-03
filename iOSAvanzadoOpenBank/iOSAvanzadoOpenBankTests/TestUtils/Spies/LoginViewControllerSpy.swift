//
//  LoginViewControllerSpy.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 1/8/23.
//

import Foundation
import XCTest
@testable import iOSAvanzadoOpenBank

final class LoginViewControllerSpy: LoginViewControllerProtocol {
    
    var navigateToTabBarFlag = false
    var expectation: XCTestExpectation?
    
    func navigateToTabBar() {
        navigateToTabBarFlag = true
        expectation?.fulfill()
        print("Expectation fulfilled in navigate to tab bar")
    }

}
