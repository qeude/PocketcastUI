//
//  BaseTestCase+User.swift
//  PocketcastsTests
//
//  Created by Quentin Eude on 17/06/2021.
//

import XCTest
@testable import Pocketcasts

extension BaseTestCase {
  func anyUser(network: Network? = nil) async -> User {
    let network = network ?? Network()
    return try! await network.login(email: ProcessInfo.processInfo.environment["POCKETCAST_EMAIL"]!, password: ProcessInfo.processInfo.environment["POCKETCAST_PASSWORD"]!)
  }
}
