//
//  UserDefaultsHelperTests.swift
//  iOSAvanzadoOpenBankTests
//
//  Created by Ismael Sabri Pérez on 31/7/23.
//

import XCTest
@testable import iOSAvanzadoOpenBank

final class UserDefaultsHelperTests: XCTestCase {
    
    var sut: UserDefaultsHelper?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserDefaultsHelper.defaults
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testUserDefaultsHelper_whenSaveAccount_readAccountReturnAccount() {
        
        // GIVEN
        sut?.save(user: "user")
        
        // WHEN
        let user = sut?.readUser()
        
        // THEN
        XCTAssertEqual(user, "user")
    }
}
