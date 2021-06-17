//
//  Episode.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation

struct Episode: Codable, Identifiable {
  let id: UUID
  let title: String
  let rawUrl: String
  let podcast: Podcast
  let publicationDate: Date
  
  var url: URL? {
    guard let url = URL(string: rawUrl) else {
      return nil
    }
    return url
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "uuid"
    case rawUrl = "url"
    case publicationDate = "published"
    case title, podcast
  }
}
