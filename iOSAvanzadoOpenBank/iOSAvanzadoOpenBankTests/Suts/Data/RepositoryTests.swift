//
//  RepositoryTests.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 31/7/23.
//

import XCTest
@testable import iOSAvanzadoOpenBank

final class RepositoryTests: XCTestCase {
    
    
    // MARK: - Sut
    var sut: RepositoryProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        let remoteDataSource = MockRemoteDataSource() // Login and heroes success = false
        sut = RepositoryImpl(remoteDataSource: remoteDataSource)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRepository_whenLoginWithMockRemoteLoginFail_expectError() {
        
        // MAIN THREAD -> 32, 41 -> CONTINUAMOS CUANDO LA EXPECTATIVA SE CUMPLE
        // BACKROUND -> 36 - 40 -> EXPECTATIVA SE CUMPLE EN EL BACKGROUND
        // GIVEN
        let expectation = XCTestExpectation(description: "ERROR")
        
        // WHEN
        sut?.login(withUser: "", andPassword: "", completion: { token, error in
            // THEN
            XCTAssertNotNil(error, "Error must be thrown when the login is unsuccessful")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRepository_whenLoginWithMockRemoteLoginSuccess_expectToken() {
        
        // GIVEN
        let expectation = XCTestExpectation(description: "TOKEN")
        let mockRemoteDataSource = MockRemoteDataSource(loginSuccess: true)
        sut = RepositoryImpl(remoteDataSource: mockRemoteDataSource)
        
        // WHEN
        sut?.login(withUser: "", andPassword: "", completion: { token, error in
            // THEN
            XCTAssertNotNil(token, "Token must be valid")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRepository_whenGetHeroesWithMockRemoteGetHeroesFail_expectError() {
        
        // GIVEN
        let expectation = XCTestExpectation(description: "ERROR")

        // WHEN
        sut?.getHeroes(name: "", completion: { heroes, error in
            // THEN
            XCTAssertNotNil(error, "Error must be thrown when get heroes is unsuccessful")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRepository_whenGetHeroesWithMockRemoteGetHeroesSuccessful_expectHeroes() {
        
        // GIVEN
        let expectation = XCTestExpectation(description: "HEROES")

        let mockRemoteDataSource = MockRemoteDataSource(heroesSuccess: true)
        sut = RepositoryImpl(remoteDataSource: mockRemoteDataSource)
        // WHEN
        sut?.getHeroes(name: "", completion: { heroes, error in
            // THEN
            XCTAssertNotNil(heroes, "Error must be thrown when get heroes is unsuccessful")
            XCTAssertEqual(heroes.count, 1)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }

}
