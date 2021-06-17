//
//  SubscriptionStatus.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation

struct SubscriptionStatus: Codable, Identifiable {
  let id: Int
  let expiryDate: Date
  
  enum CodingKeys: String, CodingKey {
    case id = "index"
    case expiryDate
  }
}
