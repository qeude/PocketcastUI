//
//  PocketcastsApp.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import SwiftUI

@main
struct PocketcastsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowToolbarStyle(.unified(showsTitle: false))
        .windowStyle(.titleBar)
    }
}
