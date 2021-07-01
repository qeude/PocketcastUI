//
//  ContentView.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    if appState.user == nil {
      LoginView()
    } else {
      HomeView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
