//
//  User.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 16/06/2021.
//

import Foundation
import CoreData
import SwiftUI

class User: NSManagedObject, Codable {
  enum CodingKeys: String, CodingKey {
    case id = "uuid"
    case accessToken = "token"
    case email
  }
  
  required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }
    
    self.init(context: context)
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    if container.contains(.email) {
      self.email = try container.decode(String.self, forKey: .email)
    }
    self.accessToken = try container.decode(String.self, forKey: .accessToken)
  }
  
  func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(email, forKey: .email)
      try container.encode(accessToken, forKey: .accessToken)
    }
}

extension User {
  static func getById(with id: UUID) -> User? {
    let request = User.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    do {
      return try PersistenceController.shared.container.viewContext.fetch(request).first
    } catch {
      return nil
    }
  }
}
