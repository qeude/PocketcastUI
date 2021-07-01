//
//  AppState.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
  @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
  @Published var user: User? = nil
  @Published var playingEpisode: Episode? = nil
  
  init() {
    if isLoggedIn {
      let request = User.fetchRequest()
      do {
        let users = try PersistenceController.shared.container.viewContext.fetch(request)
        self.user = users.first
      } catch {
        print(error)
      }
    }
  }
  
  func login(email: String, password: String, rememberMe: Bool = false) async {
    self.user = try? await Network.shared.login(email: email, password: password)
    if rememberMe {
      UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
    }
  }
  
  func logout() {
    self.user = nil
    UserDefaults.standard.removeObject(forKey: "isLoggedIn")
  }
}
