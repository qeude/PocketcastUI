//
//  User.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 16/06/2021.
//

import Foundation

struct User: Codable, Identifiable {
  let id: UUID
  let accesToken: String
  let email: String
  
  init(email: String, accessToken: AccessToken) {
    self.id = accessToken.id
    self.email = email
    self.accesToken = accessToken.token
  }
}
