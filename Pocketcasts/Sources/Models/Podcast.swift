//
//  Podcast.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation
import CoreData

class Podcast: NSManagedObject, Decodable {
  var url: URL? {
    guard let url = URL(string: self.rawUrl ?? "") else {
      return nil
    }
    return url
  }

  var imageUrl: URL? {
    let rawUrl = "\(Network.baseImageUrl)discover/images/280/\(self.id!.uuidString.lowercased()).jpg"
    print(rawUrl)
    guard let url = URL(string: rawUrl) else {
      return nil
    }
    return url
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "uuid"
    case rawUrl = "url"
    case desc = "description"
    case title, author, unplayed, autoSkipLast, episodesSortOrder, autoStartFrom
  }
  
  required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }
    
    self.init(context: context)
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.rawUrl = try container.decode(String.self, forKey: .rawUrl)
    self.desc = try container.decode(String.self, forKey: .desc)
    self.author = try container.decode(String.self, forKey: .author)
    self.unplayed = try container.decode(Bool.self, forKey: .unplayed)
    self.autoStartFrom = try container.decode(Int64.self, forKey: .autoStartFrom)
    self.episodesSortOrder = try container.decode(Int16.self, forKey: .episodesSortOrder)
  }
}
