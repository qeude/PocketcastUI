//
//  AppState.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
  @Published var user: User? = UserDefaults.standard.getObject(forKey: "User", castTo: User.self)
  
  func login(email: String, password: String, rememberMe: Bool = false) async {
    self.user = try? await Network.shared.login(email: email, password: password)
    if rememberMe {
      do {
        try UserDefaults.standard.setObject(self.user, forKey: "User")
      } catch {
          print(error.localizedDescription)
      }
    }
  }
  
  func logout() {
    UserDefaults.standard.removeObject(forKey: "User")
    self.user = nil
  }
}
