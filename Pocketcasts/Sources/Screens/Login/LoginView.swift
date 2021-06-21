//
//  LoginView.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 17/06/2021.
//

import SwiftUI

struct MyTextFieldStyle: TextFieldStyle {
  @State var focused: Bool = true
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .textFieldStyle(.plain)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
              .stroke(focused ? Color.blue : Color.gray, lineWidth: 0.7)
        )
    }
}

struct LoginView: View {
  @EnvironmentObject var appState: AppState
  
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var rememberMe: Bool = false
  @State private var showPassword: Bool = false
  var body: some View {
    ZStack {
      Color("Background")
      VStack {
        Image("logo")
          .padding()
        TextField("Email", text: $email)
          .textFieldStyle(.roundedBorder)
          .padding()
        SecureField("Password", text: $password)
          .textFieldStyle(.roundedBorder)
          .padding()
        Toggle("Remember me", isOn: $rememberMe).padding()
        Button("Sign in") {
          async {
            await appState.login(email: email, password: password, rememberMe: rememberMe)
          }
        }
      }
    }
  
  }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
