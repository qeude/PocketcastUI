//
//  Endpoint+SubscriptionStatus.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

extension Endpoint where Kind == EndpointKinds.Private, Response == [SubscriptionStatus] {
  static let listSubscriptions: Self = Endpoint(path: "subscription/status", method: .get, rootArrayElement: "subscriptions")
}
