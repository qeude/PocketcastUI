//
//  HomeView.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 18/06/2021.
//

import SwiftUI

struct HomeView: View {
  enum NavigationItem: CaseIterable {
    case podcasts
    case discover
    case releases
    case listening
    case favorites
    case account
    
    private static let imageMapping: [NavigationItem: String] = [
      .podcasts: "square.grid.2x2",
      .discover: "magnifyingglass",
      .releases: "clock",
      .listening: "play.circle",
      .favorites: "star",
      .account: "person.crop.circle"
    ]
    
    private static let nameMapping: [NavigationItem: String] = [
      .podcasts: "Podcasts",
      .discover: "Discover",
      .releases: "Releases",
      .listening: "Listening",
      .favorites: "Favorites",
      .account: "Account",
    ]
    
    @ViewBuilder var destination: some View {
      switch self {
      case .podcasts: PodcastsView()
      case .discover: Text("Discover")
      case .releases: Text("Releases")
      case .listening: Text("Listening")
      case .favorites: Text("Favorites")
      case .account: AccountView()
      }
    }
    
    static func systemImage(for item: NavigationItem) -> String {
      return imageMapping[item] ?? "list.bullet"
    }
    
    static func name(for item: NavigationItem) -> String {
      return nameMapping[item] ?? ""
    }
  }
  @EnvironmentObject var appState: AppState
  
  @State private var selection: NavigationItem? = .podcasts
  var body: some View {
    NavigationView {
      List {
        ForEach(NavigationItem.allCases, id:\.self) { item in
          NavigationLink(tag: item, selection: $selection) {
            item.destination
          } label: {
            Label(NavigationItem.name(for: item), systemImage: NavigationItem.systemImage(for: item))
          }
        }
      }
      .listStyle(.sidebar)
    }
    .toolbar {
      ToolbarItem(placement: .automatic) {
        Button(action: toggleSidebar) {
          Image(systemName: "sidebar.left")
        }
      }
      ToolbarItemGroup(placement: .status) {
        Spacer()
        HStack {
          Button(action: {
            print("back")
          }) {
            Image(systemName: "gobackward.10")
          }
          Button(action: {
            print("play")
          }) {
            Image(systemName: "play.fill")
          }
          Button(action: {
            print("forward")
          }) {
            Image(systemName: "goforward.45")
          }
        }
        Spacer()
        NowListening(episode: $appState.playingEpisode)
          .cornerRadius(2)
          .padding(EdgeInsets(top: -5, leading: 0, bottom: -5, trailing: 0))
          .frame(minWidth: 350, maxWidth: 600,  idealHeight: 50)
        Spacer()
        VolumeSlider().frame(width: 150)
        Spacer()
      }
    }
  }
  
  func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?
      .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
  }
}
struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
