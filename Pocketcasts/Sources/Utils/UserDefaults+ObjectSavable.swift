//
//  UserDefaults+ObjectSavable.swift
//  Pocketcasts
//
//  Created by Quentin Eude on 18/06/2021.
//
import Foundation

protocol ObjectSavable {
  func setObject<Object>(_ object: Object?, forKey: String) throws where Object: Encodable
  func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
  case unableToEncode = "Unable to encode object into data"
  case noValue = "No data object found for the given key"
  case unableToDecode = "Unable to decode object into given type"
  
  var errorDescription: String? {
    rawValue
  }
}

extension UserDefaults: ObjectSavable {
  func setObject<Object>(_ object: Object?, forKey: String) throws where Object: Encodable {
    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(object)
      set(data, forKey: forKey)
    } catch {
      throw ObjectSavableError.unableToEncode
    }
  }
  
  func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable {
    guard let data = data(forKey: forKey) else { return nil }
    let decoder = JSONDecoder(context: PersistenceController.shared.container.viewContext)
    do {
      let object = try decoder.decode(type, from: data)
      return object
    } catch {
      return nil
    }
  }
}
