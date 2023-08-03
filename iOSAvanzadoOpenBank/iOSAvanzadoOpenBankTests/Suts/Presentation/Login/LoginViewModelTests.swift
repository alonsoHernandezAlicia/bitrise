//
//  LoginViewModelTests.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 1/8/23.
//

import XCTest
@testable import iOSAvanzadoOpenBank

final class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockRepository = MockRespository() // False por defecto
        let loginViewControllerSpy = LoginViewControllerSpy()
        sut = LoginViewModel(repository: mockRepository, loginView: loginViewControllerSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testLoginViewModel_whenLoginWithFailRepositoryResponse_expectError() throws {
        // GIVEN
        let expectation = XCTestExpectation(description: "ERROR")
        
        // WHEN
        sut?.onLogin(withUser: "", andPassword: "") { error in
            XCTAssertNotNil(error, "Error can't be nil")
            expectation.fulfill()
        }
        
        // THEN
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoginViewModel_whenLoginWithSuccessRepositoryResponse_expectNavigateToTabBarCalled() throws {
        // GIVEN
        let expectation = XCTestExpectation(description: "NAVIGATE_TO_TABBAR")
        let repository = MockRespository(loginSuccessful: true)
        let loginViewControllerSpy = LoginViewControllerSpy()
        loginViewControllerSpy.expectation = expectation
        sut = LoginViewModel(repository: repository, loginView: loginViewControllerSpy)
        
        // WHEN
        sut?.onLogin(withUser: "", andPassword: "") { error in
            
        }
        
        // THEN
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(loginViewControllerSpy.navigateToTabBarFlag)
    }
}
