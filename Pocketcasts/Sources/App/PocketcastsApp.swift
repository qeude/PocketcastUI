//
//  PocketcastsApp.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import SwiftUI

@main
struct PocketcastsApp: App {
  @Environment(\.scenePhase) var scenePhase
  var appState = AppState()

  let persistenceController = PersistenceController.shared
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(appState)
    }
    .onChange(of: scenePhase) { _ in
      persistenceController.save()
    }
    .windowToolbarStyle(.unified(showsTitle: false))
    .windowStyle(.titleBar)
  }
}
