//
//  PodcastsView.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 20/06/2021.
//

import SwiftUI

struct PodcastsView: View {
  @EnvironmentObject var appState: AppState
  @ObservedObject var podcastsViewModel: PodcastsViewModel = PodcastsViewModel()
  @FetchRequest(entity: Podcast.entity(), sortDescriptors: []) var podcasts: FetchedResults<Podcast>
  
  private var items: [GridItem] = [
    GridItem(.adaptive(minimum: 120, maximum: 150), spacing: 20)
  ]
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: items, alignment: .leading, spacing: 20) {
        Section(header: Text("Podcasts").font(.largeTitle).bold()) {
          ForEach(podcasts) { podcast in
            PodcastCell(podcast: podcast)
          }
        }
      }
      .padding()
    }
    .task {
      await podcastsViewModel.fetchPodcasts(with: appState.user!)
    }
  }
}

struct PodcastsView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastsView()
    }
}
