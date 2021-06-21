//
//  PodcastsViewModel.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 20/06/2021.
//

import Foundation

class PodcastsViewModel: ObservableObject {
  @Published var podcasts = [Podcast]()
  
  func fetchPodcasts(with user: User) async {
    do {
      self.podcasts = try await Network.shared.listPodcasts(with: user)
    } catch {
      self.podcasts = []
    }
  }
  
}
