//
//  Logo.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 22/06/2021.
//

import SwiftUI

struct Logo: View {
  @State private var foregroundColor: Color = .white
  @State private var backgroundColor: Color = .red
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        Circle().foregroundColor(backgroundColor)
        Circle()
          .trim(from: 0.25, to: 1.0)
          .stroke(lineWidth: geo.size.height * 0.10)
          .padding(geo.size.height * 0.13)
          .foregroundColor(foregroundColor)
        Circle()
          .trim(from: 0.25, to: 1.0)
          .stroke(lineWidth: geo.size.height * 0.10)
          .padding(geo.size.height * 0.29)
          .foregroundColor(foregroundColor)
      }
    }
  }
}

// MARK: Modifiers
extension Logo {
  func foreground(color: Color) -> Logo {
    var view = self
    view._foregroundColor = State(initialValue: color)
    return view
  }
  
  func background(color: Color) -> Logo {
    var view = self
    view._backgroundColor = State(initialValue: color)
    return view
  }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        Logo()
        Logo().frame(width: 200, height: 200)
        Logo().frame(width: 100, height: 100)
      }
    }
}
