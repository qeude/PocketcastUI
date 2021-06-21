//
//  AccessToken.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

import Foundation
struct AccessToken: Codable, Identifiable {
  let id: UUID
  let token: String
  
  enum CodingKeys: String, CodingKey {
    case id = "uuid"
    case token
  }
}
