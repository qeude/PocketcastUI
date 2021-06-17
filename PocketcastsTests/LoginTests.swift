//
//  LoginTests.swift
//  PocketcastsTests
//
//  Created by Quentin Eude on 17/06/2021.
//

import XCTest
@testable import Pocketcasts

class LoginTests: BaseTestCase {
  func testLogin() async {
    let network = Network()
    let user = try! await network.login(email: ProcessInfo.processInfo.environment["POCKETCAST_EMAIL"]!, password: ProcessInfo.processInfo.environment["POCKETCAST_PASSWORD"]!)
    XCTAssertEqual(user.email, "quentineude@gmail.com")
    XCTAssertNotNil(user.accesToken)
  }
  
  func testLoginWithWrongCredentials() async {
    let network = Network()
    do {
      _ = try await network.login(email: "toto@gmail.com", password: "toto")
      XCTFail("Expected to throw while awaiting, but succeeded")
    } catch {
      XCTAssertEqual(error as? URLSession.APIError, URLSession.APIError.unauthorized)
    }
  }
}
