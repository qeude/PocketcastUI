//
//  PodcastTests.swift
//  PocketcastsTests
//
//  Created by Quentin Eude on 17/06/2021.
//

import XCTest
@testable import Pocketcasts

class PodcastTests: BaseTestCase {
  func testList() async {
    let network = Network()
    let user = await self.anyUser(network: network)
    let podcasts = try! await network.listPodcasts(with: user)
    XCTAssertNotNil(podcasts)
  }
}
