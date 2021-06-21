//
//  AccountView.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 19/06/2021.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
      VStack {
        Text("Account")
        Button("Logout") {
          appState.logout()
        }
      }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
