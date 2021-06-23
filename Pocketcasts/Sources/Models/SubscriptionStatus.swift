//
//  SubscriptionStatus.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 14/06/2021.
//

import Foundation
import CoreData

class SubscriptionStatus: NSManagedObject, Decodable {
//  let id: Int
//  let expiryDate: Date
  
  enum CodingKeys: String, CodingKey {
    case id = "index"
    case expiryDate
  }
  
  required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }
    
    self.init(context: context)
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int64.self, forKey: .id)
    self.expiryDate = try container.decode(Date.self, forKey: .expiryDate)
  }
}
