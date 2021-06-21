//
//  Podcast.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation
import CoreVideo

struct Podcast: Codable, Identifiable {
  let id: UUID
  let title: String
  let author: String
  let description: String
  let rawUrl: String
  let lastEpisodePublishedDate: Date
  let unplayed: Bool
  let lastEpisodeId: UUID
  let lastEpisodePlayingStatus: Int
  let lastEpisodeArchived: Bool
  let autoSkipLast: Int
  let episodeSortOrder: Int?
  let autoStartFrom: Int
  
  var url: URL? {
    guard let url = URL(string: rawUrl) else {
      return nil
    }
    return url
  }
  
  var imageUrl: URL? {
    let rawUrl = "\(Network.baseImageUrl)discover/images/280/\(self.id.uuidString.lowercased()).jpg"
    print(rawUrl)
    guard let url = URL(string: rawUrl) else {
      return nil
    }
    return url
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "uuid"
    case lastEpisodeId = "lastEpisodeUuid"
    case rawUrl = "url"
    case lastEpisodePublishedDate = "lastEpisodePublished"
    case title, author, description, unplayed, lastEpisodePlayingStatus,
         lastEpisodeArchived, autoSkipLast, episodeSortOrder, autoStartFrom
  }
}
