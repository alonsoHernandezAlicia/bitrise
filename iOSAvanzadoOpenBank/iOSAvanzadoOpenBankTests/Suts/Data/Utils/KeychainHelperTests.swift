//
//  KeychainHelperTests.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 31/7/23.
//

import XCTest
@testable import iOSAvanzadoOpenBank

final class KeychainHelperTests: XCTestCase {
    
    // MARK: - Sut
    var sut: KeyChainHelper? // System Under Test
    // MARK: - Properties
    let account = "testUser"
    let testString = "test"

    // Se ejecuta siempre antes de cada test
    override func setUpWithError() throws {
        try super.setUpWithError() // Llama a setUpWithError de la clase XCTestCase
        sut = KeyChainHelper.standard
    }

    //
    override func tearDownWithError() throws {
        // Se ejecuta siempre después de cada test
        sut?.delete(account: account)
        sut = nil
        try super.tearDownWithError() // Llama a setUpWithError de la clase XCTestCase
    }

    // MARK: - Method save
    func testKeychainHelper_whenSavingPasswordAsString_readingThePasswordReturnSameString() throws {
        
        // GIVEN
        guard let dataTestString = testString.data(using: .utf8) else {
            print("Error while converting string to data in testKeychainHelper")
            XCTFail()
            return
        }

        // WHEN
        sut?.save(data: dataTestString, account: account)
        
        guard let dataReadString = sut?.read(account: account),
              let readString = String(data: dataReadString, encoding: .utf8) else {
            print("Error while converting data to string in testKeychainHelper")
            XCTFail()
            return
        }
        
        // THEN
        XCTAssertEqual(testString, readString, "Error: the string saved into keychain must must match the one that has been stored in the keychain with the same account")
    }
    
    // MARK: - Method delete
    func testKeychainHelper_whenDeletingPassword_readingReturnNil() throws {
        
        // GIVEN
        guard let dataTestString = testString.data(using: .utf8) else {
            print("Error while converting string to data in testKeychainHelper")
            XCTFail()
            return
        }
        XCTAssertEqual(sut?.read(account: account), nil, "Error: keychain must be empty at this point of the test")
        
        // WHEN
        sut?.save(data: dataTestString, account: account)
        sut?.delete(account: account)
        let dataReadString = sut?.read(account: account)

        
        // THEN
        XCTAssertNil(dataReadString, "Error: data must be nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
