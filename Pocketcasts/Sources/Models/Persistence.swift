//
//  Persistence.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 23/06/2021.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
      self.init()
      self.userInfo[CodingUserInfoKey.managedObjectContext] = context
    }
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

struct PersistenceController {
  // A singleton for our entire app to use
  static let shared = PersistenceController()
  
  // Storage for Core Data
  let container: NSPersistentContainer
  
  // A test configuration for SwiftUI previews
  static var preview: PersistenceController = {
    let controller = PersistenceController(inMemory: true)
    
    let user = User(context: controller.container.viewContext)
    user.id = UUID()
    user.email = "test@test.fr"
    user.accessToken = "accessToken"
    
    let subscriptionStatus = SubscriptionStatus(context: controller.container.viewContext)
    subscriptionStatus.id = 1234
    subscriptionStatus.user = user
    subscriptionStatus.expiryDate = Date(timeIntervalSince1970: TimeInterval(1908444288))
    
    for i in 0..<10 {
      let podcast = Podcast(context: controller.container.viewContext)
      podcast.id = UUID()
      podcast.title = "Podcast \(i)"
      podcast.author = "Author \(i)"
      podcast.desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Turpis egestas pretium aenean pharetra. Orci eu lobortis elementum nibh tellus molestie."
      podcast.unplayed = false
      podcast.rawUrl = "https://www.toto.fr/"
      podcast.episodesSortOrder = 2
      for j in 0..<30 {
        let episode = Episode(context: controller.container.viewContext)
        episode.id = UUID()
        episode.title = "Episode \(j)"
        episode.publicationDate = Date()
        episode.rawUrl = "https://www.toto.fr/"
        episode.podcast = podcast
      }
    }
    
    return controller
  }()
  
  
  
  // An initializer to load Core Data, optionally able
  // to use an in-memory store.
  init(inMemory: Bool = false) {
    // If you didn't name your model Main you'll need
    // to change this name below.
    container = NSPersistentContainer(name: "Main")
    
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

    
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Error: \(error.localizedDescription)")
      }
    }
  }
  
  func save() {
    let context = container.viewContext
    
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        print("Persistence, save: \(error)")
      }
    }
  }
}
