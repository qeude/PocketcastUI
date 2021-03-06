//
//  Network.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

import Foundation

struct Network {
  static let baseUrl = "api.pocketcasts.com"
  static let baseImageUrl = "https://static.pocketcasts.com/"
  static let shared = Network()
  private let urlSession = URLSession.shared
}

extension Network {
  func login(email: String, password: String) async throws -> User {
    let fetchedUser = try await urlSession.send(endpoint: .login(email: email, password: password), using: ())
    fetchedUser.email = email
    PersistenceController.shared.save()
    return fetchedUser
  }
  
  func listPodcasts(with user: User) async throws -> [Podcast] {
    let podcasts = try await urlSession.send(endpoint: .listPodcasts, using: user.accessToken!)
    PersistenceController.shared.save()
    return podcasts
  }
  
  func listSubscription(with user: User) async throws -> [SubscriptionStatus] {
    var subscriptions = try await urlSession.send(endpoint: .listSubscriptions, using: user.accessToken!)
    subscriptions = subscriptions.map { subscription in
      subscription.user = user
      return subscription
    }
    PersistenceController.shared.save()
    return subscriptions
  }
}
