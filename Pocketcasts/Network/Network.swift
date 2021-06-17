//
//  Network.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

import Foundation

struct Network {
  private let urlSession = URLSession.shared
}

extension Network {
  func login(email: String, password: String) async throws -> User {
    let accessToken = try await urlSession.send(endpoint: .login(email: email, password: password), using: ())
    return User(email: email, accessToken: accessToken)
  }
  
  func listPodcasts(with user: User) async throws -> [Podcast] {
    return try await urlSession.send(endpoint: .listPodcasts, using: user.accesToken)
  }
  
  func listSubscription(with user: User) async throws -> [SubscriptionStatus] {
    return try await urlSession.send(endpoint: .listSubscriptions, using: user.accesToken)
  }
}
