//
//  Endpoint+User.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

extension Endpoint where Kind == EndpointKinds.Public, Response == User {
  static func login(email: String, password: String) -> Self {
      Endpoint(path: "user/login", method: .post, parameters: ["email": email, "password": password])
    }
}
