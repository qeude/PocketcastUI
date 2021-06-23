//
//  VolumeSlider.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 21/06/2021.
//

import SwiftUI

struct VolumeSlider: View {
  @State private var value: Double = 0
  
  @State private var muteHovered = false
  @State private var loudHovered = false
  @State private var sliderDraging = false
    var body: some View {
      HStack {
        Button(action: {
          withAnimation {
            self.value = 0
          }
        }) {
          Image(systemName: "speaker.fill")
            .foregroundColor(muteHovered ? Color.primaryGray : Color.tertiaryGray)
            .animation(.easeIn(duration: 0.15), value: muteHovered)
        }
        .buttonStyle(.borderless)
        .onHover { isHovered in
          self.muteHovered = isHovered
        }
        
        Slider(value: $value, in: 0...100)
        
        Button(action: {
          withAnimation {
            self.value = 100
          }
        }) {
            Image(systemName: "speaker.wave.3.fill")
              .foregroundColor(loudHovered ? Color.primaryGray : Color.tertiaryGray)
              .animation(.easeIn(duration: 0.15), value: loudHovered)
        }
        .buttonStyle(.borderless)
        .onHover { isHovered in
          self.loudHovered = isHovered
        }
      }
    }
}

struct VolumeSlider_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSlider()
    }
}
