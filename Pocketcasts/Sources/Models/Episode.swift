//
//  Episode.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation
import CoreData

class Episode: NSManagedObject, Decodable {
  var url: URL? {
    guard let url = URL(string: rawUrl!) else {
      return nil
    }
    return url
  }

  var isDateLastYear: Bool {
    return Calendar.current.component(.year, from: self.publicationDate!) < Calendar.current.component(.year, from: Date())
  }

  var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = isDateLastYear ? "dd MMMM yyyy" : "dd MMMM"
    return formatter.string(from: publicationDate!)
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "uuid"
    case rawUrl = "url"
    case publicationDate = "published"
    case title, podcast
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
    self.publicationDate = try container.decode(Date.self, forKey: .publicationDate)
    self.podcast = try container.decode(Podcast.self, forKey: .podcast)
  }
}
