//
//  RemoteDataSourceTests.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 31/7/23.
//

import XCTest
@testable import iOSAvanzadoOpenBank

final class RemoteDataSourceTests: XCTestCase {
    
    // MARK: - Sut
    var sut: RemoteDataSourceProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Configuramos el mock de URLSession
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        
        // Inyectamos la configuración nuestra al mock
        let mockURLSession = URLSession.init(configuration: configuration)
        sut = RemoteDataSourceImpl(session: mockURLSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRemoteDataSource_whenLoginWithStatusCode400_completionReturnError() throws {
        // GIVEN
        let expectation = XCTestExpectation(description: "400 ERROR")
        
        // WHEN
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        sut?.login(withUser: "", andPassword: "", completion: { token, error in
            
            switch error {
            case .errorCode(let errorCode):
                // THEN
                XCTAssertEqual(errorCode, 400, "The error has to be 400")
                expectation.fulfill()
            default:
                XCTFail("This request must throw 400 error")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 1.0)

    }
    
    func testRemoteDataSource_whenLoginWithStatusCode200_completionReturnToken() {
        // GIVEN
        let expectation = XCTestExpectation(description: "200")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let tokenData = "token".data(using: .utf8)
            return (response, tokenData)
        }
        // WHEN
        sut?.login(withUser: "", andPassword: "", completion: { token, error in
            XCTAssertEqual(token, "token")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}

