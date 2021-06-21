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
              item.destination.environmentObject(appState)
            } label: {
              Label(NavigationItem.name(for: item), systemImage: NavigationItem.systemImage(for: item))
            }
          }
        }
        .navigationTitle("PocketCasts")
        .listStyle(.sidebar)
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
